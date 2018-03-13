<%-- 
    Document   : usuarioSeguimiento
    Created on : Mar 5, 2018, 7:55:17 AM
    Author     : user
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%@page import="controller.Consultas"%>
<%
    int idUusario = 1;
    int departamento = 1;
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
            <jsp:param name="depto" value="5" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Requisiciones por Autorizar</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Solicitante</th>
                        <th scope="col">Cantidad de Productos</th>
                        <th scope="col">Fecha</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%                        int idRequi;
                        int cantidadRequi;
                        String solicitante;
                        String fecha;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarRequiGerente(departamento);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idRequi = arrayRequis.get(i).getIdRequisicion();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                fecha = arrayRequis.get(i).getFecha();
                    %>
                    <tr>
                        <td><%=idRequi%></td>
                        <td><%=solicitante%></td>
                        <td><%=cantidadRequi%></td>
                        <td><%=fecha%></td>
                        <td>
                            <form action="navAutorizaRequi.jsp" method="post">
                                <input type="hidden" name="idRequi" value="<%=idRequi%>" >
                                <button type="submit" class="btn btn-primary btn-sm">Detalle</button>
                            </form>
                        </td>
                    </tr>
                    <% }
                        }%>
                </tbody>
            </table>
            <nav aria-label="...">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1">Previous</a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item active">
                        <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#">Next</a>
                    </li>
                </ul>
            </nav>
            <jsp:include page="frag/modalAutorizaRequi.jsp">
                <jsp:param name="idRequi" value="<%=idRequiSeleccionada%>" /> 
            </jsp:include>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
