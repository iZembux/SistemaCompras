<%-- 
    Document   : usuarioSeguimiento
    Created on : Mar 5, 2018, 7:55:17 AM
    Author     : user
--%>
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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Ordenes de Compra</title>

    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>


        <div class="container my-5">
            <div class="page-header">
                <h3>Ordenes de compra</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Orden</th>
                        <th scope="col">Sucursal</th>
                        <th scope="col">Fecha de Autorizacion</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidad;
                        int idP;
                        String sucursal;
                        String fecha;

                        ArrayList<OrdenFormato> arrayRequis = new ArrayList<OrdenFormato>();
                        ArrayList<RequisicionProducto> arrayRequis2 = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarOrdenesGerenteCompras();

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idP = arrayRequis.get(i).getIdP();
                                cantidad = arrayRequis.get(i).getCantidad();
                                sucursal = arrayRequis.get(i).getSucursal();
                                fecha = arrayRequis.get(i).getFecha();
                                
                    %>
                    <tr>
                        <td><%=idP%></td>
                        <td><%=sucursal%></td>
                        <td><%=fecha%></td> 
                        <td>
                            <div class="row">
                                <form action="formatos/ordenCompraAcumFinal.jsp" method="post" target="_blank">
                                    <input type="hidden" name="idOrden" id="idOrden" value="<%=idP%>" >
                                    <button type="submit" class="btn btn-info btn-sm" >Ver Orden</button>
                                </form>
                                
                                <form action="actualizaOrdenComprasGerente.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idOrden" value="<%=idP%>" > 
                                    <input type="hidden" class="hidden" name="nuevoStatus" value="10" >
                                    <button type="submit" class="btn btn-success btn-sm" >Aceptar</button>
                                </form>
                                    <form action="actualizaOrdenComprasGerente.jsp" method="post">
                                    <input type="hidden" class="hidden" name="idOrden" value="<%=idP%>" > 
                                    <input type="hidden" class="hidden" name="nuevoStatus" value="14" >
                                    <button type="submit" class="btn btn-danger btn-sm" >Rechazar</button>
                                </form>
                                <% }
                                    }%>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <jsp:include page="frag/footer.jsp" />
        
        <!-- ===============================================================    FUNCIONES JAVASCRIPT =============================================================== -->
        <script type="text/javascript">
            function abre(){
                $('#myModal').modal({show:true});
            }
            function imp(){
            swal("Picaste el botón 7w7");
            }
        </script>
        <script type="text/javascript">
            function mandarDato(){
                    $("#Orden").val($("#btnID").val());
                    var b = $("#Orden").val();
            }
        </script>
        <script type='text/javascript' src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>
