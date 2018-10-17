
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.RequisicionFormato"%>
<%@page import="model.OrdenFormato"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Consultas"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    System.out.println("Inicia creacion de ordenes");
    int idOrden = 0;
    int nuevoStatus = 0;
    Mail objMail = new Mail();

    try {
        idOrden = Integer.parseInt(request.getParameter("idOrden"));
        System.out.println("Orden: " + idOrden);
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
        System.out.println("Status: " + nuevoStatus);
    } catch (Exception e) {
    }

    ArrayList<OrdenFormato> arrayRequis = new ArrayList<OrdenFormato>();
    Consultas obj = new Consultas();

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    if (idOrden > 0) {
        st.executeUpdate("update req_prod set id_status = " + nuevoStatus + " where id_orden = " + idOrden + "");
    }

    int proveedor = 0;
    String sql2 = "select c.id_proveedor from req_prod rp, cotizacion c where rp.id_cot_ganadora = c.id_cotizacion and rp.id_orden = " + idOrden + ";";
    ps = con.prepareStatement(sql2);
    rs = ps.executeQuery();
    if (rs.next()) {
        proveedor = rs.getInt("id_proveedor");
    }

    String sql3 = "SELECT email FROM scompras.proveedores where idproveedor = " + proveedor + ";";
    ps = con.prepareStatement(sql3);
    rs = ps.executeQuery();
    while (rs.next()) {
        String correo = rs.getString("email");
        objMail.enviarCorreo(correo, "Proveedor", "", "Grupo Continental Automotriz ha autorizado una nueva orden de compra, favor de revisarla en el sistema");
    }

    response.sendRedirect(
            "menuOrdenesGerenteCompras.jsp");


%>