<%-- 
    Document   : registration
    Created on : Feb 28, 2018, 9:14:05 AM
    Author     : Diego
--%>

<%@ page import ="java.sql.*" %>
<%
    String nombre = request.getParameter("nombre");    
    String apellido = request.getParameter("apellido");
    String correo = request.getParameter("correo");
    String pass = request.getParameter("pass");
    String sucursal = request.getParameter("sucursal");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras","root", "stmsc0nt");
    Statement st = con.createStatement();

    int i = st.executeUpdate("insert into usuarios(nombre, apellido, correo, pass, sucursal, fecha) "
            + "values ('" + nombre + "','" + apellido + "','" + correo + "','" + pass + "','" + sucursal + "', CURDATE())");
    if (i > 0) {
        session.setAttribute("userid", nombre);
        response.sendRedirect("compras.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%>