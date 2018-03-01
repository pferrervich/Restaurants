package com.iesemilidarder.restaurants.web;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Classe que s'encarrega dels comentaris de la pagina. Fa request dels parametres del formulari, i els passa a Strings,
 * per despres emprar-ho al metode setComment de ConnectDB per fer l'INSERT.
 * Seguidament, redirecciona a la pàgina del restaurant.
 */

public class CommentServlet extends HttpServlet{
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        this.doPost(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");
        HttpSession session = req.getSession();
        Users usr = (Users) session.getAttribute("user");

        String user = usr.getCode();
        String comment = req.getParameter("comment");
        String score = req.getParameter("score");
        String restCode = req.getParameter("code");

        ConnectDB connDB = new ConnectDB();
        connDB.setComment(user, comment, score, restCode);
        resp.sendRedirect(req.getContextPath() + "/restaurant?id=" + req.getParameter("code"));

    }

}


