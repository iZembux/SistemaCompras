<%-- 
    Document   : usuarioSeguimiento
    Created on : Mar 5, 2018, 7:55:17 AM
    Author     : user
--%>
<%@page import="model.CotizacionRequisicion"%>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%
    HttpSession sesion = request.getSession();
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    int idReqCoti = 0;
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {

        try {
            idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
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
        <title>Autorizar</title>
        <script>
            function alerta(){
                confirm("¿Enviar este producto?");
            }
        </script>
    </head>
    <body>

        <jsp:include page="frag/mainNavbarProveedor.jsp"/> 

        <div class="container my-5">
            <div class="page-header">
                <h3>Requisiciones Disponibles</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Sucursal</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idRequi;
                        String producto;
                        String marca;
                        String sucursal;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarDetalleComprasProv(idReqCoti);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idRequi = arrayRequis.get(i).getIdRequisicion();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                idReqCoti = arrayRequis.get(i).getIdReqCoti();
                                sucursal = arrayRequis.get(i).getSucursal();
                    %>
                    <tr>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidadRequi%></td>
                        <td><%=sucursal%></td> 
                        <td>

                            <div class="row">
                                <form action="formatos/ordenCompra.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                                    <input type="hidden" class="hidden" name="suc" value="<%=sucursal%>" >
                                    <button type="submit" class="btn btn-primary btn-sm">Ver Orden de Compra</button>
                                </form>
                                <form action="actualizaProveedor.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idRequi" value="<%=idReqCoti%>" >
                                    <input type="hidden" class="hidden" name="nuevoStatus" value="11" >
                                    <button type="submit" class="btn btn-info btn-sm" onclick="alerta()">Iniciar Envío de Productos</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <%}
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