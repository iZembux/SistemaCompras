<%-- 
    Actualiza el status de la requisicion cuando el gerente la autoriza
    status 3 ---> status 4
--%>

<%@page import="controller.Consultas"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idReqCoti = 100;
    int idReqProd = 0;
    int idUsu = 0;
    int nuevoStatus = 0;
    int stock = 0;
    int entrega = 0;

    Mail objMail = new Mail();

    try {
        idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
    } catch (Exception e) {
    }
    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }
    try {
        idUsu = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }
    try {
        stock = Integer.parseInt(request.getParameter("stock"));
    } catch (Exception e) {
    }
    try {
        entrega = Integer.parseInt(request.getParameter("entrega"));
    } catch (Exception e) {
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();

    if (stock == 1) {
        st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_req_prod = " + idReqProd + ";");
    } else {
        st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_req_coti = " + idReqCoti + ";");
    }

    Consultas obj = new Consultas();
    String correo = obj.consultarCorreos(idUsu);

    objMail.enviarCorreo(correo, "Usuario", "", "Puedes pasar por tu producto");

    if (stock == 1) {
        response.sendRedirect("menuComprasEntrega.jsp");
    } else {
        if (entrega == 1) {
            response.sendRedirect("menuComprasEntrega.jsp");
        } else {
            response.sendRedirect("menuComprasRecepcion.jsp");
        }
    }

%>