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
        String usuario = (String) sesion.getAttribute("idUsuario");
        String usu = null;
        usu = usuario;
        if (usuario.equals("4")) {
            usu = "4,25,83,226,268";
        }

        int id_categoria = 0;
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
        <title>Cotizaciones</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Cotizaciones Disponibles</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idProducto;
                        int idReqCoti;
                        int idStatus;
                        String producto;
                        String marca;
                        String comentario;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarComprasCotizaciones(id_categoria, "6", usu);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idProducto = arrayRequis.get(i).getIdProducto();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                idReqCoti = arrayRequis.get(i).getIdReqCoti();
                                idStatus = arrayRequis.get(i).getIdStatus();
                                comentario = arrayRequis.get(i).getComentarioCancela();
                    %>
                    <tr>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidadRequi%></td> 
                        <td>
                            <form action="detalleCotizacionCompras.jsp" method="post">
                                <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                                <input type="hidden" class="hidden" name="idProducto" value="<%=idProducto%>" >
                                <input type="hidden" class="hidden" name="idUsu" value="<%=usuario%>" >
                                <input type="hidden" class="hidden" name="categoria" value="<%=id_categoria%>" >
                                <button type="submit" class="btn btn-primary btn-sm">Ver Cotizaciones</button>
                                <%
                                    try {
                                        if (comentario.equals("") || comentario == null) {
                                        } else {
                                %>
                                <button type="button" class="btn btn-danger btn-sm" onclick="abre();">Ver Comentarios</button>
                                <%
                                        }
                                    } catch (Exception e) {
                                        System.out.println("COMENTARIO: NULL");
                                    }
                                %>
                            </form>
                        </td>
                        <%
                            try {
                                if (comentario.equals("") || comentario == null) {
                                } else {
                        %>
                        <!-- Modal Muestra Comentarios -->
                        <div class="modal fade" id="myModal" role="dialog">
                            <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Motivo del Rechazo</h4>
                                        <button type="button" class="close" data-dismiss="modal">×</button>
                                    </div>
                                    <div class="modal-body form-control">
                                        <input type="hidden" class="hidden Orden" id="idReqP" name="idReqP" value="">
                                        <label for="comentarios">Comentarios de Cancelación</label>
                                        <textarea class="form-control" rows="6" id="datosProducto" name="comentarios" disabled="true" required="true" style="resize: none;"><%=comentario%></textarea>
                                        <br>
                                        <center><input type="button" data-dismiss="modal" class="btn btn-success" value="CERRAR"/></center>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            } catch (Exception e) {
                            }
                        %>
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
        <script type="text/javascript">
            function mandarDato() {
                $("#idReqP").val($("#idRP").val());
                var b = $("#idReqP").val();
            }
            function abre() {
                $('#myModal').modal({show: true});
            }
        </script>
    </body>
</html>
<% }%>