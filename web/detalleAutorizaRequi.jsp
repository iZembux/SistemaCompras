<%-- 
    Muestra las requisiciones disponibles para la autorizacion del gerente por cada requisicion
    status = 3
--%>

<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%
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
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="3" />  
            <jsp:param name="depto" value="5" />
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
                        String producto;
                        String marca;
                        String justificacion;
                        String descripcion;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarDetalleRequiGerente(idRequi);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idReqProd = arrayRequis.get(i).getIdReqProd();
                                cantidad = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                justificacion = arrayRequis.get(i).getJustificacion();
                                descripcion = arrayRequis.get(i).getDescripcion();
                    %>
                    <tr>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidad%></td>
                        <td><%=justificacion%></td>
                        <td><%=descripcion%></td>
                        <td>
                            <div class="row">
                                <form action="actualizaGerente.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                    <input type="hidden" class="hidden" name="nuevoStatus" value="4" >
                                    <input type="hidden" class="hidden" name="autoriza" value="1" >
                                    <button type="submit" class="btn btn-success btn-sm">Autorizar</button>
                                </form>
                                <form action="actualizaGerente.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                    <input type="hidden" class="hidden" name="nuevoStatus" value="13" >
                                    <input type="hidden" class="hidden" name="autoriza" value="2" >
                                    <button type="submit" class="btn btn-danger btn-sm">Rechazar</button>
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
