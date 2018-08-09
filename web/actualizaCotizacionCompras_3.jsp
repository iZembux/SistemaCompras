
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

    Mail objMail = new Mail();

    try {
        nuevoStatusRequi = Integer.parseInt(request.getParameter("nuevoStatusRequi"));
    } catch (Exception e) {
    }
    try {
        idUsu = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }

    int id_categoria = 0;
    try {
        id_categoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }

    try {
        tam = Integer.parseInt(request.getParameter("tamano"));
    } catch (Exception e) {
    }

    try {
        seleccionada = Integer.parseInt(request.getParameter("sel"));
    } catch (Exception e) {
    }

    try {
        idCuadro = Integer.parseInt(request.getParameter("idCuadro"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    PreparedStatement ps;
    ResultSet rs;

    System.out.println("------------------COTIZACIONES GANADORAS--------------------");
    System.out.println("Proveedor: " + seleccionada);
    System.out.println("Numero de cotizaciones: " + tam);
    System.out.println("Comparativo: " + idCuadro);

    Consultas obj = new Consultas();
    ArrayList<Integer> totalRequis = obj.consultarRequisCuadrosComparativos(idCuadro);

    for (int j = 0; j < tam; j++) {
        idCotizacion = Integer.parseInt(request.getParameter("cotiSelccionada" + seleccionada + j));

        System.out.println("Cotizacion ganadora: " + idCotizacion);
        st.executeUpdate("update cotizacion set id_status_cotizacion = " + nuevoStatusCoti + ",\n"
                + "aut_nivel2 = " + idUsu + ", fecha_aut_nivel2 = CURRENT_TIMESTAMP where id_cotizacion = " + idCotizacion + ";");
        
        st.executeUpdate("update req_prod rp, cotizacion c set id_status = " + nuevoStatusRequi + ", id_cot_ganadora = " + idCotizacion + " "
                + "where c.id_req_coti = rp.id_req_coti and rp.id_req_prod = " + totalRequis.get(j) + ";");
        System.out.println("Requisicion actualizadas: " + totalRequis.get(j));
    }

    String sql2 = "SELECT correo, nombre, apellido FROM scompras.usuario where id_usuario = 294;";
    ps = con.prepareStatement(sql2);
    rs = ps.executeQuery();
    while (rs.next()) {
        String correo = rs.getString("correo");
        String nombre = rs.getString("nombre");
        String apellido = rs.getString("apellido");
        objMail.enviarCorreo(correo, nombre, apellido, "Comparativo autorizado");
    }
    
    System.out.println("------------------------------------------------------------");
    //Envia Correo a Gerente Admin
    response.sendRedirect("menuComprasOrdenesAdmin.jsp");
%>