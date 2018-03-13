<%-- 
    Document   : gerente
    Created on : Mar 1, 2018, 9:19:46 AM
    Author     : user
--%>

<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Item"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    int idUsuario = 1;
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

        <script>
            $(document).ready(function () {
                $('#modelo').change(function (event) {
                    var sports = $("select#modelo").val();
                    $.get('JsonServlet', {
                        sportsName: sports
                    }, function (jsonResponse) {

                        var select = $('#marca');
                        select.find('option').remove();
                        $.each(jsonResponse, function (index, value) {
                            $('<option>').val(value).text(value).appendTo(select);
                        });
                    });
                });
            });
        </script>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="4" />  
            <jsp:param name="depto" value="3" />
        </jsp:include>

        <div class="container">

            <!-- Jumbotron Header -->
            <header class="jumbotron my-4">
                <div class="row">
                    <div class="col-lg-7">
                        <h3 class="display-5">Bienvenido al sistema de compras!</h3>
                        <p class="lead">Selecciona la caegoria de los productos que deseas solicitar</p>
                    </div>
                    <div class="col-lg-3">
                        <img class="img-fluid" style="opacity: 0.5;" src="img/compras.jpg" alt="">
                    </div>
                </div>
            </header>

            <!-- Page Features -->
            <div class="row text-center">

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/papeleria.jpg" alt="">
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
                        <img class="card-img-top" src="img/tecnologia.jpg" alt="">
                        <div class="card-body">
                            <h4 class="card-title">Tecnología</h4>
                            <p class="card-text">PC, Mouse, Teclados, Memorias, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalError">Solicitar</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/mercadotecnia.jpg" alt="">
                        <div class="card-body">
                            <h4 class="card-title">Mercadotecnia</h4>
                            <p class="card-text">Lonas, Impresoines, Tarjetas, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalError">Solicitar</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="img/cafeteria.jpg" alt="">
                        <div class="card-body">
                            <h4 class="card-title">Cafetería</h4>
                            <p class="card-text">Cafe, Galletas, Té, Servilltas, etc.</p>
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalError">Solicitar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalPapeleria" tabindex="-1" role="dialog" aria-labelledby="modalPapeleria" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles del Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="insertarProducto.jsp">
                            <div class="form-group">
                                <label class="col-sm-1 control-label"></label>
                                <div class="col-sm-10 input-group">
                                    <select id="modelo" name="modelo">
                                        <option>Selecciona Producto</option>
                                        <%
                                            Consultas obj = new Consultas();
                                            ArrayList<Item> items = obj.consultarItems();
                                            for (int i = 0; i < items.size(); i++) {
                                        %>
                                        <option value="<%= items.get(i).getId()%>" id="modelo" name="modelo"><%= items.get(i).getNombre()%></option>
                                        <% }%> 
                                    </select>
                                </div>
                            </div>
                            <!--
                            <div class="form-group">
                                <label class="col-sm-1 control-label"></label>
                                <div class="col-sm-10 input-group">
                                    <select id="marca" name="marca">
                                        <option id="marca" name="marca">Selecciona Marca</option>
                                    </select>
                                </div>
                            </div>
                            -->
                            <div class="form-group">
                                <label for="cantidad">Cantidad</label>
                                <input type="number" class="form-control" id="cantidad" name="cantidad">
                            </div>
                            <div for="descripcion" class="form-group">
                                <label>Descripcion</label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion">
                            </div>
                            <div for="justificacion" class="form-group">
                                <label>Justificacion</label>
                                <input type="text" class="form-control" id="justificacion" name="justificacion">
                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Solicitar" />
                            </div>
                            <input type="hidden" class="form-control" id="nuevaRequisicion" name="nuevaRequisicion" value="<%=nuevaRequisicion%>">
                            <input type="hidden" class="form-control" id="idUsuario" name="idUsuario" value="<%=idUsuario%>">
                        </form>
                    </div>
                </div>
            </div>
        </div>

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
                        Por el momento éste módulo no se encuentra disponible
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
