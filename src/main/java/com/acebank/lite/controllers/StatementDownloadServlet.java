package com.acebank.lite.controllers;

import com.acebank.lite.models.Transaction;
import com.acebank.lite.service.BankService;
import com.acebank.lite.service.BankServiceImpl;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import lombok.extern.java.Log;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Log
@WebServlet("/downloadStatement")
public class StatementDownloadServlet extends HttpServlet {

    private final BankService bankService = new BankServiceImpl();
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountNumber") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int accountNo = (int) session.getAttribute("accountNumber");
        String firstName = (String) session.getAttribute("firstName");
        String format = request.getParameter("format");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        // Input validation
        if (format == null || fromDate == null || toDate == null || fromDate.isEmpty() || toDate.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters.");
            return;
        }

        List<Transaction> transactions = bankService.getFilteredStatement(accountNo, fromDate, toDate);

        BigDecimal totalCredit = BigDecimal.ZERO;
        BigDecimal totalDebit = BigDecimal.ZERO;

        for (Transaction t : transactions) {
            if (t.receiverAccount() != null && t.receiverAccount() == accountNo) {
                totalCredit = totalCredit.add(t.amount());
            } else if (t.senderAccount() != null && t.senderAccount() == accountNo) {
                totalDebit = totalDebit.add(t.amount());
            } else if ("DEPOSIT".equals(t.txType())) {
                totalCredit = totalCredit.add(t.amount());
            } else if ("WITHDRAWAL".equals(t.txType())) {
                totalDebit = totalDebit.add(t.amount());
            }
        }

        BigDecimal closingBalance = bankService.getBalance(accountNo);

        if ("csv".equalsIgnoreCase(format)) {
            generateCSV(response, transactions, accountNo, totalCredit, totalDebit);
        } else if ("pdf".equalsIgnoreCase(format)) {
            generatePDF(response, transactions, accountNo, firstName, fromDate, toDate, totalCredit, totalDebit,
                    closingBalance);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unsupported format.");
        }
    }

    private void generateCSV(HttpServletResponse response, List<Transaction> transactions, int accountNo,
            BigDecimal totalCredit, BigDecimal totalDebit) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=statement.csv");

        try (PrintWriter writer = response.getWriter()) {
            writer.println("Date,Type,Amount(INR),Remark,Credit/Debit");

            for (Transaction t : transactions) {
                String date = t.createdAt().format(DATE_FORMATTER);
                String type = t.txType();
                String amount = t.amount().toString();
                String remark = (t.remark() != null) ? t.remark().replace(",", " ") : ""; // Avoid CSV breaking

                String creditDebit = "";
                if (t.receiverAccount() != null && t.receiverAccount() == accountNo) {
                    creditDebit = "Credit";
                } else if (t.senderAccount() != null && t.senderAccount() == accountNo) {
                    creditDebit = "Debit";
                } else if ("DEPOSIT".equals(t.txType())) {
                    creditDebit = "Credit";
                } else if ("WITHDRAWAL".equals(t.txType())) {
                    creditDebit = "Debit";
                }

                writer.println(String.join(",", date, type, amount, remark, creditDebit));
            }

            writer.println();
            writer.println("Total Credit(INR)," + totalCredit);
            writer.println("Total Debit(INR)," + totalDebit);
        }
    }

    private void generatePDF(HttpServletResponse response, List<Transaction> transactions, int accountNo,
            String firstName, String fromDate, String toDate,
            BigDecimal totalCredit, BigDecimal totalDebit, BigDecimal closingBalance) throws IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=statement.pdf");

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Fonts
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22);
            Font subtitleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14);
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
            Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);

            // Title
            Paragraph title = new Paragraph("AceBank", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(10);
            document.add(title);

            // Statement details
            document.add(new Paragraph("Account Statement", subtitleFont));
            document.add(new Paragraph("Account Holder: " + firstName, normalFont));
            document.add(new Paragraph("Account Number: " + accountNo, normalFont));
            document.add(new Paragraph("Statement Period: " + fromDate + " to " + toDate, normalFont));
            document.add(new Paragraph(" "));

            // Transactions Table
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setWidths(new float[] { 2f, 1.5f, 1.5f, 2.5f, 1.5f });

            String[] headers = { "Date", "Type", "Amount (INR)", "Remark", "Cr/Dr" };
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, boldFont));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(5);
                table.addCell(cell);
            }

            for (Transaction t : transactions) {
                String date = t.createdAt().format(DATE_FORMATTER);
                String type = t.txType();
                String amount = t.amount().toString();
                String remark = (t.remark() != null) ? t.remark() : "";

                String creditDebit = "";
                if (t.receiverAccount() != null && t.receiverAccount() == accountNo) {
                    creditDebit = "Credit";
                } else if (t.senderAccount() != null && t.senderAccount() == accountNo) {
                    creditDebit = "Debit";
                } else if ("DEPOSIT".equals(t.txType())) {
                    creditDebit = "Credit";
                } else if ("WITHDRAWAL".equals(t.txType())) {
                    creditDebit = "Debit";
                }

                table.addCell(new Phrase(date, normalFont));
                table.addCell(new Phrase(type, normalFont));
                PdfPCell amountCell = new PdfPCell(new Phrase(amount, normalFont));
                amountCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(amountCell);
                table.addCell(new Phrase(remark, normalFont));
                table.addCell(new Phrase(creditDebit, normalFont));
            }

            document.add(table);
            document.add(new Paragraph(" "));

            // Summary
            document.add(new Paragraph("Total Credit: INR " + totalCredit, boldFont));
            document.add(new Paragraph("Total Debit: INR " + totalDebit, boldFont));
            document.add(new Paragraph("Closing Balance: INR " + closingBalance, boldFont));

            document.close();
        } catch (DocumentException e) {
            log.severe("Error generating PDF: " + e.getMessage());
            throw new IOException("Failed to generate PDF", e);
        }
    }
}
