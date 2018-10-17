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
    String solicitante = " ";
    String departamento = " ";
    String proveedor = " ";
    String justificacion = " ";
    double monto = 0;
    int check1 = 0;
    int check2 = 0;
    int check3 = 0;
    int check4 = 0;
    int check5 = 0;
    int check6 = 0;
    int check7 = 0;
    int check8 = 0;
    int nuevoStatus = 0;
    int idReqProd = 0;
    int idCategoria = 0;
    int idFormatoUnico = 0;

    DecimalFormat formateador = new DecimalFormat("###,###,###.##");

    try {
        solicitante = request.getParameter("solicitante").toUpperCase();
    } catch (Exception e) {
    }
    try {
        departamento = request.getParameter("departamento").toUpperCase();
    } catch (Exception e) {
    }
    try {
        proveedor = request.getParameter("proveedor").toUpperCase();
    } catch (Exception e) {
    }
    try {
        justificacion = request.getParameter("justificacion").toUpperCase();
    } catch (Exception e) {
    }
    try {
        monto = Double.parseDouble(request.getParameter("monto"));
    } catch (Exception e) {
    }
    try {
        check1 = Integer.parseInt(request.getParameter("check1"));
    } catch (Exception e) {
    }
    try {
        check2 = Integer.parseInt(request.getParameter("check2"));
    } catch (Exception e) {
    }
    try {
        check3 = Integer.parseInt(request.getParameter("check3"));
    } catch (Exception e) {
    }
    try {
        check4 = Integer.parseInt(request.getParameter("check4"));
    } catch (Exception e) {
    }
    try {
        check5 = Integer.parseInt(request.getParameter("check5"));
    } catch (Exception e) {
    }
    try {
        check6 = Integer.parseInt(request.getParameter("check6"));
    } catch (Exception e) {
    }
    try {
        check7 = Integer.parseInt(request.getParameter("check7"));
    } catch (Exception e) {
    }
    try {
        check8 = Integer.parseInt(request.getParameter("check8"));
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }
    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }
    try {
        idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
    } catch (Exception e) {
    }

    System.out.println("--------------------------FORMATO UNICO---------------------");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

    rs = st.executeQuery("SELECT  max(id_formato_unico) as id from req_prod;");
    if (rs.next()) {
        idFormatoUnico = rs.getInt("id") + 1;
        System.out.println("Id Formato: " + idFormatoUnico );
    }

    st.executeUpdate("insert into formatounico values (default,'" + departamento + "',0,'" + proveedor + "',CURRENT_TIMESTAMP," + monto + ","
            + "" + check1 + "," + check2 + "," + check3 + "," + check4 + "," + check5 + "," + check6 + "," + check7 + "," + check8 + ",'" + justificacion + "','" + solicitante + "',default,default,default)");

    st.executeUpdate("update req_prod rp set id_status = " + nuevoStatus + ", id_formato_unico = " + idFormatoUnico + " where id_req_prod = " + idReqProd + ";");

    System.out.println("------------------------------------------------------------");
    //Envia Correo a Gerente Admin
    response.sendRedirect("menuComprasOrdenes.jsp?categoria=" + idCategoria + "");
%>