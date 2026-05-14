package com.acebank.lite.controllers;

import java.io.IOException;
import java.io.Serial;
import java.util.List;
import java.util.Optional;

import com.acebank.lite.dao.BankUserDao;
import com.acebank.lite.dao.BankUserDaoImpl;
import com.acebank.lite.models.LoginResult;
import com.acebank.lite.models.Transaction;
import com.acebank.lite.service.BankService;
import com.acebank.lite.service.BankServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import lombok.extern.java.Log;

@Log
@WebServlet(name = "Login", urlPatterns = "/login")
public class Login extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final BankService bankService = new BankServiceImpl();
    private final BankUserDao userDao = new BankUserDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String identifier = request.getParameter("identifier");
        String password = request.getParameter("password");
        // String rememberMe = request.getParameter("rememberMe");

        try {
            // 1. Authenticate via Service
            Optional<LoginResult> loginResultOpt = bankService.authenticate(identifier, password);

            if (loginResultOpt.isPresent()) {
                var details = loginResultOpt.get();
                int accountNo = details.accountNumber();
                HttpSession session = request.getSession(true);

                // 2. Populate Session Attributes
                session.setAttribute("accountNumber", accountNo);
                session.setAttribute("firstName", details.firstName());
                session.setAttribute("lastName", details.lastName());
                session.setAttribute("email", details.email());
                session.setAttribute("balance", details.balance());

                // 3. Fetch Transaction History for the Dashboard
                List<Transaction> statement = userDao.getStatement(accountNo);
                session.setAttribute("transactionDetailsList", statement);

                // 4. Handle "Remember Me" Cookie

                log.info("User " + accountNo + " logged in successfully.");

                // request.getRequestDispatcher("/WEB-INF/views/Home.jsp").forward(request,
                // response);

                // PRG Pattern
                // REDIRECT: Tells browser "Go to /home using GET"
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                log.warning("Authentication failed for identifier: " + identifier);
                response.sendRedirect("LoginFail.jsp");
            }
        } catch (Exception e) {
            log.severe("Login Error: \n" + e.getMessage());
            response.sendRedirect("LoginFail.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
