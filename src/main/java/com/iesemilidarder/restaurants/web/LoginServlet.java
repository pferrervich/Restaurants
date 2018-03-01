package com.iesemilidarder.restaurants.web;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    /**
     * Estableix la sessió a partir dels parametres que se li donen al formulari de login.jsp
     * @param req request
     * @param resp response
     * @throws ServletException excepcio
     * @throws IOException excepcio
     */

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");

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
