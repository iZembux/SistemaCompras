<%-- 
    Muestra las requisiciones disponibles para la autorizacion del gerente por cada requisicion
    status = 3
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
        String idUsu = (String) sesion.getAttribute("idUsuario");

        int idRequi = 0;
        try {
            idRequi = Integer.parseInt(request.getParameter("idRequi"));
        } catch (Exception e) {
        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Autorizar</title>
        <script>
            function alerta() {
                confirm("¿Seguro que desea autorizar esta requisicion?");
            }
            function alerta2() {
                confirm("¿Seguro que desea rechazar esta requisicion?");
            }
        </script>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <form action="menuAutorizaRequi.jsp" method="post">
                <button type="submit" class="btn btn-primary btn-sm ml-auto">Regresar</button>
            </form>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Justificación</th>
                        <th scope="col">Descripcion</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%                //Consulta por idRequi seleccionada
                        int idReqProd;
                        int cantidad;
                        int idSolicita;
                        int categoria;
                        String producto;
                        String marca;
                        String justificacion;
                        String descripcion;
                        String rutaCaratula;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarDetalleDictamen(idRequi);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idSolicita = arrayRequis.get(i).getIdSolicita();
                                idReqProd = arrayRequis.get(i).getIdReqProd();
                                cantidad = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                justificacion = arrayRequis.get(i).getJustificacion();
                                descripcion = arrayRequis.get(i).getDescripcion();
                                categoria = arrayRequis.get(i).getIdCategoria();
                                rutaCaratula = arrayRequis.get(i).getRutaCaratula();
                    %>
                    <tr>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidad%></td>
                        <td><%=justificacion.toUpperCase()%></td>
                        <td><%=descripcion.toUpperCase()%></td>
                        <td>
                            <div class="row">
                                <%
                                    if (rutaCaratula != null || rutaCaratula != "") {
                                %>
                                <form name="abreCaratula" action="visor" method="POST" target="_blank">
                                    <input type="hidden" name="search" id="search" value="<%=rutaCaratula%>" >
                                    <button type="submit" class="btn btn-dark btn-sm" >Ver Factura</button>
                                </form>
                                <%} else {%>
                                    <button type="submit" class="btn btn-dark btn-sm" disabled="true">No disponible</button>
                                <%}%>
                                <form action=".jsp" method="post">
                                    <button type="submit" class="btn btn-warning btn-sm" onclick="alerta2()">Subir Dictamen</button>
                                </form>
                                <form action="actualizaDictamen.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                    <input type="hidden" class="hidden" name="nuevoStatus" value="16" >
                                    <button type="submit" class="btn btn-success btn-sm" onclick="alerta()">Autorizar</button>
                                </form>
                                <form action="actualizaDictamen.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                    <input type="hidden" class="hidden" name="nuevoStatus" value="17" >
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="alerta2()">Rechazar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% }
                        }%>
                </tbody>
            </table>
            <div class="row">

            </div>
        </div>
        <jsp:include page="frag/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>