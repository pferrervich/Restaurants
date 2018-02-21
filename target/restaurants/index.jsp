 <%@ page import="com.iesemilidarder.restaurants.web.ConnectDB" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.iesemilidarder.restaurants.web.Restaurant" %>
 <%@ page import="com.iesemilidarder.restaurants.web.LoginServlet" %>
 <%@ page import="com.iesemilidarder.restaurants.web.Users" %>
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ca">
<head>
    <title>Restaurants</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootswatch/4.0.0-beta.2/cosmo/bootstrap.min.css" rel="stylesheet" integrity="sha384-52tWTPZ1e5eK+C2aGPCgDjrEgVkKMO+0qDuRNj3tS2EugIrICHWqkGuLu442CP2S" crossorigin="anonymous">    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous"> -->
    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

<!-- Navigation bar -->
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#">Restaurants</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">Inici <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="test">Enllaç 1</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="test">Enllaç 2</a>
            </li>
                <%
                    Users user = (Users) session.getAttribute("user");



                    if(user == null){
                        out.println(
                        "<li class=\"nav-item\">" +
                                "<a class=\"nav-link\" href=\"login.jsp\">Login</a>" +
                        "</li>");

                    }else{
                        out.println(
                                "<li class=\"nav-item\">"
                                        + "<a class=\"nav-link\">" + user.getCode() + "</a>" +
                                        "</li>"+
                                        "<li class=\"nav-item\">" +
                                            "<a class=\"nav-link\" href='/logout'> Logout</a>" +
                                        "</li>"

                        );
                    }
                %>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="text" name="search" placeholder="Cercar" aria-label="Cercar">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Cercar</button>
        </form>
    </div>
</nav>

<main role="main">

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">Troba els millors restaurants de Mallorca</h1>
            <p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
            <p><a class="btn btn-primary btn-lg" href="test" role="button">Learn more &raquo;</a></p>
        </div>
    </div>

    <div class="container">
        <%
            /**
            * Crea l'objecte per connectar la base de dades
            */
            ConnectDB connectDB = new ConnectDB();


            /**
            * Crea un arraylist que fa request als restaurant que li donem al parametre de cerca
            * Crea un iterador
            */
            ArrayList al = connectDB.readRestaurant(request.getParameter("search"));
            Iterator itr = al.iterator();

            /**
            * While que mentre el iterador tengui valors, mostrara els restaurants
            */
            while (itr.hasNext()) {
                Restaurant rst = (Restaurant) itr.next();
                out.println(
                        "<div class=\"row\"> " +
                                "<div class=\"col-md-4\">" +
                                    "<img class=\"img-fluid\" src=" + rst.getImgurl() + ">" +
                                "</div>"+
                            "<div class=\"col-md-8\">"+
                                "<h2>" + rst.getName() + "</h2>" +
                                "<hr>" +
                                "<p>Tipus: " + rst.getType() + "</p>"+
                                "<p>Pagina Web: " + rst.getWebsite() + "</p>"+
                                "<p>Adreça: " + rst.getAddress() + "</p>"+
                                "<p>Telefon: " + rst.getTelephone() + "</p>"+
                                "<p><a class=\"btn btn-secondary\" href=\"/restaurant?id="+rst.getCodi()+"\" role=\"button\">Més informació &raquo;</a></p>"+
                                "</div>" +
                                "</div>"

                );

            }

        %>

</main>

<footer class="container">
    <p>&copy; Pau Ferrer Vich 2017</p>
</footer>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
</body>
</html>
