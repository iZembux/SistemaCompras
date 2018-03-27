<%-- 
    Actualiza el status de la requisicion cuando compras solicita una cotizacion
    status 4 ---> status 5
--%>

<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idProducto = 0;
    int nuevoStatus = 5;
    int id_cotizacion = 0;

    Mail objMail = new Mail();

    try {
        idProducto = Integer.parseInt(request.getParameter("idProducto"));
        System.out.println("Compras Cotiza Producto: " + idProducto);
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

    if (false) {
        response.sendRedirect("loginProveedor.jsp");
    } else {
        rs = st.executeQuery("select max(id_req_coti) as id from req_prod;");
        if (rs.next()) {
            id_cotizacion = rs.getInt("id");
        }

        int i = st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + ", id_req_coti = " + (id_cotizacion + 1) + " WHERE id_producto = " + idProducto + " AND id_status = 4;");
        //Envia correo a los proveedores disponibles
        for (int j = 0; j < 1; j++) {
            objMail.enviarCorreo("diego.torres@continental.com.mx", "Proveedor", "", "Grupo Continental Automotriz ha solicitado una nueva cotizacion, favor de revisarla en el sistema de compras");
        }
        response.sendRedirect("menuComprasRequisiciones.jsp");
    }

%>