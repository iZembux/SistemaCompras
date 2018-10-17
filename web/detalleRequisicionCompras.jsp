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
        String suc = null;

        if (usuario.equals("83")) {       //Valeria
            suc = "1,2,3,4,6,7,8,13";
        } else if (usuario.equals("4") || usuario.equals("268")) { //Veronica
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
        } else if (usuario.equals("25")) { //Angelica
            suc = "10,11,15,16,18";
        } else if (usuario.equals("226")) { //Roberto
            suc = "9,14,17";
        } else if (usuario.equals("268")) { //Victor Peralta
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
        } else if (usuario.equals("48")) { //Esau
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
        }

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

        <div class="container my-5">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Producto</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Solicitante</th>
                        <th scope="col">Departamento</th>
                        <th scope="col">Sucursal</th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        String departamento;
                        int idReqProd;
                        int idUsu;
                        String producto;
                        String solicitante;
                        String sucursal;
                        String rutaCaratula;
                        String rutaDictamen;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        ConsultaBase obCB = new ConsultaBase();

                        arrayRequis = obj.consultarComprasDetalle(idCategoria, idProducto, suc);
                        ArrayList<Integer> req2 = new ArrayList<Integer>();

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idReqProd = arrayRequis.get(i).getIdReqProd();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                departamento = obCB.obtieneDepartamento(arrayRequis.get(i).getIdDepto());
                                sucursal = arrayRequis.get(i).getSucursal();
                                idUsu = arrayRequis.get(i).getIdSolicita();
                                req2.add(idReqProd);
                                rutaCaratula = arrayRequis.get(i).getRutaCaratula();
                                rutaDictamen = arrayRequis.get(i).getRutaDictamen();
                                System.out.println(idReqProd);
                    %>
                    <tr>
                        <td><%=producto%></td>
                        <td><%=cantidadRequi%></td>
                        <td><%=solicitante.toUpperCase()%></td>
                        <td><%=departamento%></td>
                        <td><%=sucursal%></td>
                        <td>
                            <% if (idCategoria == 2) { %>
                            <div class="row">
                                <%
                                    if (rutaCaratula == null || rutaCaratula.equals("") || rutaCaratula.equals("*")) {
                                    } else {
                                %>
                                <form name="abreCaratula" action="visor" method="POST" target="_blank">
                                    <input type="hidden" name="search" id="search" value="<%=rutaCaratula%>" >
                                    <button type="submit" class="btn btn-dark btn-sm" >Ver Car&aacute;tula</button>
                                </form>
                                <% }
                                    if (rutaDictamen == null || !rutaDictamen.equals("")) {
                                %>
                                <form name="abreDictamen" action="visor" method="POST" target="_blank">
                                    <input type="hidden" name="search" id="search" value="<%=rutaDictamen%>" >
                                    <button type="submit" class="btn btn-outline-dark btn-sm" >Ver Dictamen</button>
                                </form>
                                <%}%>
                            </div>
                            <% } else {
                                if (idCategoria != 7) {
                            %>
                            <form action="actualizaRecibido.jsp" method="post">
                                <input type="hidden" class="hidden" name="nuevoStatus" value="12" >
                                <input type="hidden" class="hidden" name="idUsu" value="<%=idUsu%>" >
                                <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                <input type="hidden" class="hidden" name="producto" value="<%=producto%>" >
                                <input type="hidden" class="hidden" name="cantidad" value="<%=cantidadRequi%>" >
                                <input type="hidden" class="hidden" name="categoria" value="<%=idCategoria%>" >
                                <input type="hidden" class="hidden" name="idProducto" value="<%=idProducto%>" >
                                <input type="hidden" class="hidden" name="stock" value="1" >
                                <button type="submit" class="btn btn-success btn-sm">Producto en Stock</button>
                            </form>
                            <% }
                                }%>
                        </td>
                        <td>
                            <form action="formatos/requisicion.jsp" method="post" target="_blank">
                                <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                <button type="submit" class="btn btn-info btn-sm">Ver Requisicion</button>
                            </form>
                        </td>
                        <td>
                            <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#modal<%=i%>">
                                Rechazar
                            </button>
                        </td>  
                    </tr>
                <div class="modal fade" id="modal<%=i%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Motivo de Rechazo Id <%=idReqProd%></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form action="eliminaRequisicion.jsp" method="post">
                                <div class="modal-body">
                                    <textarea class="form-control" rows="5" id="rechazo" name="rechazo"></textarea>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" class="hidden" name="idUsu" value="<%=idUsu%>" >
                                    <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                    <button type="submit" class="btn btn-primary">Continuar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <% }
                    }
                %>
                </tbody>
            </table>

            <div >
                <form action="actualizaCompras.jsp" method="post">
                    <input type="hidden" class="hidden" name="nuevoStatus" value="5" >
                    <input type="hidden" class="hidden" name="categoria" value="<%=idCategoria%>" >
                    <input type="hidden" class="hidden" name="suc" value="<%=suc%>" >
                    <input type="hidden" class="hidden" name="usuario" value="<%=usuario%>" >
                    <input type="hidden" class="hidden" name="tam" value="<%=req2.size()%>" >
                    <% for (int i = 0; i < req2.size(); i++) {%>
                    <input type="hidden" class="hidden" name="idReqProd<%=i%>" value="<%=req2.get(i)%>" >
                    <% } %>
                    <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modalProveedores">Solicitar Cotizaciones</button>

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
                                        <input type="hidden" class="hidden" name="idProducto" value="<%= idProducto%>" >
                                        <input type="hidden" class="hidden" name="numProveedores" value="<%=prov.size()%>" >
                                        <% if (idCategoria == 7) { %>
                                        <div class="form-check">
                                            <label>
                                                <input class="form-check-input" type="checkbox" name="checkboxCont" value="1">
                                                <b>Requiere intervencion legal (contrato, asesoría, etc.)</b>
                                            </label>
                                        </div>
                                        <% } %>
                                        <input type="submit" class="btn btn-primary" value="Solicitar" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>
