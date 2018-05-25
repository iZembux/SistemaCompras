
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.RequisicionFormato"%>
<%@page import="model.OrdenFormato"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Consultas"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
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

    Mail objMail = new Mail();

    try {
        categoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }
    try {
        proveedor = Integer.parseInt(request.getParameter("proveedor"));
    } catch (Exception e) {
    }
    try {
        suc = Integer.parseInt(request.getParameter("suc"));
    } catch (Exception e) {
    }
    try {
        dep = Integer.parseInt(request.getParameter("dep"));
    } catch (Exception e) {
    }

    ArrayList<OrdenFormato> arrayRequis = new ArrayList<OrdenFormato>();
    Consultas obj = new Consultas();

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

    rs = st.executeQuery("select max(id_orden) as id from cotizacion;");
    if (rs.next()) {
        idOrden = rs.getInt("id") + 1;
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
            System.out.println("RAZON: "+idSucursal+" SKU: "+sku);
            st.executeUpdate("update cotizacion set id_orden = " + idOrden + " where id_cotizacion = " + idCotizacion + "");
            st.executeUpdate("insert into ordenes_compra values (default,CURRENT_TIMESTAMP,'" + idSucursal + "','" + sucursal + "','" + rfc + "','" + direccion + "','" + idP + "','" + nombreP + "',"
                    + "'" + direccionP + "','" + telefonoP + "','" + cantidad + "','" + unidadMedida + "','" + producto + "','" + sku + "','" + descuento + "','" + precio + "','" + subtotal + "','" + usu + "',"
                    + "'" + idOrden + "','" + departamento + "',default)");
        }
    }

    response.sendRedirect("menuComprasOrdenes.jsp");


%>