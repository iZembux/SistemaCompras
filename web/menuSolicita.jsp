<%-- 
    Document   : gerente
    Created on : Mar 1, 2018, 9:19:46 AM
    Author     : user
--%>

<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Item"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession sesion = request.getSession();
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String idDepto = (String) sesion.getAttribute("departamento");
        String rol = (String) sesion.getAttribute("rol");
        String id_usuario = (String) sesion.getAttribute("idUsuario");
        String nombre = (String) sesion.getAttribute("nombre");
        String sucursal = (String) sesion.getAttribute("sucursal");

        int rol2 = Integer.parseInt(rol);

        int nuevaRequisicion = 1;

        try {
            nuevaRequisicion = Integer.parseInt(request.getParameter("nuevaRequisicion"));
        } catch (Exception e) {
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Nueva Requisicion</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
            <jsp:param name="idUsu" value="<%=id_usuario%>" />
        </jsp:include>

        <div class="container">

            <!-- Jumbotron Header -->
            <header class="jumbotron my-4">
                <div class="row">
                    <div class="col-lg-7">
                        <h3 class="display-5">Hola <%=nombre%>! </h3>
                        <h3 class="display-5">Bienvenido al sistema de compras</h3>
                        <p class="lead">Selecciona la caegoria de los productos que deseas solicitar</p>
                    </div>
                    <div class="col-lg-3">
                        <img class="img-fluid" style="opacity: 0.5;" src="img/compras.jpg" alt="">
                    </div>
                </div>
            </header>

            <div class="row text-center">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/papeleria.jpg" alt="" style="height: 180px">
                        <div class="card-body">
                            <h4 class="card-title">Papeleria</h4>
                            <p class="card-text">Hojas, Cuadernos, Lapices, Engrapadoras, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalPapeleria">Solicitar</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/tecnologia.jpg" alt="" style="height: 180px">
                        <div class="card-body">
                            <h4 class="card-title">Tecnología</h4>
                            <p class="card-text">PC, Mouse, Teclados, Memorias, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalTecnologia">Solicitar</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/cafeteria.jpg" alt="" style="height: 180px">
                        <div class="card-body">
                            <h4 class="card-title">Cafetería</h4>
                            <p class="card-text">Café, Galletas, Té, Servilletas, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalCafeteria">Solicitar</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/servicios.jpg" alt="" style="height: 180px">
                        <div class="card-body">
                            <h4 class="card-title">Servicios</h4>
                            <p class="card-text">Eventos, Hoteles, Servicios Generales, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalServicios">Solicitar</a>
                        </div>
                    </div>
                </div>

            </div>
            <!----------------------------------------------------------------->
            <div class="row text-center">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/jarceria.jpg" alt="" style="height: 180px">
                        <div class="card-body">
                            <h4 class="card-title">Jarceria</h4>
                            <p class="card-text">Escobas, Trapeadores, Cubetas, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalJarceria">Solicitar</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/herramientas.jpg" alt="" style="height: 180px">
                        <div class="card-body">
                            <h4 class="card-title">Ferreteria</h4>
                            <p class="card-text">Pinzas, Desarmadores, Martillos, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalFerreteria">Solicitar</a>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <!--MODAL PAPELERIA-->
        <div class="modal fade" id="modalPapeleria" tabindex="-1" role="dialog" aria-labelledby="modalError" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles del Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="insertaProducto.jsp">
                            <div class="form-group">
                                <label>Producto <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b><span class="badge badge-info" data-toggle="tooltip" title="Si tu producto no se encuentra en la lista favor de contactar al área de compras.">?</span> </label>
                                <div class="input-group">
                                    <select id="modelo" name="modelo" class="form-control">
                                        <option>Selecciona Producto </option>
                                        <%
                                            Consultas obj = new Consultas();
                                            ArrayList<Item> items = obj.consultarItems(1);
                                            for (int i = 0; i < items.size(); i++) {
                                        %>
                                        <option value="<%= items.get(i).getId()%>" id="modelo" name="modelo"><%= items.get(i).getNombre()%></option>
                                        <% }%> 
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cantidad">Cantidad <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>

                                <input type="number" class="form-control" id="cantidad" name="cantidad" required>
                            </div>
                            <div for="descripcion" class="form-group">
                                <label>Descripcion / Observaciones <span class="badge badge-info" data-toggle="tooltip" data-placement="bottom" title="Favor de proporcionar cualquier información que ayude a la aprobación y compra del producto">?</span> </label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion">
                            </div>
                            <div for="justificacion" class="form-group">
                                <label>Motivo de la compra <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b></label>
                                <input type="text" class="form-control" id="justificacion" name="justificacion" required>
                            </div>

                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Solicitar" />
                            </div>

                            <% if (rol2 >= 3) {%>
                            <input type="hidden" class="form-control" id="idStatus" name="idStatus" value="8">
                            <input type="hidden" class="form-control" id="idRol" name="idRol" value="<%= rol2%>"> 
                            <% }%>
                            <input type="hidden" class="form-control" id="nuevaRequisicion" name="nuevaRequisicion" value="<%=nuevaRequisicion%>">
                            <input type="hidden" class="form-control" id="idUsuario" name="idUsuario" value="<%=id_usuario%>">
                            <input type="hidden" class="form-control" id="idDepto" name="idDepto" value="<%=idDepto%>">
                            <input type="hidden" class="form-control" id="idDepto" name="sucursal" value="<%=sucursal%>">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--MODAL TECNOLOGIA-->
        <div class="modal fade" id="modalTecnologia" tabindex="-1" role="dialog" aria-labelledby="modalTecnologia" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles del Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="insertarProductoTecnologia.jsp" enctype="multipart/form-data">
                            <div class="form-group">
                                <label>Producto <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b><span class="badge badge-info" data-toggle="tooltip" title="Si tu producto no se encuentra en la lista favor de contactar al área de compras.">?</span> </label>
                                <div class="input-group">
                                    <select id="modelo" name="modelo"  class="form-control">
                                        <option>Selecciona Producto </option>
                                        <%
                                            ArrayList<Item> items2 = obj.consultarItems(2);
                                            for (int i = 0; i < items2.size(); i++) {
                                        %>
                                        <option value="<%= items2.get(i).getId()%>" id="modelo" name="modelo"><%= items2.get(i).getNombre()%></option>
                                        <% }%> 
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cantidad">Cantidad <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>

                                <input type="number" class="form-control" id="cantidad" name="cantidad" required>
                            </div>
                            <div for="descripcion" class="form-group">
                                <label>Descripcion / Observaciones <span class="badge badge-info" data-toggle="tooltip" data-placement="bottom" title="Favor de proporcionar cualquier información que ayude a la aprobación y compra del producto">?</span> </label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion">
                            </div>
                            <div for="justificacion" class="form-group">
                                <label>Motivo de la compra <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b></label>
                                <input type="text" class="form-control" id="justificacion" name="justificacion" required>
                            </div>
                            <div for="archivo" style="display: none" id="archivo" class="form-group">
                                <label>Car&aacute;tula de Contrataci&oacute;n <span class="badge badge-info" data-toggle="tooltip" data-placement="bottom" title="Únicamente para puestos de nueva creación">?</span></label>
                                <input type="file" class="form-control" id="archivo" accept="application/pdf" name="archivo">
                            </div>

                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Solicitar" />
                            </div>

                            <% if (rol2 >= 3) {%>
                            <input type="hidden" class="form-control" id="idStatus" name="idStatus" value="8">
                            <input type="hidden" class="form-control" id="idRol" name="idRol" value="<%= rol2%>"> 
                            <% }%>
                            <input type="hidden" class="form-control" id="nuevaRequisicion" name="nuevaRequisicion" value="<%=nuevaRequisicion%>">
                            <input type="hidden" class="form-control" id="idUsuario" name="idUsuario" value="<%=id_usuario%>">
                            <input type="hidden" class="form-control" id="idDepto" name="idDepto" value="<%=idDepto%>">
                            <input type="hidden" class="form-control" id="idDepto" name="sucursal" value="<%=sucursal%>">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--MODAL CAFETERIA-->
        <div class="modal fade" id="modalCafeteria" tabindex="-1" role="dialog" aria-labelledby="modalCafeteria" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles del Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="insertaProducto.jsp">
                            <div class="form-group">
                                <label>Producto <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b><span class="badge badge-info" data-toggle="tooltip" title="Si tu producto no se encuentra en la lista favor de contactar al área de compras.">?</span> </label>
                                <div class="input-group">
                                    <select id="modelo" name="modelo" class="form-control">
                                        <option>Selecciona Producto </option>
                                        <%
                                            ArrayList<Item> items3 = obj.consultarItems(4);
                                            for (int i = 0; i < items3.size(); i++) {
                                        %>
                                        <option value="<%= items3.get(i).getId()%>" id="modelo" name="modelo"><%= items3.get(i).getNombre()%></option>
                                        <% }%> 
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cantidad">Cantidad <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>

                                <input type="number" class="form-control" id="cantidad" name="cantidad" required>
                            </div>
                            <div for="descripcion" class="form-group">
                                <label>Descripcion / Observaciones <span class="badge badge-info" data-toggle="tooltip" data-placement="bottom" title="Favor de proporcionar cualquier información que ayude a la aprobación y compra del producto">?</span> </label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion">
                            </div>
                            <div for="justificacion" class="form-group">
                                <label>Motivo de la compra <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b></label>
                                <input type="text" class="form-control" id="justificacion" name="justificacion" required>
                            </div>

                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Solicitar" />
                            </div>

                            <% if (rol2 >= 3) {%>
                            <input type="hidden" class="form-control" id="idStatus" name="idStatus" value="8">
                            <input type="hidden" class="form-control" id="idRol" name="idRol" value="<%= rol2%>"> 
                            <% }%>
                            <input type="hidden" class="form-control" id="nuevaRequisicion" name="nuevaRequisicion" value="<%=nuevaRequisicion%>">
                            <input type="hidden" class="form-control" id="idUsuario" name="idUsuario" value="<%=id_usuario%>">
                            <input type="hidden" class="form-control" id="idDepto" name="idDepto" value="<%=idDepto%>">
                            <input type="hidden" class="form-control" id="idDepto" name="sucursal" value="<%=sucursal%>">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--MODAL SERVICIOS-->
        <div class="modal fade" id="modalServicios" tabindex="-1" role="dialog" aria-labelledby="modalServicios" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles del Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="insertaServicio.jsp">
                            <div class="form-group">
                                <label for="Servicio">Servicio <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>
                                <input type="text" class="form-control" id="servicio" name="servicio" required>
                            </div>
                            <div class="form-group">
                                <label for="cantidad">Cantidad <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>

                                <input type="number" class="form-control" id="cantidad" name="cantidad" required>
                            </div>
                            <div for="descripcion" class="form-group">
                                <label>Descripcion / Observaciones <span class="badge badge-info" data-toggle="tooltip" data-placement="bottom" title="Favor de proporcionar cualquier información que ayude a la aprobación y compra del producto">?</span> </label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion">
                            </div>
                            <div for="justificacion" class="form-group">
                                <label>Motivo de la compra <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b></label>
                                <input type="text" class="form-control" id="justificacion" name="justificacion" required>
                            </div>

                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Solicitar" />
                            </div>
                            <% if (rol2 >= 3) {%>
                            <input type="hidden" class="form-control" id="idStatus" name="idStatus" value="8">
                            <input type="hidden" class="form-control" id="idRol" name="idRol" value="<%= rol2%>"> 
                            <% }%>
                            <input type="hidden" class="form-control" id="categoria" name="categoria" value="7">
                            <input type="hidden" class="form-control" id="nuevaRequisicion" name="nuevaRequisicion" value="<%=nuevaRequisicion%>">
                            <input type="hidden" class="form-control" id="idUsuario" name="idUsuario" value="<%=id_usuario%>">
                            <input type="hidden" class="form-control" id="idDepto" name="idDepto" value="<%=idDepto%>">
                            <input type="hidden" class="form-control" id="idDepto" name="sucursal" value="<%=sucursal%>">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--MODAL JARCERIA-->
        <div class="modal fade" id="modalJarceria" tabindex="-1" role="dialog" aria-labelledby="modalJarceria" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles del Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="insertaProducto.jsp">
                            <div class="form-group">
                                <label>Producto <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b><span class="badge badge-info" data-toggle="tooltip" title="Si tu producto no se encuentra en la lista favor de contactar al área de compras.">?</span> </label>
                                <div class="input-group">
                                    <select id="modelo" name="modelo" class="form-control">
                                        <option>Selecciona Producto </option>
                                        <%
                                            ArrayList<Item> items5 = obj.consultarItems(5);
                                            for (int i = 0; i < items5.size(); i++) {
                                        %>
                                        <option value="<%= items5.get(i).getId()%>" id="modelo" name="modelo"><%= items5.get(i).getNombre()%></option>
                                        <% }%> 
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cantidad">Cantidad <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>

                                <input type="number" class="form-control" id="cantidad" name="cantidad" required>
                            </div>
                            <div for="descripcion" class="form-group">
                                <label>Descripcion / Observaciones <span class="badge badge-info" data-toggle="tooltip" data-placement="bottom" title="Favor de proporcionar cualquier información que ayude a la aprobación y compra del producto">?</span> </label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion">
                            </div>
                            <div for="justificacion" class="form-group">
                                <label>Motivo de la compra <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b></label>
                                <input type="text" class="form-control" id="justificacion" name="justificacion" required>
                            </div>

                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Solicitar" />
                            </div>
                            <% if (rol2 >= 3) {%>
                            <input type="hidden" class="form-control" id="idStatus" name="idStatus" value="8">
                            <input type="hidden" class="form-control" id="idRol" name="idRol" value="<%= rol2%>"> 
                            <% }%>
                            <input type="hidden" class="form-control" id="nuevaRequisicion" name="nuevaRequisicion" value="<%=nuevaRequisicion%>">
                            <input type="hidden" class="form-control" id="idUsuario" name="idUsuario" value="<%=id_usuario%>">
                            <input type="hidden" class="form-control" id="idDepto" name="idDepto" value="<%=idDepto%>">
                            <input type="hidden" class="form-control" id="idDepto" name="sucursal" value="<%=sucursal%>">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--MODAL FERRETERIA-->
        <div class="modal fade" id="modalFerreteria" tabindex="-1" role="dialog" aria-labelledby="modalFerreteria" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles del Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="insertaProducto.jsp">
                            <div class="form-group">
                                <label>Producto <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b><span class="badge badge-info" data-toggle="tooltip" title="Si tu producto no se encuentra en la lista favor de contactar al área de compras.">?</span> </label>
                                <div class="input-group">
                                    <select id="modelo" name="modelo" class="form-control">
                                        <option>Selecciona Producto </option>
                                        <%
                                            ArrayList<Item> items6 = obj.consultarItems(6);
                                            for (int i = 0; i < items6.size(); i++) {
                                        %>
                                        <option value="<%= items6.get(i).getId()%>" id="modelo" name="modelo"><%= items6.get(i).getNombre()%></option>
                                        <% }%> 
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cantidad">Cantidad <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>

                                <input type="number" class="form-control" id="cantidad" name="cantidad" required>
                            </div>
                            <div for="descripcion" class="form-group">
                                <label>Descripcion / Observaciones <span class="badge badge-info" data-toggle="tooltip" data-placement="bottom" title="Favor de proporcionar cualquier información que ayude a la aprobación y compra del producto">?</span> </label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion">
                            </div>
                            <div for="justificacion" class="form-group">
                                <label>Motivo de la compra <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT> </b></label>
                                <input type="text" class="form-control" id="justificacion" name="justificacion" required>
                            </div>

                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Solicitar" />
                            </div>
                            <% if (rol2 >= 3) {%>
                            <input type="hidden" class="form-control" id="idStatus" name="idStatus" value="8">
                            <input type="hidden" class="form-control" id="idRol" name="idRol" value="<%= rol2%>"> 
                            <% }%>
                            <input type="hidden" class="form-control" id="nuevaRequisicion" name="nuevaRequisicion" value="<%=nuevaRequisicion%>">
                            <input type="hidden" class="form-control" id="idUsuario" name="idUsuario" value="<%=id_usuario%>">
                            <input type="hidden" class="form-control" id="idDepto" name="idDepto" value="<%=idDepto%>">
                            <input type="hidden" class="form-control" id="idDepto" name="sucursal" value="<%=sucursal%>">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--MODAL NO DISPONIBLE-->
        <div class="modal fade" id="modalError" tabindex="-1" role="dialog" aria-labelledby="modalError" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Lo sentimos...</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por el momento este modulo no se encuentra disponible.
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>

            let div1 = document.getElementById('archivo');
            $('select#modelo').on('change', function () {
                let valor = $(this).val();
                console.log(valor);
                if (valor == "301") {
                    div1.style.display = 'block';
                }
            });
        </script>
    </body>
</html>
<% }%>
