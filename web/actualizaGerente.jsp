<%-- 
    Actualiza el status de la requisicion cuando el gerente la autoriza
    status 3 ---> status 4
--%>

<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idReqProd = 0;
    int nuevoStatus = 0;
    int autoriza = 0;

    Mail objMail = new Mail();

    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
        System.out.println("Gerente Autoriza/Rechaza Requisicion: " + idReqProd);
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

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();

    st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_req_prod = " + idReqProd + ";");
    
    //Envia correo al usuario que solicito el producto y al departamento de compras cuando el gerente acepta/rechaza
    if (autoriza == 1) {
        //Usuario
        objMail.enviarCorreo("diego.torres@continental.com.mx", "Diego", "Torres", "Tu requisicion ha sido aprobada por tu gerente");
        //Depto. Compras
        objMail.enviarCorreo("diego.torres@continental.com.mx", "Diego", "Torres", "Hay una nueva requisicion por revisar");
    } else if (autoriza == 2) {
        objMail.enviarCorreo("diego.torres@continental.com.mx", "Diego", "Torres", "Tu requisicion ha sido rechazada por tu gerente");
    } else {
        System.out.println("ERROR AL RECIBIR PARAMETROS");
    }
    response.sendRedirect("menuAutorizaRequi.jsp");

%>