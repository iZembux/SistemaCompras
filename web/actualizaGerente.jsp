<%-- 
    Actualiza el status de la requisicion cuando el gerente la autoriza
    status 3 ---> status 4
--%>

<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idSolicita = 0;
    int idReqProd = 0;
    int nuevoStatus = 0;
    int autoriza = 0;
    int idUsu = 0;
    int admin = 0;
    int categoria = 0;
    int idGerenteAdmin = 0;

    Mail objMail = new Mail();

    try {
        idSolicita = Integer.parseInt(request.getParameter("idSolicita"));
    } catch (Exception e) {
    }
    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }
    try {
        autoriza = Integer.parseInt(request.getParameter("autoriza"));
    } catch (Exception e) {
    }
    try {
        idUsu = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }
    try {
        admin = Integer.parseInt(request.getParameter("admin"));
    } catch (Exception e) {
    }
    try {
        categoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    PreparedStatement ps;
    ResultSet rs;

    st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + ", usu_gerente = " + idUsu + ",\n"
            + "fecha_usu_gerente = CURRENT_TIMESTAMP WHERE id_req_prod = " + idReqProd + ";");

    //Envia correo al usuario que solicito el producto y al departamento de compras cuando el gerente acepta/rechaza
    if (autoriza == 1) {
        //Usuario solicitante
        String sql = "SELECT correo, nombre, apellido FROM scompras.usuario where id_usuario = " + idSolicita + ";";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        if (rs.next()) {
            String correo = rs.getString("correo");
            String nombre = rs.getString("nombre");
            String apellido = rs.getString("apellido");
            objMail.enviarCorreo(correo, nombre, apellido, "Tu requisicion ha sido aprobada por tu gerente");
        }
        if (categoria == 2) {
            String sql2 = "SELECT correo, nombre, apellido FROM scompras.usuario where id_rol = 2;";
            ps = con.prepareStatement(sql2);
            rs = ps.executeQuery();
            while (rs.next()) {
                String correo = rs.getString("correo");
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                objMail.enviarCorreo(correo, nombre, apellido, "Hay un nuevo dictamen por realizar");
            }
        }
        if (nuevoStatus == 17) {
            String sql3 = "SELECT id_sucursal FROM scompras.usuario where id_usuario = " + idSolicita + ";";
            ps = con.prepareStatement(sql3);
            rs = ps.executeQuery();
            int suc = 0;
            int suc2 = 0;
            int arrCont[] = {1, 2, 3, 4, 6, 7};
            int arrNihon[] = {14, 9, 0, 0, 0};
            int arrKorean[] = {8, 13, 17, 0, 0};
            int arrAuto[] = {10, 11, 15, 16, 18};
            if (rs.next()) {
                suc = rs.getInt("id_sucursal");
            }
            for (int i = 0; i < arrCont.length; i++) {
                if (suc == arrCont[i]) {
                    suc2 = 1;
                    break;
                } else if (suc == arrNihon[i]) {
                    suc2 = 9;
                    break;
                } else if (suc == arrKorean[i]) {
                    suc2 = 8;
                    break;
                } else if (suc == arrAuto[i]) {
                    suc2 = 10;
                    break;
                }
            }

            String sql2 = "SELECT correo, nombre, apellido FROM scompras.usuario where id_rol = 4 and id_sucursal = " + suc2 + ";";
            ps = con.prepareStatement(sql2);
            rs = ps.executeQuery();
            while (rs.next()) {
                String correo = rs.getString("correo");
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                objMail.enviarCorreo(correo, nombre, apellido, "Hay una nueva requisicion, favor de revisar en la seccion 'Autorizaciones generales'");
            }
        }
    } else if (autoriza == 2) {
        //Usuario solicitante
        String sql = "SELECT correo, nombre, apellido FROM scompras.usuario where id_usuario = " + idSolicita + ";";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        if (rs.next()) {
            String correo = rs.getString("correo");
            String nombre = rs.getString("nombre");
            String apellido = rs.getString("apellido");
            objMail.enviarCorreo(correo, nombre, apellido, "Tu requisicion ha sido rechazada por tu gerente");
        }
    } else {
        System.out.println("ERROR AL RECIBIR PARAMETROS");
    }

    if (admin == 1) {
        response.sendRedirect("menuAutorizaRequiAdmin.jsp");
    } else {
        response.sendRedirect("menuAutorizaRequi.jsp");
    }

%>