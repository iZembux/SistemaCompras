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
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String id_usuario = (String) sesion.getAttribute("idUsuario");
        int idCategoria = 1;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Autorizar</title>
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
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idProducto;
                        int idRequi;
                        int idReqCoti;
                        int status;
                        String producto;
                        String marca;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        /*Consulta requisiciones dependiendo de su status 
                        status 5 - sin ninguna cotizacion
                        status 6 - con al menus una cotizacion
                        status 10 - cotizacion autorizada
                         */
                        arrayRequis = obj.consultarComprasProv(idCategoria, "5,6,10");

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idRequi = arrayRequis.get(i).getIdRequisicion();
                                idProducto = arrayRequis.get(i).getIdProducto();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                idReqCoti = arrayRequis.get(i).getIdReqCoti();
                                status = arrayRequis.get(i).getIdStatus();
                    %>
                    <tr>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidadRequi%></td> 
                        <td>
                            <% if (status == 5) {%>
                            <form action="formCotizacion.jsp" method="post">
                                <input type="hidden" class="hidden" name="cantidad" value="<%=cantidadRequi%>" >
                                <input type="hidden" class="hidden" name="idProducto" value="<%=idProducto%>" >
                                <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                                <button type="submit" class="btn btn-primary btn-sm">Hacer Cotizacion</button>
                            </form>
                            <% } else if (status == 6) {
                                ArrayList<CotizacionRequisicion> arrayRequis2 = new ArrayList<CotizacionRequisicion>();
                                Consultas obj2 = new Consultas();
                                arrayRequis2 = obj2.consultarProveedorCoti(idReqCoti, id_usuario);
                                System.out.println(arrayRequis2.size());
                                /* Consulta si el usuario activo ya realizo una cotizacion,
                                si es asi, muesta un mensaje, si no, permite hacer una cotizacion
                                 */
                                if (arrayRequis2.size() > 0) { %>
                            <button type="button" class="btn btn-info btn-sm">Ya haz realizado una cotizacion</button> 
                            <!--<form method="post" action="subir.jsp" enctype="multipart/form-data">
                                <div>
                                <input type="file" id="archivo" name="archivo" onchange="nombre_ar(this.id);">
                                <input type="submit" class="btn btn-primary" value="Enviar" />
                                </div>
                            </form>-->
                            <%} else {%>
                            <form action="formCotizacion.jsp" method="post">
                                <input type="hidden" class="hidden" name="cantidad" value="<%=cantidadRequi%>" >
                                <input type="hidden" class="hidden" name="idUsuario" value="<%=id_usuario%>" >
                                <input type="hidden" class="hidden" name="idProducto" value="<%=idProducto%>" >
                                <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                                <button type="submit" class="btn btn-primary btn-sm">Hacer Cotizacion</button>
                            </form>
                            <% }
                            } else if (status == 10) {
                                ArrayList<CotizacionRequisicion> arrayRequis2 = new ArrayList<CotizacionRequisicion>();
                                Consultas obj2 = new Consultas();
                                arrayRequis2 = obj2.consultarProveedorCoti(idReqCoti, id_usuario);
                                System.out.println(arrayRequis2.size());
                                // Consulta si el usuario activo ha ganado la licitacion
                                if (arrayRequis2.size() > 0) {%>
                            <div class="row">
                                <form action="detalleRequisicionesProveedor.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                                    <button type="submit" class="btn btn-success btn-sm">Cotizacion Ganadora</button>
                                </form>
                            </div>
                            <%} else {%>
                            <button type="submit" class="btn btn-primary btn-sm">Cotizacion Perdida</button>
                            <% }
                                }
                            %>
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