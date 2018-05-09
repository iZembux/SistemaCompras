
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idReqProd = 0;
    int nuevoStatus = 0;
    int tam = 0;

    Mail objMail = new Mail();

    try {
        tam = Integer.parseInt(request.getParameter("tam"));
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    for (int i = 0; i < tam; i++) {
        try {
            idReqProd = Integer.parseInt(request.getParameter("idReqProd" + i)); 
            st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_req_prod = " + idReqProd + ";");
        } catch (Exception e) {
        }
    }

    //Depto. Compras
    String sql2 = "SELECT correo, nombre, apellido FROM scompras.usuario where id_departamento = 7;";
    ps = con.prepareStatement(sql2);
    rs = ps.executeQuery();
    while (rs.next()) {
        String correo = rs.getString("correo");
        String nombre = rs.getString("nombre");
        String apellido = rs.getString("apellido");
        objMail.enviarCorreo(correo, nombre, apellido, "El proveedor ha iniciado envio de productos");
    }
    response.sendRedirect("menuOrdenesProveedor.jsp");

%>