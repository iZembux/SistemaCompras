
<%@page import="controller.Consultas"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int idReqProd = 0;
    int idUsu = 0;
    int nuevoStatus = 0;
    int stock = 0;
    int entrega = 0;
    int cantidad = 0;
    String producto = " ";
    Consultas consultor = new Consultas();
    Mail objMail = new Mail();

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
    try {
        cantidad = Integer.parseInt(request.getParameter("cantidad"));
    } catch (Exception e) {
    }
    try {
        producto = request.getParameter("producto");
    } catch (Exception e) {
    }

    int id_categoria = 0;
    try {
        id_categoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {

    }

    int id_producto = 0;
    try {
        id_producto = Integer.parseInt(request.getParameter("idProducto"));
    } catch (Exception e) {

    }
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();

    st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " WHERE id_req_prod = " + idReqProd + ";");

    Consultas obj = new Consultas();
    String correo = obj.consultarCorreos(idUsu);

    if (nuevoStatus == 12) {
        objMail.enviarCorreo(correo, "", "", "Tu producto est� en el �rea de compras, puedes pasar a recogerlo EL PROXIMO DIA LUNES\n"
                + "Id: " + idReqProd + "\n"
                + "Producto: " + producto + "\n"
                + "Cantidad: " + cantidad + "\n");
    } else if (nuevoStatus == 13) {
        objMail.enviarCorreo(correo, "", "", "Requisicion " + idReqProd + " Finalizada");
    } else if (nuevoStatus == 16) {
        objMail.enviarCorreo(correo, "", "", "Por favor, confirma tu entrega: " + idReqProd);
        //consultor.insertaEntregaCompras(idReqProd, idCompras, idUsuario, fechaEntregaCompras);
    }

    if (stock == 1) {
        response.sendRedirect("detalleRequisicionCompras.jsp?idCategoria=" + id_categoria + "&idProducto=" + id_producto + ""); 
    } else {
        if (entrega == 1) {
            response.sendRedirect("menuComprasEntrega.jsp?categoria=" + id_categoria + "");
        } else {
            response.sendRedirect("menuComprasRecepcion.jsp?categoria=" + id_categoria + "");
        }
    }

%>