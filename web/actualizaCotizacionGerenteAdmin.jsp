<%-- 
    Actualiza el status de la requisicion cuando compras solicita una cotizacion
    status 4 ---> status 5
--%>

<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int nuevoStatusRequi = 0;
    int nuevoStatusCoti = 0;
    int idCotizacion = 0;
    int redirecciona = 0;
    int idUsu = 0;
    String observaciones = null;

    Mail objMail = new Mail();

    try {
        nuevoStatusRequi = Integer.parseInt(request.getParameter("nuevoStatusRequi"));
    } catch (Exception e) {
    }
    try {
        nuevoStatusCoti = Integer.parseInt(request.getParameter("nuevoStatusCoti"));
    } catch (Exception e) {
    }
    try {
        idCotizacion = Integer.parseInt(request.getParameter("cotiSelccionada"));
    } catch (Exception e) {
    }
    try {
        observaciones = request.getParameter("observaciones");
    } catch (Exception e) {
    }
    try {
        idUsu = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    //Autorizacion de nivel 1
    st.executeUpdate("update cotizacion set id_status_cotizacion = " + nuevoStatusCoti + ", observaciones = '" + observaciones + "', aut_nivel1 = " + idUsu + ",fecha_aut_nivel1 = CURRENT_TIMESTAMP\n"
            + "where id_cotizacion = " + idCotizacion + ";");
    st.executeUpdate("update req_prod rp, cotizacion c set id_status = " + nuevoStatusRequi + " where c.id_req_coti = rp.id_req_coti and c.id_cotizacion = " + idCotizacion + ";");

    //Envia Correo Depto. Compras
    String sql2 = "SELECT correo, nombre, apellido FROM scompras.usuario where id_departamento = 7;";
    ps = con.prepareStatement(sql2);
    rs = ps.executeQuery();
    while (rs.next()) {
        String correo = rs.getString("correo");
        String nombre = rs.getString("nombre");
        String apellido = rs.getString("apellido");
        objMail.enviarCorreo(correo, nombre, apellido, "Cotizacion " + idCotizacion + " autorizada por el gerente administrativo");
    }
    
     //Falta correo si es necesario al Director Admin
     
    response.sendRedirect("menuAutorizaCoti.jsp");
%>