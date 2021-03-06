<%-- 
    Actualiza el status de la requisicion cuando compras solicita una cotizacion
    status 4 ---> status 5
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idProducto = 0;
    int nuevoStatus = 5;
    int id_cotizacion = 0;
    int idCategoria = 0;
    int usuarioC = 0;
    int numProveedores = 0;
    int idReqProd = 0;
    int tam = 0;
    int contrato = 0;

    String suc = null;

    Mail objMail = new Mail();

    try {
        idProducto = Integer.parseInt(request.getParameter("idProducto"));
    } catch (Exception e) {
    }
    try {
        idCategoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }
    try {
        usuarioC = Integer.parseInt(request.getParameter("usuario"));
    } catch (Exception e) {
    }
    try {
        numProveedores = Integer.parseInt(request.getParameter("numProveedores"));
    } catch (Exception e) {
    }
    try {
        tam = Integer.parseInt(request.getParameter("tam"));
    } catch (Exception e) {
    }
    try {
        suc = request.getParameter("suc");
    } catch (Exception e) {
    }
    try {
        contrato = Integer.parseInt(request.getParameter("checkboxCont"));
    } catch (Exception e) {
    }
    System.out.println("------------------PRODUCTOS PARA COTIZACION-----------------");

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    //Consulta el ultimo id de cotizacion para crear uno nuevo
    rs = st.executeQuery("select max(id_req_coti) as id from req_prod;");
    if (rs.next()) {
        id_cotizacion = rs.getInt("id");
    }

    System.out.println("Usuario: " + usuarioC);
    System.out.println("Producto: " + idProducto);
    st.executeUpdate("UPDATE req_prod rp, requisiciones r, usuario u SET rp.id_status = " + nuevoStatus + ",\n"
            + "rp.id_req_coti = " + (id_cotizacion + 1) + ", rp.usu_compras = " + usuarioC + ", rp.fecha_coti = CURRENT_TIMESTAMP WHERE\n"
            + "rp.id_requisicion = r.id_requisicion\n"
            + "AND r.id_usuario = u.id_usuario\n"
            + "AND u.id_sucursal in (" + suc + ")\n"
            + "AND rp.id_producto = " + idProducto + "\n"
            + "AND rp.id_status = 4;");

    //Envia correo a los proveedores seleccionados
    ArrayList<Integer> idProv = new ArrayList<Integer>();
    System.out.println("Numero de proveedores: " + numProveedores);
    for (int i = 0; i < numProveedores; i++) {
        try {
            int aux = Integer.parseInt(request.getParameter("checkbox" + i));
            idProv.add(aux);
        } catch (Exception e) {
        }
    }
    System.out.println("Numero de requisiciones: " + tam);
    for (int i = 0; i < idProv.size(); i++) {
        for (int j = 0; j < tam; j++) {
            try {
                idReqProd = Integer.parseInt(request.getParameter("idReqProd" + j));
                //System.out.println("id req: " + idReqProd + " id prov: " + idProv.get(i));
                st.executeUpdate("insert into proveedores_selec (id_req_prod, id_proveedor) values (" + idReqProd + "," + idProv.get(i) + ")");
            } catch (Exception e) {
            }
        }
        String sql2 = "SELECT email FROM scompras.proveedores where giro = " + idCategoria + " and idproveedor = " + idProv.get(i) + ";";
        ps = con.prepareStatement(sql2);
        rs = ps.executeQuery();
        while (rs.next()) {
            String correo = rs.getString("email");
            objMail.enviarCorreo(correo, "Proveedor", "", "Grupo Continental Automotriz ha solicitado una nueva cotizacion, favor de revisarla en el sistema de compras");
            System.out.println("Email a proveedor: " + idProv.get(i) + " " + correo);
        }
    }

    if (contrato == 1) {
        String sql2 = "SELECT correo FROM scompras.usuario where id_departamento = 27 and id_rol = 3;";
        ps = con.prepareStatement(sql2);
        rs = ps.executeQuery();
        while (rs.next()) {
            String correo = rs.getString("correo");
            objMail.enviarCorreo(correo, "", "", "Grupo Continental Automotriz ha solicitado un nuevo servicio y se requiere de apoyo legal, "
                    + "favor de comunicarse con el departamento de compras, gracias.");
            System.out.println("Email a Juridico");
        }
    }

    System.out.println("------------------------------------------------------------");
    response.sendRedirect("menuComprasRequisiciones.jsp?categoria=" + idCategoria + "");


%>
