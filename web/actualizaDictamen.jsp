<%-- 
    Actualiza el status de la requisicion cuando el gerente la autoriza
    status 3 ---> status 4
--%>

<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idReqProd = 0;
    int nuevoStatus = 0;

    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }


    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();

    st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_req_prod = " + idReqProd + ";");

    response.sendRedirect("menuDictamen.jsp");

%>