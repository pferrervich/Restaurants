package com.iesemilidarder.restaurants.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * Clase que fa request del servlet amb els parametres que li donam
 */

public class ShowRestaurantServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html");
        // Actual logic goes here.
        Restaurant rst = null;
        String id = request.getParameter("id");

        rst = ConnectDB.readRestOpi(id);
        request.setAttribute("restaurant", rst);
        request.getRequestDispatcher("restaurant.jsp").forward(request, response);



    }
}
