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
    int redirecciona = 0;
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
        redirecciona = Integer.parseInt(request.getParameter("redirecciona"));
    } catch (Exception e) {
    }
    try {
        observaciones = request.getParameter("observaciones");
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
    ResultSet rs;
    PreparedStatement ps;

    st.executeUpdate("update cotizacion set id_status_cotizacion = " + nuevoStatusCoti + ", observaciones = '" + observaciones + "' where id_cotizacion = " + idCotizacion + ";");
    st.executeUpdate("update req_prod rp, cotizacion c set id_status = " + nuevoStatusRequi + " where c.id_req_coti = rp.id_req_coti and c.id_cotizacion = " + idCotizacion + ";");

    //Depto. Compras
    String sql2 = "SELECT correo, nombre, apellido FROM scompras.usuario where id_departamento = 7;";
    ps = con.prepareStatement(sql2);
    rs = ps.executeQuery();
    while (rs.next()) {
        String correo = rs.getString("correo");
        String nombre = rs.getString("nombre");
        String apellido = rs.getString("apellido");
        if (nuevoStatusRequi == 8) {
            objMail.enviarCorreo(correo, nombre, apellido, "Cotizacion autorizada por el gerente administrativo");
        } else if (nuevoStatusRequi == 9) {
            objMail.enviarCorreo(correo, nombre, apellido, "Cotizacion autorizada por el director administrativo");
        } else if (nuevoStatusRequi == 10) {
            objMail.enviarCorreo(correo, nombre, apellido, "Cotizacion autorizada");
            //Falta correo a proveedor
            //select pr.email from proveedores pr, cotizacion c where c.id_proveedor = pr.idproveedor and c.id_cotizacion = 1;
        }
    }

    if (redirecciona == 1) {
        response.sendRedirect("menuAutorizaCoti.jsp");
    } else {
        response.sendRedirect("menuComprasRequisiciones.jsp");
    }

%>