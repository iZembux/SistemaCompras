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
                        <th scope="col">Precio</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idReqProd;
                        int idReqCoti;
                        int idCuadro = 0;
                        double precio;
                        double total = 0;
                        String producto;
                        String solicitante;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();

                        arrayRequis = obj.consultarOrdenesProvAcumDetalle(idProveedor, idSucursal, idCategoria, idDepartamento);
                        ArrayList<Integer> req2 = new ArrayList<Integer>();
                        ArrayList<Integer> req3 = new ArrayList<Integer>();

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                precio = arrayRequis.get(i).getPrecio();
                                idReqProd = arrayRequis.get(i).getIdReqProd();
                                idReqCoti = arrayRequis.get(i).getIdReqCoti();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                idCuadro = arrayRequis.get(i).getIdCuadro();
                                req2.add(idReqProd);
                                total += precio;
                    %>
                    <tr>
                        <td><%=idReqProd%></td>
                        <td><%=solicitante.toUpperCase()%></td>
                        <td><%=cantidadRequi%></td>
                        <td><%=producto%></td>
                        <td>$ <%=precio%></td>
                    </tr>
                    <% }
                        }
                    %>
                </tbody>
            </table>
            <div>
                <h5> Precio Total: $<%=total%></h5>
                <% if (idCuadro > 0) { %>
                <hr>
                <h6> Comparativo Aprobado </h6>
                <% } %>
                <br />
                <form action="actualizaOrdenCompras.jsp" method="post">
                    <% if (total >= 7500 && idCuadro == 0) { %> 
                    <span>*Monto de la compra mayor a $7500.00, es necesario generar un cuadro comparativo</span>
                    <br />
                    <br />
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cuadro" >Generar Comparativo</button>
                    <% } else {%>
                    <input type="hidden" class="hidden" name="categoria" value="<%=idCategoria%>" >
                    <input type="hidden" class="hidden" name="proveedor" value="<%=idProveedor%>" >
                    <input type="hidden" class="hidden" name="suc" value="<%=idSucursal%>" >
                    <input type="hidden" class="hidden" name="dep" value="<%=idDepartamento%>" >
                    <input type="hidden" class="hidden" name="tam" value="<%=req2.size()%>" >
                    <% for (int i = 0; i < req2.size(); i++) {%>
                    <input type="hidden" class="hidden" name="idReqProd<%=i%>" value="<%=req2.get(i)%>" >
                    <% } %>
                    <button type="submit" class="btn btn-success btn-sm" >Guardar Orden</button>  
                    <% } %>
                </form>
            </div>
        </div>

        <%
            boolean b = false;
            for (int i = 0; i < req2.size(); i++) {
                int totalCotizaciones = obj.consultarCantidadCot(req2.get(i));
                if (totalCotizaciones < 1) {
                    req3.add(req2.get(i));
                    b = true;
                }
            }
        %>
        <div class="modal fade" id="cuadro" tabindex="-1" role="dialog" aria-labelledby="cuadro" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form action="formatos/comparativo_1.jsp" method="post" name="formulario" id="formulario">
                        <div class="modal-body">
                            <% if (!b) {%>
                            <h5>Observaciones</h5>
                            <p>
                                Introduzca las observaciones que se mostrarán en el cuadro comparativo (Opcional):
                            </p>
                            <div class="form-group">
                                <textarea class="form-control" id="observaciones" name="observaciones" rows="3"></textarea>
                            </div>
                            <input type="hidden" class="hidden" name="tam" value="<%=req2.size()%>" >
                            <% for (int i = 0; i < req2.size(); i++) {%>
                            <input type="hidden" class="hidden" name="idReqProd<%=i%>" value="<%=req2.get(i)%>" >
                            <% } %>
                            <% } else { %>
                            <h5>Cotizaciones insuficientes</h5>
                            <p>
                                Para generar el cuador comparativo es necesario tener al menos tres cotizaciones, 
                                favor de solicitar cotizaciones para las siguientes requisiciones:
                            </p>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">Requisicion</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%

                                        for (int i = 0; i < req2.size(); i++) {
                                            int totalCotizaciones = obj.consultarCantidadCot(req2.get(i));
                                            if (totalCotizaciones < 3) {
                                                req3.add(req2.get(i));
                                    %>

                                    <tr>
                                        <td><%=req2.get(i)%></td>
                                    </tr>
                                    <% }
                                        } %>
                                </tbody>
                            </table>
                            <% }%>
                        </div>
                        <% if (!b) { %>
                        <div class="modal-footer">
                            <button type="submit">Aceptar</button>
                        </div>
                        <% } else { %>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modalProveedores">Solicitar Cotizaciones</button>
                        </div>
                        <% }%> 
                    </form>
                </div>
            </div>
        </div>

        <div>
            <form action="actualizaCompras_1.jsp" method="post">
                <input type="hidden" class="hidden" name="nuevoStatus" value="19">
                <input type="hidden" class="hidden" name="categoria" value="<%=idCategoria%>" >
                <input type="hidden" class="hidden" name="tam" value="<%=req3.size()%>" >
                <% for (int i = 0; i < req3.size(); i++) {%>
                <input type="hidden" class="hidden" name="idReqProd<%=i%>" value="<%=req3.get(i)%>" >
                <% } %>

                <div class="modal fade" id="modalProveedores" tabindex="-1" role="dialog" aria-labelledby="modalProveedores" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Detalles de Proveedores</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>Selecciona los proveedores a los que se les enviará una solicitud de cotización</label>
                                    <label>No incluir a los proveedores seleccionados en la primer cotización</label>
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Proveedor</th>
                                                <th>Direccion</th>
                                                <th>Telefono</th>
                                                <th>Seleccionar</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <%
                                                    Consultas obj2 = new Consultas();
                                                    ArrayList<Proveedor> prov = obj2.consultarProveedor(idCategoria);
                                                    for (int j = 0; j < prov.size(); j++) {
                                                %>
                                                <td><%= prov.get(j).getRazonSocial()%></td>
                                                <td><%= prov.get(j).getDireccion()%></td>
                                                <td><%= prov.get(j).getTelefono()%></td>
                                                <td>
                                                    <div class="form-check">
                                                        <label>
                                                            <input class="form-check-input" type="checkbox" name="checkbox<%=j%>" value="<%= prov.get(j).getIdProveedor()%>">
                                                        </label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <% }%> 
                                        </tbody>
                                    </table>

                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" class="hidden" name="numProveedores" value="<%=prov.size()%>" >
                                    <input type="submit" class="btn btn-primary" value="Solicitar" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>
