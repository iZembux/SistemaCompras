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
    int idCategoria = 0;
    int usuarioC = 0;

    Mail objMail = new Mail();

    try {
        idProducto = Integer.parseInt(request.getParameter("idProducto"));
    } catch (Exception e) {
    }
    try {
        idCategoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }
    try {
        usuarioC = Integer.parseInt(request.getParameter("usuario"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    if (false) {
        response.sendRedirect("loginProveedor.jsp");
    } else {
        //Consulta el ultimo id de cotizacion para crear uno nuevo
        rs = st.executeQuery("select max(id_req_coti) as id from req_prod;");
        if (rs.next()) {
            id_cotizacion = rs.getInt("id");
        }

        st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + ",\n"
                + "id_req_coti = " + (id_cotizacion + 1) + ", usu_compras = "+usuarioC+" WHERE id_producto = " + idProducto + "\n"
                + "AND id_status = 4;");

        //Envia correo a los proveedores disponibles
        String sql2 = "SELECT email FROM scompras.proveedores where giro = "+idCategoria+";"; 
        ps = con.prepareStatement(sql2);
        rs = ps.executeQuery();
        while (rs.next()) {
            String correo = rs.getString("email");
            objMail.enviarCorreo(correo, "Proveedor", "", "Grupo Continental Automotriz ha solicitado una nueva cotizacion, favor de revisarla en el sistema de compras");
        }
        for (int j = 0; j < 1; j++) {
        }
        response.sendRedirect("menuComprasRequisiciones.jsp");
    }

%>
