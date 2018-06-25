<%-- 
    Actualiza el status de la requisicion cuando compras solicita una cotizacion
    status 4 ---> status 5
--%>

<%@page import="model.CotizacionRequisicion"%>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int nuevoStatusRequi = 0;
    int nuevoStatusCoti = 0;
    int idCotizacion = 0;
    int idUsu = 0;
    double cantidad = 0;
    double precio = 0;
    double iva = 0;
    double total = 0;
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
        idUsu = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }
    try {
        observaciones = request.getParameter("observaciones");
    } catch (Exception e) {
    }

    int id_categoria = 0;
    try {
        id_categoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {

    }

    ArrayList<CotizacionRequisicion> arrayRequis = new ArrayList<CotizacionRequisicion>();
    Consultas obj = new Consultas();
    arrayRequis = obj.consultarCotizaciones(idCotizacion);
    if (arrayRequis.size() > 0) {
        cantidad = arrayRequis.get(0).getCantidad();
        precio = arrayRequis.get(0).getPrecio();
        iva = arrayRequis.get(0).getIva();
        total = ((precio + iva) * cantidad);
    }

    if (total < 5000) {
        nuevoStatusRequi = 10;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();

    st.executeUpdate("update cotizacion set id_status_cotizacion = " + nuevoStatusCoti + ", observaciones = '" + observaciones + "',\n"
            + "aut_compras = " + idUsu + ", fecha_aut_compras = CURRENT_TIMESTAMP where id_cotizacion = " + idCotizacion + ";");
    st.executeUpdate("update req_prod rp, cotizacion c set id_status = " + nuevoStatusRequi + ", id_cot_ganadora = " + idCotizacion + " where c.id_req_coti = rp.id_req_coti and c.id_cotizacion = " + idCotizacion + ";");

    //Envia Correo a Gerente Admin
    response.sendRedirect("menuComprasCotizaciones.jsp?categoria="+id_categoria+"");
%>