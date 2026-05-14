package com.acebank.lite.controllers;

import com.acebank.lite.service.BankService;
import com.acebank.lite.service.BankServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lombok.extern.java.Log;

import java.io.IOException;

@Log
@WebServlet("/changePassword")
public class ChangePassword extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final BankService bankService = new BankServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountNumber") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountNumber") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int accountNo = (int) session.getAttribute("accountNumber");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            response.sendRedirect("ChangePassword.jsp?error=Passwords+do+not+match");
            return;
        }

        try {
            boolean success = bankService.changePassword(accountNo, oldPassword, newPassword);
            if (success) {
                // If it succeeds, redirect with success message. Usually you might invalidate session so they login again.
                // Or just show success inside the page. 
                session.invalidate();
                response.sendRedirect("ChangePassword.jsp?success=true");
            } else {
                response.sendRedirect("ChangePassword.jsp?error=Incorrect+current+password+or+update+failed.");
            }
        } catch (Exception e) {
            log.severe("Failed to change password for account=" + accountNo + ". Error: " + e.getMessage());
            response.sendRedirect("ChangePassword.jsp?error=An+unexpected+error+occurred.");
        }
    }
}
