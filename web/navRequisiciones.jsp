<%-- 
    Document   : usuarioSeguimiento
    Created on : Mar 5, 2018, 7:55:17 AM
    Author     : user
--%>
<%
    int id_categoria = 8;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Autorizar</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="4" />  
            <jsp:param name="depto" value="5" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Cotizaciones</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">No. Cotizacion</th>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        //Consulta por categoria del producto
                        int id_requi;
                        int cantidad;
                        String producto;
                        String marca;
                          
                        id_requi = 23;
                        cantidad = 3;
                        producto = "Lapiz";
                        marca = "Berol";
                    %>
                    <tr>
                        <td><%=id_requi%></td>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidad%></td> 
                        <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalDetalle">Detalles</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <div class="modal fade" id="modalDetalle" tabindex="-1" role="dialog" aria-labelledby="modalDetalle" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalle de Productos</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">No. Requisicion</th>
                                    <th scope="col">Solicitante</th>
                                    <th scope="col">Producto</th>
                                    <th scope="col">Marca</th>
                                    <th scope="col">Cantidad</th>
                                    <th scope="col">Fecha</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>23</td>
                                    <td>Diego</td>
                                    <td>Cuaderno</td>
                                    <td>Scribe</td>
                                    <td>1</td>
                                    <td>2018-02-12</td>
                                </tr>
                                <tr>
                                    <td>43</td>
                                    <td>Luis</td>
                                    <td>Cuaderno</td>
                                    <td>Scribe</td>
                                    <td>1</td>
                                    <td>2018-02-23</td>
                                </tr>
                                <tr>
                                    <td>61</td>
                                    <td>Alfred</td>
                                    <td>Cuaderno</td>
                                    <td>Scribe</td>
                                    <td>1</td>
                                    <td>2018-03-13</td>
                                </tr>
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-success">Cotizar Productos</button>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
