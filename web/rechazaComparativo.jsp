
<%@page import="model.CotizacionRequisicion"%>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int nuevoStatusRequi = 0;
    int nuevoStatusCoti = 0;
    int idCotizacion = 0;
    int idCotizaciones = 0;
    int idUsu = 0;
    int idCuadro = 0;
    double cantidad = 0;
    double precio = 0;
    double iva = 0;

    int tam = 0;
    int seleccionada = 0;
    
    String comentarioCancela = "";

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
        comentarioCancela = request.getParameter("comentarioCancela");
    } catch (Exception e) {
    }

    try {
        tam = Integer.parseInt(request.getParameter("tamano"));
    } catch (Exception e) {
    }

    try {
        idCuadro = Integer.parseInt(request.getParameter("idCuadroCancela"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    PreparedStatement ps;
    ResultSet rs;

    System.out.println("====================================== CANCELACION DE CUADRO ======================================");
    System.out.println("ID CUADRO: " + idCuadro);
    System.out.println("COMENTARIO: " + comentarioCancela);

    
    st.executeUpdate("UPDATE scompras.req_prod rp, scompras.cotizacion c SET rp.id_cuadro = null, rp.id_status = 6, c.id_status_cotizacion = 1, c.aut_nivel1 = null, c.aut_nivel2 = null, c.aut_nivel3 = null, c.aut_nivel4 = null, rp.rechazoC = '"+comentarioCancela+"' WHERE rp.id_req_coti = c.id_req_coti AND c.id_cotizacion IN (SELECT  idcotizacion FROM scompras.comparativos WHERE idcuadro = "+idCuadro+");");
    
    String sql2 = "SELECT correo, nombre, apellido FROM scompras.usuario where id_usuario = 268;";
    ps = con.prepareStatement(sql2);
    rs = ps.executeQuery();
    while (rs.next()) {
        String correo = rs.getString("correo");
        String nombre = rs.getString("nombre");
        String apellido = rs.getString("apellido");
        objMail.enviarCorreo(correo, nombre, apellido, "Su comparativo ha sido rechazado, por favor atienda los comentarios");
    }
    

    System.out.println("------------------------------------------------------------");
    //Envia Correo
    response.sendRedirect("menuComprasOrdenesAdminCompras.jsp");
%>