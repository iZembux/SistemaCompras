
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idRequi = 0;
    int nuevoStatus = 0;

    Mail objMail = new Mail();

    try {
        idRequi = Integer.parseInt(request.getParameter("idRequi"));
        System.out.println(idRequi);
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
        System.out.println(nuevoStatus);
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_requisicion = " + idRequi + ";");

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
    response.sendRedirect("menuRequisicionesProveedor.jsp");

%>