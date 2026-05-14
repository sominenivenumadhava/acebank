package com.acebank.lite.controllers;

import com.acebank.lite.service.BankService;
import com.acebank.lite.service.BankServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.extern.java.Log;

import java.io.IOException;

@Log
@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final BankService bankService = new BankServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        try {
            boolean success = bankService.recoverAccount(email);
            if (success) {
                response.sendRedirect("ForgotPassword.jsp?sent=true");
            } else {
                response.sendRedirect("ForgotPassword.jsp?error=Account+not+found+or+recovery+failed.");
            }
        } catch (Exception e) {
            log.severe("Failed recovery for email=" + email + ". Error: " + e.getMessage());
            response.sendRedirect("ForgotPassword.jsp?error=An+unexpected+error+occurred.");
        }
    }
}
