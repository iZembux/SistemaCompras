<%-- 
    Autorizacion de comparativos por parte del director administrativo
--%>
<%@page import="model.Comparativo"%>
<%@page import="model.OrdenFormato"%>
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
        String idDepto = (String) sesion.getAttribute("departamento");
        String rol = (String) sesion.getAttribute("rol");
        String usuario = (String) sesion.getAttribute("idUsuario");
        String suc = null;

        int id_categoria = 1;
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
        <title>Comparativos</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Comparativos por revisar</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Id Cuadro/Formato</th>
                        <th scope="col">Departamento Solicitante</th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int idCuadro;
                        int idFormatoUnico;
                        int cantidad;
                        String depto;
                        String observaciones = "";
                        int idReqProd;
                        String rutaDictamen;
                        String rutaCotizacion;

                        ArrayList<Comparativo> arrayRequis = new ArrayList<Comparativo>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarCuadrosComparativos(7);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idCuadro = arrayRequis.get(i).getIdCuadro();
                                idFormatoUnico = arrayRequis.get(i).getIdFormatoUnico();
                                depto = arrayRequis.get(i).getDepartamento();
                                cantidad = arrayRequis.get(i).getCantidad();
                                observaciones = arrayRequis.get(i).getObservaciones();
                                idReqProd = arrayRequis.get(i).getIdReqProd();
                                rutaDictamen = arrayRequis.get(i).getRutaDictamen();
                                rutaCotizacion = arrayRequis.get(i).getRutaCotizacion();
                    %>
                    <tr>
                        <% if (idFormatoUnico == 0 && idCuadro > 0) {%>
                        <td><%=idCuadro%></td>
                        <% } else {%>
                        <td><%=idFormatoUnico%></td>
                        <% }%>
                        <td><%=depto%></td>
                        <td></td>
                        <td>
                            <form action="formatos/requisicion.jsp" method="post" target="_blank">
                                <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                <button type="submit" class="btn btn-default btn-sm">Ver Requisicion</button>
                            </form>
                        </td>
                        <td>
                            <%
                                if (rutaDictamen == null || !rutaDictamen.equals("")) {
                            %>
                            <form name="abreDictamen" action="visor" method="POST" target="_blank">
                                <input type="hidden" name="search" id="search" value="<%=rutaDictamen%>" >
                                <button type="submit" class="btn btn-outline-dark btn-sm" >Ver Dictamen</button>
                            </form>
                            <%}%>
                        </td>
                        <td>
                            <form name="abrePDF" action="visor" method="POST" target="_blank">
                                <input type="hidden" name="search" id="search" value="<%=rutaCotizacion%>" >
                                <button type="submit" class="btn btn-default btn-sm" >Ver Cotizacion</button>
                            </form>
                        </td>
                        <td>
                            <div class="row">
                                <% if (idFormatoUnico == 0 && idCuadro > 0) {%>
                                <form action="formatos/comparativo_2.jsp" method="post">
                                    <input type="hidden" name="cuadro" value="<%=idCuadro%>" >
                                    <input type="hidden" name="idUsu" value="<%=usuario%>" >
                                    <input type="hidden" name="observaciones" value="<%=observaciones%>" >
                                    <button type="submit" class="btn btn-info btn-sm" >Ver Cuadro</button>
                                </form>
                                <% } else {%>
                                <form action="formatos/proveedorUnico_1.jsp" method="post">
                                    <input type="hidden" name="idFormato" value="<%=idFormatoUnico %>" >
                                    <input type="hidden" name="idUsu" value="<%=usuario%>" > 
                                    <button type="submit" class="btn btn-info btn-sm" >Ver Formato</button>
                                </form>
                                <% } %>
                            </div>
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
