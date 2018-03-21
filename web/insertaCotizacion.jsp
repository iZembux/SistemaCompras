<%-- 
    Document   : registration
    Created on : Feb 28, 2018, 9:14:05 AM
    Author     : user
--%>

<%@ page import ="java.sql.*" %>
<%
    int cantidad = 0;
    int credito = 0;
    int entrega = 0;
    double precio = 0;
    double iva = 0;
    double descuento = 0;
    double anticipo = 0;
    

    try {
        cantidad = Integer.parseInt(request.getParameter("cantidad"));
    } catch (Exception e) {
    }
    try {
        credito = Integer.parseInt(request.getParameter("credito"));
    } catch (Exception e) {
    }
    try {
        entrega = Integer.parseInt(request.getParameter("entrega"));
    } catch (Exception e) {
    }
    try {
        precio = Double.parseDouble(request.getParameter("precio")); 
    } catch (Exception e) {
    }
    try {
        iva = Double.parseDouble(request.getParameter("iva")); 
    } catch (Exception e) {
    }
    try {
        descuento = Double.parseDouble(request.getParameter("descuento")); 
    } catch (Exception e) {
    }
    try {
        anticipo = Double.parseDouble(request.getParameter("anticipo")); 
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

    st.executeUpdate("");
    response.sendRedirect("insertarProductoCont.jsp");

%>