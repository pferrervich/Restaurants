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

</head>
<body>

<form action="login" method="POST">
    Nom:<br>
    <input type="text" name="user">
    <br>
    Contrasenya:<br>
    <input type="password" name="password">
    <br><br>
    <input type="submit" value="login">
</form>
</body>
</html>
