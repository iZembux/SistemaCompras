<%  
    // Solicita cotizaciones a proveedores que faltan en el comparativo 
  %>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int nuevoStatus = 5;
    int idCategoria = 0;
    int numProveedores = 0;
    int idReqProd = 0;
    int tam = 0;

    Mail objMail = new Mail();

    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }
    try {
        idCategoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }
    try {
        numProveedores = Integer.parseInt(request.getParameter("numProveedores"));
        System.out.println("Proveedores seleccionados: " + numProveedores);
    } catch (Exception e) {
    }
    try {
        tam = Integer.parseInt(request.getParameter("tam"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    //Cambia el status de todas las requisiciones en la orden
    for (int j = 0; j < tam; j++) {
        try {
            idReqProd = Integer.parseInt(request.getParameter("idReqProd" + j));
            st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + ", id_cot_ganadora = 0\n"
                    + " WHERE id_req_prod = " + idReqProd + "");
        } catch (Exception e) {
        }
    }

    //Envia correo a los proveedores seleccionados
    ArrayList<Integer> idProv = new ArrayList<Integer>();
    for (int i = 0; i < numProveedores; i++) {
        try {
            int aux = Integer.parseInt(request.getParameter("checkbox" + i));
            idProv.add(aux);
        } catch (Exception e) {
        }
    }
    for (int i = 0; i < idProv.size(); i++) {
        for (int j = 0; j < tam; j++) {
            try {
                idReqProd = Integer.parseInt(request.getParameter("idReqProd" + j));
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
        }
    }

    response.sendRedirect("menuComprasOrdenes.jsp");
%>
