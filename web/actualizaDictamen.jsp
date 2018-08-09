
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idReqProd = 0;
    int nuevoStatus = 0;
    int redic = 0;

    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }
    try {
        redic = Integer.parseInt(request.getParameter("redic"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    PreparedStatement ps;
    ResultSet rs;

    Mail objMail = new Mail();

    st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_req_prod = " + idReqProd + ";");

    if (nuevoStatus != 4) {
        String sql2 = "SELECT correo, nombre, apellido FROM scompras.usuario where id_rol = 3 and id_departamento = 23;";
        ps = con.prepareStatement(sql2);
        rs = ps.executeQuery();
        while (rs.next()) {
            String correo = rs.getString("correo");
            String nombre = rs.getString("nombre");
            String apellido = rs.getString("apellido");
            objMail.enviarCorreo(correo, nombre, apellido, "Hay un nuevo dictamen por revisar");
        }
    }

    if (redic == 1) {
        response.sendRedirect("menuAutorizaDictamen.jsp");
    } else {
        response.sendRedirect("menuDictamen.jsp");
    }
%>