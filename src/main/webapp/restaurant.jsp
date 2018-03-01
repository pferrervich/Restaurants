 <%@ page import="com.iesemilidarder.restaurants.web.ConnectDB" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.iesemilidarder.restaurants.web.Restaurant" %>
 <%@ page import="com.iesemilidarder.restaurants.web.Opinion" %>
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
    <meta name="author" content="">
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootswatch/4.0.0-beta.2/cosmo/bootstrap.min.css" rel="stylesheet" integrity="sha384-52tWTPZ1e5eK+C2aGPCgDjrEgVkKMO+0qDuRNj3tS2EugIrICHWqkGuLu442CP2S" crossorigin="anonymous">    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous"> -->
    <!-- Custom styles for this template -->
    <link href="css/style.css" type="text/css" rel="stylesheet">
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
                /**
                 *Treu el nom del usuari de la sessio i si es valid, mostrara el seu nom i un boto per fer logout
                 */
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
            * Crea l'objecte de restaurant i fa request del atribut "restaurant"
            */
            Restaurant rst = (Restaurant) request.getAttribute("restaurant");

            /**
            * Crea un iterador en base a les opinions del onjecte de restaurants
            */
            Iterator itr = rst.getOpinion().iterator();

            /**
            * Si l'objecte rst no es nul, mostrara els valors dels restaurants, mentres que si es nul, mostrara un error
            */
            if (rst != null) {
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
                            "</div>" +
                        "</div>"
                );

                /**
                * While que si mentres l'iterador tengui valors, mostrara les opinions dels restaurants
                */
                while (itr.hasNext()){
                    Opinion opi = (Opinion) itr.next();
                    out.println(
                            "<div class=\"box\">" +
                                opi.getDescription() +
                            "</div>"
                    );
                }
            }else{
                out.println("ERROR: No s'ha trobat el restaurant");
            };


        %>



        <%
        /**
        * Comprova si la sessio esta iniciada, treguent l'atribut del usuari i si no es null, mostrara el formulari per
        * inserir els comentaris.
        */

        HttpSession loginSession = request.getSession(false);
        if (session == null || loginSession.getAttribute("user") == null){
            out.println("<h2>Inicia sessió per comentar</h2>\n");
        }else {
            out.println(
                "<div class=\"form-control\">\n" +
                "<form action=\"comment\" >\n" +
                "<h2>Inserta el teu comentari</h2>\n" +
                "<p> Comentari: "+
                "<textarea class='form-control' placeholder='Introdueix el teu comentari' name='comment' rows='3'></textarea>" +
                "<input type='hidden' name='code' value='"+rst.getCodi()+"'>"+

                "</p>" +
                "<p> Valoració:" +
                "<select name='score'>\n" +
                    "<option value=\"0\">0</option>\n" +
                    "<option value=\"1\">1</option>\n" +
                    "<option value=\"2\">2</option>\n" +
                    "<option value=\"3\">3</option>\n" +
                    "<option value=\"4\">4</option>\n" +
                    "<option value=\"5\">5</option>\n" +
                    "<option value=\"6\">6</option>\n" +
                    "<option value=\"7\">7</option>\n" +
                    "<option value=\"8\">8</option>\n" +
                    "<option value=\"9\">9</option>\n" +
                    "<option value=\"10\">10</option>\n" +
                "</select>" +
                "</p>" +
                "<input type=\"submit\" value=\"Submit\">\n" +
                "</form>\n" +
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
