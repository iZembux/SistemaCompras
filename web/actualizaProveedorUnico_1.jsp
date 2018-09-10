<%-- 
    Actualiza el status de la requisicion cuando compras solicita una cotizacion
    status 4 ---> status 5
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="model.CotizacionRequisicion"%>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%

    int nuevoStatus = 0;
    int idFormato = 0;
    int usuario = 0;
    String autorizador = " ";
    String autorizadorBD = " ";
    String redirect = " ";

    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }
    try {
        idFormato = Integer.parseInt(request.getParameter("idFormato"));
    } catch (Exception e) {
    }
    try {
        usuario = Integer.parseInt(request.getParameter("usuario"));
    } catch (Exception e) {
    }

    Consultas obj = new Consultas();

    autorizador = obj.consultarUsuarios(usuario);
    if (nuevoStatus == 9) {
        autorizadorBD = "autorizacion1";
        redirect = "menuComprasOrdenesAdminCompras.jsp";
        
    } else if (nuevoStatus == 19) {
        autorizadorBD = "autorizacion2";
        redirect = "menuComprasOrdenesAdmin.jsp";
    } else if (nuevoStatus == 10) {
        autorizadorBD = "autorizacion3";
        redirect = "menuComprasOrdenesAdminDir.jsp";
    }

    System.out.println("--------------------------FORMATO UNICO---------------------");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    System.out.println("Formato No: " + idFormato);
    System.out.println("Nuevo Status: " + nuevoStatus);
    System.out.println("Autorizado por: " + autorizador);

    st.executeUpdate("update req_prod rp, formatounico fu set id_status = " + nuevoStatus + ", "+autorizadorBD+" = '" + autorizador + "' "
            + "where rp.id_formato_unico = fu.idformatoUnico and fu.idformatoUnico = " + idFormato + ";");

    System.out.println("Actualizacion exitosa");

    System.out.println("------------------------------------------------------------");
    //Envia Correo a Gerente Admin
    response.sendRedirect(redirect);
%>