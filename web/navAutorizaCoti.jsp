
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%
    int idCotizacion = 0;
    int idRequiSeleccionada = 0;
    int autorizacion = 0;

    try {
        idRequiSeleccionada = Integer.parseInt(request.getParameter("idRequi"));
    } catch (Exception e) {
    }
    try {
        autorizacion = Integer.parseInt(request.getParameter("autorizacion"));
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
            <jsp:param name="rol" value="4" />  
            <jsp:param name="depto" value="3" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Cotizaciones por Autorizar</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">No. Requisicion</th>
                        <th scope="col">Producto</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Detalle</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int idRequi;
                        int cantidadRequi;
                        String producto;
                        String fecha;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarRequiGerente(idCotizacion);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idRequi = arrayRequis.get(i).getIdRequisicion();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getSolicitante();
                                fecha = arrayRequis.get(i).getFecha();
                    %>
                    <tr>
                        <td><%=idRequi%></td>
                        <td><%=producto%></td>
                        <td><%=cantidadRequi%></td>
                        <td><%=fecha%></td>
                        <td>
                            <form action="navAutorizaCoti.jsp" method="post">
                                <input type="hidden" name="idRequi" value="<%=idRequi%>" >
                                <button type="submit" class="btn btn-primary btn-sm">Cotizaciones</button>
                            </form>
                        </td>
                        <td>
                            <button type="button" class="btn btn-success btn-sm">Autorizar</button>
                            <button type="button" class="btn btn-danger btn-sm">Rechazar</button>
                        </td>
                    </tr>
                    <% }
                        }%>
                </tbody>
            </table>
            <jsp:include page="frag/modalAutorizaCoti.jsp">
                <jsp:param name="idRequi" value="<%=idRequiSeleccionada%>" /> 
            </jsp:include>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
