<%-- 
    Actualiza el status de la requisicion cuando compras solicita una cotizacion
    status 4 ---> status 5
--%>

<%@ page import ="java.sql.*" %>
<%
    int idProducto = 0;
    int nuevoStatus = 5;

    try {
        idProducto = Integer.parseInt(request.getParameter("idProducto"));
        System.out.println("Compras Cotiza Producto: " + idProducto); 
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

    int i = st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_producto = " + idProducto + " AND id_status = 4;");
    response.sendRedirect("menuRequisiciones.jsp");

%>