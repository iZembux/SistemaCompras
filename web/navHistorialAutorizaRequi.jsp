
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%
    int departamento = 1;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Historial</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="4" />  
            <jsp:param name="depto" value="3" />
        </jsp:include>


        <div class="container my-5">
            <div class="page-header">
                <h3>Historial de Autorizaciones</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Solicitante</th>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Justificacion</th>
                        <th scope="col">Descripcion</th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int idRequi;
                        int cantidad;
                        String solicitante;
                        String producto;
                        String marca;
                        String justificacion;
                        String descripcion;
                        String fecha;
                        String status;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarHistorialGerente(departamento);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idRequi = arrayRequis.get(i).getIdRequisicion();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                justificacion = arrayRequis.get(i).getJustificacion();
                                descripcion = arrayRequis.get(i).getDescripcion();
                                cantidad = arrayRequis.get(i).getCantidad();
                                status = arrayRequis.get(i).getStatus();
                                fecha = arrayRequis.get(i).getFecha();
                    %>
                    <tr>
                        <td><%=idRequi%></td>
                        <td><%=solicitante%></td>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidad%></td>
                        <td><%=justificacion%></td>
                        <td><%=descripcion%></td>
                        <td><%=fecha%></td>
                        <td><b><%=status%></b></td>
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
