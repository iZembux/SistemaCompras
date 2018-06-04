<%-- 
    Muestra las requisiciones disponibles por cada id de producto y categoria
    status 4
--%>

<%@page import="model.Proveedor"%>
<%@page import="controller.ConsultaBase"%>
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
        int id_categoria = 1;

        int idCategoria = 0;
        int idDepartamento = 0;
        int idSucursal = 0;
        int idProveedor = 0;
        
        try {
            idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        } catch (Exception e) {
        }
        try {
            idSucursal = Integer.parseInt(request.getParameter("idSucursal"));
        } catch (Exception e) {
        }
        try {
            idDepartamento = Integer.parseInt(request.getParameter("idDepartamento"));
        } catch (Exception e) {
        }
        try {
            idProveedor = Integer.parseInt(request.getParameter("idProveedor"));
        } catch (Exception e) {
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Ordenes de compra</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Requisicion</th>
                        <th scope="col">Solicitante</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Producto</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idReqProd;
                        String producto;
                        String solicitante;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();

                        arrayRequis = obj.consultarOrdenesProvAcumDetalle(idProveedor , idSucursal, idCategoria, idDepartamento);
                        ArrayList<Integer> req2 = new ArrayList<Integer>();

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idReqProd = arrayRequis.get(i).getIdReqProd();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                req2.add(idReqProd);
                    %>
                    <tr>
                        <td><%=idReqProd%></td>
                        <td><%=solicitante%></td>
                        <td><%=cantidadRequi%></td>
                        <td><%=producto%></td>
                        
                    </tr>
                    <% }
                        }
                    %>
                </tbody>
            </table>

                <form action="actualizaOrdenCompras.jsp" method="post">
                    <input type="hidden" class="hidden" name="categoria" value="<%=idCategoria %>" >
                    <input type="hidden" class="hidden" name="proveedor" value="<%=idProveedor %>" >
                    <input type="hidden" class="hidden" name="suc" value="<%=idSucursal %>" >
                    <input type="hidden" class="hidden" name="dep" value="<%=idDepartamento %>" >
                    <input type="hidden" class="hidden" name="tam" value="<%=req2.size() %>" >
                    <% for (int i = 0; i < req2.size(); i++) { %>
                    <input type="hidden" class="hidden" name="idReqProd<%=i%>" value="<%=req2.get(i) %>" >
                    <% } %>
                    <button type="submit" class="btn btn-success btn-sm" >Guardar Orden</button>  
                </form>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>
