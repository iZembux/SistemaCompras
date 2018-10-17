<%-- 
    Muestra las requisiciones disponibles del area de tecnologia para
    la autorizacion del gerente administrativo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%@page import="controller.Consultas"%>
<%
    HttpSession sesion = request.getSession();
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String idDepto = (String) sesion.getAttribute("departamento");
        String rol = (String) sesion.getAttribute("rol");
        String sucursal = (String) sesion.getAttribute("sucursal");

        String idUsu = (String) sesion.getAttribute("idUsuario");
        String idDepto2 = idDepto;
        String suc = "0";
        if (idUsu.equals("34")) {
            suc = "1,2,3,4,5,6,7";
        } else if (idUsu.equals("210")) {
            suc = "9,14";
        } else if (idUsu.equals("97")) {
            suc = "8,13,17";
        } else if (idUsu.equals("88")) {
            suc = "10,11,15,16,18";
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
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
            <jsp:param name="idUsu" value="<%=idUsu%>" />
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
                    <%

                        int idRequi;
                        int cantidadRequi;
                        String solicitante;
                        String fecha;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarRequiGeneral(idDepto2, suc);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idRequi = arrayRequis.get(i).getIdRequisicion();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                fecha = arrayRequis.get(i).getFecha();
                    %>
                    <tr>
                        <td><%=idRequi%></td>
                        <td><%=solicitante.toUpperCase()%></td>
                        <td><%=cantidadRequi%></td>
                        <td><%=fecha%></td>
                        <td>
                            <form action="detalleAutorizaRequiGeneral.jsp" method="post">
                                <input type="hidden" name="idRequi" value="<%=idRequi%>" >
                                <button type="submit" class="btn btn-primary btn-sm">Detalle</button>
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
