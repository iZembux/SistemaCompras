<%-- 
    Actualiza el status de la requisicion cuando el gerente la autoriza
    status 3 ---> status 4
--%>

<%@page import="controller.Consultas"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idReqProd = 0;
    int idUsu = 0;
    String rechazo = null;

    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }
    try {
        idUsu = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }
    try {
        rechazo = request.getParameter("rechazo");
    } catch (Exception e) {
    }

    Mail objMail = new Mail();
    Consultas obj = new Consultas();
    String correo = obj.consultarCorreos(idUsu);

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();

    st.executeUpdate("UPDATE req_prod SET id_status = 15, rechazoC = '" + rechazo + "' WHERE id_req_prod = " + idReqProd + ";");

    objMail.enviarCorreo(correo, "", "", "Tu requisicion No. " + idReqProd + " ha sido rechazada por el departamento de compras por el siguiemte motivo: \n"
            + "" + rechazo + "");

    response.sendRedirect("menuComprasRequisiciones.jsp");

%>