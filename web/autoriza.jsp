<%-- 
    Document   : registration
    Created on : Feb 28, 2018, 9:14:05 AM
    Author     : user
--%>

<%@ page import ="java.sql.*" %>
<%
    int nuevaRequisicion = 1;
    int idUsuario = 0;
    int idRequisicion = 0;
    int idCotizacion = 0;
    int idStatus = 3;
    int idProducto = 0;
    int cantidad = 0;
    String descripcion = null;
    String justificacion = null;
    
    try {
        idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
    } catch (Exception e) {
    }
    try {
        idProducto = Integer.parseInt(request.getParameter("modelo"));
    } catch (Exception e) {
    }
    try {
        cantidad = Integer.parseInt(request.getParameter("cantidad"));
    } catch (Exception e) {
    }
    try {
        descripcion = request.getParameter("descripcion");
    } catch (Exception e) {
    }
    try {
        justificacion = request.getParameter("justificacion");
    } catch (Exception e) {
    }
    try {
        nuevaRequisicion = Integer.parseInt(request.getParameter("nuevaRequisicion"));
    } catch (Exception e) {
    }
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

    rs = st.executeQuery(""); 
    if (rs.next()) {
        idRequisicion = rs.getInt("id");
    }
    
    int i = st.executeUpdate("insert into req_prod(id_reqprod, id_producto, id_cotizacion, id_status, cantidad, descripcion, justificacion) "
            + "values ('" + idRequisicion + "','" + idProducto + "','" + idCotizacion + "','" + idStatus + "','" + cantidad + "','" + descripcion + "','" + justificacion + "')");
    if (i > 0) {
        response.sendRedirect("insertarProductoCont.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%>