
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.RequisicionFormato"%>
<%@page import="model.OrdenFormato"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Consultas"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    System.out.println("Inicia creacion de ordenes");
    int cantidad = 0;
    String producto = " ";
    String sucursal = " ";
    String rfc = null;
    String direccion = null;
    String nombreP = null;
    String direccionP = null;
    String unidadMedida = null;
    String telefonoP = null;
    String nombreC = null;
    String departamento = null;
    String sku;
    int descuento = 0;
    double precio = 0;
    int idCotizacion = 0;
    int idP = 0;
    double subtotal = 0;
    int idOrden = 0;
    int idC = 0;
    int idSucursal;

    int categoria = 0;
    int proveedor = 0;
    int suc = 0;
    int dep = 0;

    int idReqProd = 0;
    int tam = 0;
    int idFormato = 0;
    int nuevoStatus = 0;

    Mail objMail = new Mail();

    try {
        categoria = Integer.parseInt(request.getParameter("categoria"));
        System.out.println("Categoria: " + categoria);
    } catch (Exception e) {
    }
    try {
        proveedor = Integer.parseInt(request.getParameter("proveedor"));
        System.out.println("Proveedor " + proveedor);
    } catch (Exception e) {
    }
    try {
        suc = Integer.parseInt(request.getParameter("suc"));
        System.out.println("Sucursal " + suc);
    } catch (Exception e) {
    }
    try {
        dep = Integer.parseInt(request.getParameter("dep"));
        System.out.println("Departamento " + dep);
    } catch (Exception e) {
    }

    try {
        tam = Integer.parseInt(request.getParameter("tam"));
    } catch (Exception e) {
    }

    try {
        idFormato = Integer.parseInt(request.getParameter("idFormato"));
    } catch (Exception e) {
    }

    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }

    ArrayList<OrdenFormato> arrayRequis = new ArrayList<OrdenFormato>();
    Consultas obj = new Consultas();

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    rs = st.executeQuery("select max(id_orden) as id from req_prod;");
    if (rs.next()) {
        idOrden = rs.getInt("id") + 1;
        System.out.println("Numero de Orden: " + idOrden);
    }

    arrayRequis = obj.consultarOrdenesProvAcum(proveedor, suc, categoria, dep);
    if (!arrayRequis.isEmpty()) {
        for (int i = 0; i < arrayRequis.size(); i++) {
            idCotizacion = arrayRequis.get(i).getIdCotizacion();
            idP = arrayRequis.get(i).getIdP();
            sucursal = arrayRequis.get(i).getSucursal();
            rfc = arrayRequis.get(i).getRfc();
            direccion = arrayRequis.get(i).getDireccion();
            nombreP = arrayRequis.get(i).getNombreP();
            direccionP = arrayRequis.get(i).getDireccionP();
            telefonoP = arrayRequis.get(i).getTelefonoP();
            nombreC = arrayRequis.get(i).getCompras();
            cantidad = arrayRequis.get(i).getCantidad();
            unidadMedida = arrayRequis.get(i).getUnidadMedida();
            producto = arrayRequis.get(i).getProducto();
            descuento = arrayRequis.get(i).getDescuento();
            precio = arrayRequis.get(i).getPrecio();
            idC = arrayRequis.get(i).getUsuCompras();
            subtotal += (cantidad * precio);
            departamento = arrayRequis.get(i).getDepto();
            idSucursal = arrayRequis.get(i).getIdSucursal();
            sku = arrayRequis.get(i).getSku();

            String usu = obj.consultarUsuarios(idC);

            st.executeUpdate("insert into ordenes_compra values (default,CURRENT_TIMESTAMP,'" + idSucursal + "','" + sucursal + "','" + rfc + "','" + direccion + "','" + idP + "','" + nombreP + "',"
                    + "'" + direccionP + "','" + telefonoP + "','" + cantidad + "','" + unidadMedida + "','" + producto + "','" + sku + "','" + descuento + "','" + precio + "','" + subtotal + "','" + usu + "',"
                    + "'" + idOrden + "','" + departamento + "',default)");

            for (int j = 0; j < tam; j++) {
                try {
                    idReqProd = Integer.parseInt(request.getParameter("idReqProd" + j));
                    st.executeUpdate("update req_prod set id_orden = " + idOrden + ", id_status = " + nuevoStatus + " where id_req_prod = " + idReqProd + "");
                } catch (Exception e) {
                }
            }
        }

        if (idFormato > 0) {
            st.executeUpdate("update formatounico set idOrden = " + idOrden + " where idformatounico = " + idFormato + "");
            System.out.println("Id Formato: " + idFormato);
        }

        String sql2 = "SELECT correo FROM scompras.usuario where id_rol = 3 and id_departamento = 7;";
        ps = con.prepareStatement(sql2);
        rs = ps.executeQuery();
        while (rs.next()) {
            String correo = rs.getString("correo");
            objMail.enviarCorreo(correo, "", "", "Se ha generado una nueva orden de compra, favor de revisarla en el sistama para su aprobacion.");
        }

    }

    response.sendRedirect("menuComprasOrdenes.jsp?categoria=" + categoria + "");


%>