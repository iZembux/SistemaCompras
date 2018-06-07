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
    String ruta;
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    try {

    } catch (Exception e) {
        System.out.println("Aún no tengo ruta PDF");
    }
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String id_usuario = (String) sesion.getAttribute("idUsuario");
        String idCategoria = (String) sesion.getAttribute("giro");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Licitaciones</title>

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
                        <th scope="col">SKU</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idProducto;
                        int idReqCoti;
                        int status;
                        int sku;
                        String producto;
                        String marca;
                        String rutaDictamen;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        /*Consulta requisiciones dependiendo de su status 
                        status 5 - sin ninguna cotizacion
                        status 6 - con al menos una cotizacion
                        status 10 - cotizacion autorizada
                         */
                        arrayRequis = obj.consultarComprasProv(idCategoria, "5,6", id_usuario);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idProducto = arrayRequis.get(i).getIdProducto();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                idReqCoti = arrayRequis.get(i).getIdReqCoti();
                                status = arrayRequis.get(i).getIdStatus();
                                sku = arrayRequis.get(i).getSku();
                                if (idCategoria.equals("2")) {
                                    rutaDictamen = arrayRequis.get(i).getRutaDictamen();
                                } else {
                                    rutaDictamen = "";
                                }

                    %>
                    <tr>
                        <td><%=producto%></td>
                        <td><%=sku%></td>
                        <td><%=marca%></td>
                        <td><%=cantidadRequi%></td> 
                        <td>
                            <div class="row">
                                <% if (status == 5) {%>
                                <% if (idCategoria.equals("2")) {%>
                                <form name="abreDictamen" action="visor" method="POST" target="_blank">
                                    <input type="hidden" name="search" id="search" value="<%=rutaDictamen%>" >
                                    <button type="submit" class="btn btn-warning btn-sm" >Caracteristicas</button>
                                </form>
                                <% }%>
                                <%
                                    if (rutaDictamen != null || !rutaDictamen.equals("")) {
                                %>
                                <form action="formCotizacion.jsp" method="post">
                                    <input type="hidden" class="hidden" name="cantidad" value="<%=cantidadRequi%>" >
                                    <input type="hidden" class="hidden" name="idProducto" value="<%=idProducto%>" >
                                    <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                                    <button type="submit" class="btn btn-info btn-sm" >Hacer Cotizacion</button>
                                </form>
                                <%
                                } else {
                                %>
                                <button type="submit" class="btn btn-dark btn-sm" disabled="true">No disponible</button>
                                <%
                                    }
                                %>
                                <% } else if (status == 6) {
                                    ArrayList<CotizacionRequisicion> arrayRequis2 = new ArrayList<CotizacionRequisicion>();
                                    Consultas obj2 = new Consultas();
                                    arrayRequis2 = obj2.consultarProveedorCoti(idReqCoti, id_usuario);
                                    System.out.println(arrayRequis2.size());
                                    /* Consulta si el usuario activo ya realizo una cotizacion,
                                    si es asi, muesta un mensaje, si no, permite hacer una cotizacion
                                     */
                                    ruta = obj2.consultaArchivo(idReqCoti, Integer.parseInt(id_usuario));
                                    if (arrayRequis2.size() > 0) {%>
                                <div class="row">
                                    <button type="button" class="btn btn-success btn-sm">Cotizacion Realizada</button> 
                                    <form action="visor" method="post" target="_blank">
                                        <button type="submit" action="visor.jsp" value="<%=ruta%>" name="search" class="btn btn-dark btn-sm">Ver PDF</button> 
                                    </form>
                                </div>
                                <%} else {%>
                                <form action="formCotizacion.jsp" method="post">
                                    <input type="hidden" class="hidden" name="cantidad" value="<%=cantidadRequi%>" >
                                    <input type="hidden" class="hidden" name="idUsuario" value="<%=id_usuario%>" >
                                    <input type="hidden" class="hidden" name="idProducto" value="<%=idProducto%>" >
                                    <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                                    <button type="submit" class="btn btn-info btn-sm" >Hacer Cotizacion</button>
                                </form>
                                <% }
                                %>
                            </div>
                        </td>
                    </tr>
                    <% }
                            }
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
