package com.acebank.lite.controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lombok.extern.java.Log;

import java.io.IOException;
import java.io.Serial;

/**
 * Servlet implementation class Logout
 */
@Log
@WebServlet(name = "Logout", urlPatterns = "/logout")
public class Logout extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Destroys the session
        }
        response.sendRedirect("index.jsp?msg=logged_out");
    }
}


