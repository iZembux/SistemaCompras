<%-- 
    Document   : activarUsuario
    Created on : 14/04/2018, 01:17:51 AM
    Author     : LuisMtz
--%>
<%
    HttpSession sesion = request.getSession();    
    String usuario = (String) sesion.getAttribute("usuario");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Activar usuario</title>
    </head>
    <body>
        <div style="align-content: center" class="col-sm-4">
        <h1>Tu usuario ha sido</h1>
        <img src="https://t4.ftcdn.net/jpg/00/06/32/93/240_F_6329364_xqcoIDLmrYFKXbPYcpQutOnW0So7pzDd.jpg">
        <br>
        <label><%=usuario%></label>
        </div>
    </body>
</html>
<%%>