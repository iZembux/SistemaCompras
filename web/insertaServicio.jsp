<%-- 
    Crea una nueva requisicion y un nuevo registro qn la tabla req_prod con status 3
--%>

<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int nuevaRequisicion = 1;
    int idUsuario = 0;
    int idRequisicion = 0;
    int idCotizacion = 0;
    int idStatus = 3;
    int idProducto = 0;
    int cantidad = 0;
    int idDepto = 0;
    int activo = 0;
    int sucursal = 0;
    int categoria = 0;
    String descripcion = null;   
    String justificacion = null;
    String servicio = null;

    Mail objMail = new Mail();

    try {
        idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
    } catch (Exception e) {
    }
    try {
        cantidad = Integer.parseInt(request.getParameter("cantidad"));
    } catch (Exception e) {
    }
    try {
        descripcion = request.getParameter("descripcion");
    } catch (Exception e) {
    }
    try {
        justificacion = request.getParameter("justificacion");
    } catch (Exception e) {
    }
    try {
        nuevaRequisicion = Integer.parseInt(request.getParameter("nuevaRequisicion"));
    } catch (Exception e) {
    }
    try {
        idDepto = Integer.parseInt(request.getParameter("idDepto"));
    } catch (Exception e) {
    }
    try {
        activo = Integer.parseInt(request.getParameter("activo"));
    } catch (Exception e) {
    }
    try {
        sucursal = Integer.parseInt(request.getParameter("sucursal"));
    } catch (Exception e) {
    }
    try {
        servicio = request.getParameter("servicio");
    } catch (Exception e) {
    }
    try {
        categoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    rs = st.executeQuery("SELECT  max(id_productos) as id from productos;");
    if (rs.next()) {
        idProducto = rs.getInt("id") + 1;
    }

    st.executeUpdate("insert into productos (id_productos,id_unidadmedida,id_categoria,sku,nombre,serie,marca,modelo,status) "
            + "values ('" + idProducto + "',6,"+categoria+",0,'" + servicio + "',0,'NA','NA',1)");
    System.out.println("Nuevo servicio creado: " + servicio);

    //Pregunta si es una requisicion nueva (1) o si es continuacion de otra (0)
    if (nuevaRequisicion == 1) {
        st.executeUpdate("insert into requisiciones(id_requisicion, id_usuario, fecha) "
                + "values ('" + idRequisicion + "','" + idUsuario + "',CURRENT_TIMESTAMP)");

        //Envia correo al gerente del area
        String sql = "SELECT correo, nombre, apellido FROM scompras.usuario where id_rol = 3 and id_departamento = " + idDepto + " and id_sucursal = " + sucursal + ";";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        if (rs.next()) {
            String correo = rs.getString("correo");
            String nombre = rs.getString("nombre");
            String apellido = rs.getString("apellido");
            objMail.enviarCorreo(correo, nombre, apellido, "Tiene una nueva requisicion por revisar");
        }

    }

    rs = st.executeQuery("SELECT  max(id_requisicion) as id from requisiciones where id_usuario = " + idUsuario + ";");
    if (rs.next()) {
        idRequisicion = rs.getInt("id");
    }

    //Inserta el producto en la ultima requisicion creada
    int i = st.executeUpdate("insert into req_prod(id_requisicion, id_producto, id_req_coti, id_status, cantidad, descripcion, justificacion, activo_fijo) "
            + "values ('" + idRequisicion + "','" + idProducto + "','" + idCotizacion + "','" + idStatus + "','" + cantidad + "','" + descripcion + "','" + justificacion + "','" + activo + "')");
        response.sendRedirect("index.jsp");
    
%>