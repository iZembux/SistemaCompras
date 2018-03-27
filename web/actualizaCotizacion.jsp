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
    int precioTotal = 0;

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
        precioTotal = Integer.parseInt(request.getParameter("nuevoStatusRequi"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();

    st.executeUpdate("update cotizacion set id_status_cotizacion = " + nuevoStatusCoti + " where id_cotizacion = " + idCotizacion + ";");
    st.executeUpdate("update req_prod rp, cotizacion c set id_status = " + nuevoStatusRequi + " where c.id_req_coti = rp.id_req_coti and c.id_cotizacion = " + idCotizacion + ";");

    response.sendRedirect("menuComprasRequisiciones.jsp");

%>