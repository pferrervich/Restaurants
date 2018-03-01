<%--
  Created by IntelliJ IDEA.
  User: poh
  Date: 7/02/18
  Time: 19:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login page</title>
    <!-- Bootstrap -->
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <!-- CSS in /css -->
    <link rel="stylesheet" type="text/css" href="./css/loginStyle.css">
</head>
<body>

<!-- Formulari per fer login -->

<div class="container">

    <div class="row" style="margin-top:20px">
        <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
            <form action="login" method="POST" role="form">
                <fieldset>
                    <h2>Per favor, entra amb el teu usuari</h2>
                    <hr class="colorgraph">
                    <div class="form-group">
                        <input type="text" name="user" id="user" class="form-control input-lg" placeholder="Nom d'usuari">
                    </div>
                    <div class="form-group">
                        <input type="password" name="password" id="password" class="form-control input-lg" placeholder="Contrasenya">
                    </div>
                    <span class="button-checkbox">
					<!--<button type="button" class="btn" data-color="info">Remember Me</button>
                        <input type="checkbox" name="remember_me" id="remember_me" checked="checked" class="hidden">
					<a href="" class="btn btn-link pull-right">Forgot Password?</a> -->
				</span>
                    <hr class="colorgraph">
                    <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-6">
                                <input type="submit" class="btn btn-lg btn-success btn-block" value="Login">
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <a href="" class="btn btn-lg btn-primary btn-block">Register</a>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>

</div>
</body>
</html>
<!-- https://bootsnipp.com/snippets/featured/mix-amp-match-login -->