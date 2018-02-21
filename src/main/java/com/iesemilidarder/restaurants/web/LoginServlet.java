package com.iesemilidarder.restaurants.web;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        String user = req.getParameter("user");
        String pass = req.getParameter("password");
        Users users = ConnectDB.readLogin(user,pass);



        if(users == null){
            RequestDispatcher reqDis;
            req.setAttribute("Fail", true);
            reqDis = this.getServletContext().getRequestDispatcher("/");
            reqDis.forward(req, resp);

        }else{
            HttpSession session = req.getSession();
            session.setAttribute("user", users);
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}

/**
 * https://www.studytonight.com/servlet/login-system-example-in-servlet.php
 */
