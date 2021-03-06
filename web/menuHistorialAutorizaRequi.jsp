<%-- 
    Muestra el historial de requisiciones autorizadas por el gerente
--%>

<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%
    HttpSession sesion = request.getSession();
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String idDepto = (String) sesion.getAttribute("departamento");
        String rol = (String) sesion.getAttribute("rol");
        String sucursal = (String) sesion.getAttribute("sucursal");

        String idUsu = (String) sesion.getAttribute("idUsuario");
        String idDepto2 = idDepto;
       if (idUsu.equals("34")) {
            idDepto2 = "8,10,13";
        }
		if (idUsu.equals("210")) {
            idDepto2 = "1,8,10,13";
        }
        if (idUsu.equals("114")) {
            idDepto2 = "21,26,1,13,18";
        }
        if (idUsu.equals("65") || idUsu.equals("133")) {
            idDepto2 = "1,6,8,9,13,24,25,26";
        }
        
        if (idUsu.equals("14")) {
            idDepto2 = "1,24,6";
        }
		if (idUsu.equals("4")) {
            idDepto2 = "7,28";
        }
        if (idUsu.equals("88")) {
            idDepto2 = "8,10,13";
			sucursal = "10,18";
        }
		if (idUsu.equals("181")) {
            idDepto2 = "1,14";
        }
		if (idUsu.equals("153")) {
            idDepto2 = "3,21";
			sucursal = "1,2,3,4,6,7";
        }
		if (idUsu.equals("173")||idUsu.equals("167")) {
            idDepto2 = "1,10,12,26";
        }
        if (idUsu.equals("57")) {
            idDepto2 = "18,19,21";
			sucursal = "8";
        }
        
        if (idUsu.equals("60") || idUsu.equals("4")) {
            sucursal = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18";
        }
		if (idUsu.equals("100")) {
            sucursal = "1,6";
        }
        if (idUsu.equals("126")) {
            sucursal = "9,14";
        }
		if (idUsu.equals("127")) {
            sucursal = "1,9,10,11";
        }
		if (idUsu.equals("138")) {
            sucursal = "1,9,10,11";
        }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Historial</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
            <jsp:param name="idUsu" value="<%=idUsu%>" />
        </jsp:include>


        <div class="container my-5">
            <div class="page-header">
                <h3>Historial de Autorizaciones</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Solicitante</th>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Justificacion</th>
                        <th scope="col">Descripcion</th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int idRequi;
                        int cantidad;
                        String solicitante;
                        String producto;
                        String marca;
                        String justificacion;
                        String descripcion;
                        String fecha;
                        String status;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarHistorialGerente(idDepto2, sucursal);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idRequi = arrayRequis.get(i).getIdRequisicion();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                justificacion = arrayRequis.get(i).getJustificacion();
                                descripcion = arrayRequis.get(i).getDescripcion();
                                cantidad = arrayRequis.get(i).getCantidad();
                                status = arrayRequis.get(i).getStatus();
                                fecha = arrayRequis.get(i).getFecha();
                    %>
                    <tr>
                        <td><%=idRequi%></td>
                        <td><%=solicitante.toUpperCase() %></td>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidad%></td>
                        <td><%=justificacion.toUpperCase() %></td>
                        <td><%=descripcion.toUpperCase() %></td>
                        <td><%=fecha%></td>
                        <td><b><%=status.toUpperCase() %></b></td>
                    </tr>
                    <% }
                        }%>
                </tbody>
            </table>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>