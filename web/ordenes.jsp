<%-- 
    Muestra las cotizaciones que se han hecho de los proveedores disponibles por categoria de producto
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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Recepcion</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Recepcion de Productos</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Orden</th>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Proveedor</th>
                        <th scope="col">Solicitante</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idReqProd;
                        int idUsu;
                        int idOrden;
                        int idreqcoti;
                        String idSuc;
                        String producto;
                        String marca;
                        String proveedor;
                        String solicitante;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarComprasRecibido(11);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                idReqProd = arrayRequis.get(i).getIdReqProd();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                proveedor = arrayRequis.get(i).getSolicitante();
                                idUsu = arrayRequis.get(i).getIdSolicita();
                                solicitante = arrayRequis.get(i).getDescripcion();
                                idOrden = arrayRequis.get(i).getIdOrden();
                                idreqcoti = arrayRequis.get(i).getIdReqCoti();
                                idSuc = arrayRequis.get(i).getSucursal();
                    %>
                    <tr>
                        <td><%=idOrden%></td>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidadRequi%></td> 
                        <td><%=proveedor%></td> 
                        <td><%=solicitante.toUpperCase() %></td> 
                        <td>
                            <form action="formatos/ordenCompra.jsp" method="post">
                                <input type="hidden" class="hidden" name="suc" value="<%=idSuc%>" >
                                <input type="hidden" class="hidden" name="idReqCoti" value="<%=idreqcoti%>" >
                                    <button tyFpe="submit" class="btn btn-success btn-sm">Orden</button>
                                </form>
                        </td>
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