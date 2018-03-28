<%-- 
    Muestra las requisiciones disponibles por cada id de producto y categoria
    status 4
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

        int idCategoria = 0;
        int idProducto = 0;
        try {
            idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        } catch (Exception e) {
        }
        try {
            idProducto = Integer.parseInt(request.getParameter("idProducto"));
        } catch (Exception e) {
        }
%>
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
        </jsp:include>

        <div class="container">
            <div class="jumbotron">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th scope="col">Producto</th>
                            <th scope="col">Cantidad</th>
                            <th scope="col">Solicitante</th>
                            <th scope="col">Departamento</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int cantidadRequi;
                            int departamento;
                            int idReqProd;
                            String producto;
                            String solicitante;

                            ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                            Consultas obj = new Consultas();
                            arrayRequis = obj.consultarComprasDetalle(idCategoria, idProducto);

                            if (arrayRequis.size() > 0) {
                                for (int i = 0; i < arrayRequis.size(); i++) {
                                    idReqProd = arrayRequis.get(i).getIdReqProd();
                                    cantidadRequi = arrayRequis.get(i).getCantidad();
                                    producto = arrayRequis.get(i).getProducto();
                                    solicitante = arrayRequis.get(i).getSolicitante();
                                    departamento = arrayRequis.get(i).getIdDepto();

                        %>
                        <tr>
                            <td><%=producto%></td>
                            <td><%=cantidadRequi%></td>
                            <td><%=solicitante%></td>
                            <td><%=departamento%></td>
                            <td><form action="formatos/requisicion.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                    <button type="submit" class="btn btn-success btn-sm">Ver Requisicion</button>
                                </form>
                            </td>
                        </tr>
                        <% }
                            }%>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>
