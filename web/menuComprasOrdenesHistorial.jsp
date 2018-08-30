<%-- 
    Document   : usuarioSeguimiento
    Created on : Mar 5, 2018, 7:55:17 AM
    Author     : user
--%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="model.OrdenFormato"%>
<%@page import="model.CotizacionRequisicion"%>
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
        String usuario = (String) sesion.getAttribute("idUsuario");
        String suc = null;

        if (usuario.equals("83")) {       //Valeria
            suc = "1,2,3,4,6,7,8,13";
        } else if (usuario.equals("4") || usuario.equals("268")) { //Veronica
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
        } else if (usuario.equals("25")) { //Angelica
            suc = "10,11,15,16,18";
        } else if (usuario.equals("226")) { //Roberto 
            suc = "9,14,17";
        } else if (usuario.equals("268")) { //Victor Peralta
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
        }

        int id_categoria = 1;
        try {
            id_categoria = Integer.parseInt(request.getParameter("categoria"));
        } catch (Exception e) {

        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Historial de Ordenes</title>

    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Ordenes de compra</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Orden</th>
                        <th scope="col">Proveedor</th>
                        <th scope="col">Productos</th>
                        <th scope="col">Sucursal</th>
                        <th scope="col">Departamento</th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Orden</th>
                        <th scope="col">Factura</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidad;
                        int idOrden;
                        String razonsocial;
                        String sucursal;
                        String depto;
                        String fecha;
                        String rutaFactura;

                        ArrayList<OrdenFormato> arrayRequis = new ArrayList<OrdenFormato>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarOrdenesProvComprasHist(suc, id_categoria);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idOrden = arrayRequis.get(i).getIdOrden();
                                razonsocial = arrayRequis.get(i).getNombreP();
                                cantidad = arrayRequis.get(i).getCantidad();
                                sucursal = arrayRequis.get(i).getSucursal();
                                depto = arrayRequis.get(i).getDepto();
                                fecha = arrayRequis.get(i).getFecha();
                                rutaFactura = obj.consultaRutaFactura(idOrden);
                    %>
                    <tr>
                        <td><%=idOrden%></td>
                        <td><%=razonsocial%></td>
                        <td><%=cantidad%></td>
                        <td><%=sucursal%></td> 
                        <td><%=depto%></td> 
                        <td><%=fecha%></td>
                        <td>
                            <div class="row">
                                <form action="formatos/ordenCompraAcumFinal.jsp" method="post" target="_blank">
                                    <input type="hidden" name="idOrden" value="<%=idOrden%>" >
                                    <button type="submit" class="btn btn-info btn-sm" >Ver Orden</button>
                                </form>
                            </div>
                        </td>
                        <%
                            if (rutaFactura != null) {
                                try {
                        %>
                        <td>
                            <div class="row">
                                <form name="abreFactura" action="visor" method="POST" target="_blank">
                                    <input type="hidden" name="search" id="search" value="<%=rutaFactura%>" >
                                    <button type="submit" class="btn btn-dark btn-sm" >Ver Factura</button>
                                </form>
                            </div>
                        </td>
                        <%
                        } catch (Exception e) {
                        %>
                <script> alert('No se encontró la factura');</script>
                <%
                    }
                } else {
                %>
                <td>
                    <div class="row">
                        <button type="submit" class="btn btn-dark btn-sm" disabled="true">No disponible</button>
                    </div>
                </td>
                <%}%>
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
