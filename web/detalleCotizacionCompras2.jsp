<%-- 
    Muestra las requisiciones disponibles por cada id de producto y categoria
    status 4
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="model.CotizacionRequisicion"%>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    HttpSession sesion = request.getSession();
    Consultas obj2 = new Consultas();
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    DecimalFormat formateador = new DecimalFormat("###,###,###.##");
    
    
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String idDepto = (String) sesion.getAttribute("departamento");
        String rol = (String) sesion.getAttribute("rol");

        int idReqCoti = 0;
        int idUsu = 0;
        try {
            idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
        } catch (Exception e) {
        }
        try {
            idUsu = Integer.parseInt(request.getParameter("idUsu"));
        } catch (Exception e) {
        }
        
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Autorizar</title>
        <script>
            var maxi = 3;
            var min = 1;
            var contador = 0;
            function validar(check) {
                if (check.checked === true) {
                    contador++;
                     if (contador > maxi) {
                        alert('No se pueden elegir más de ' + maxi + ' casillas a la vez.');
                        check.checked = false;
                        contador--;
                    }
                }else {
                    contador--;
                }
            }
            function validars() {
                if (contador < min) {
                        alert('Debes elegir al menos ' + min + ' casillas.');
                }
            }
        </script>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="jumbotron">
                <form action="formatos/comparativo.jsp" method="post" name="formulario" id="formulario">
                    <h5> Selecciona hasta 3 cotizaciones para generar cuadro comparativo </h5>
                    <br>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th scope="col">Proveedor</th>
                                <th scope="col">Producto</th>
                                <th scope="col">Cantidad</th>
                                <th scope="col">Precio Unitario</th>
                                <th scope="col">IVA</th>
                                <th scope="col">Precio Final</th>
                                <th scope="col">Dias de Credito</th>
                                <th scope="col">Garantia</th>
                                <th scope="col">Tiempo de Entrega</th>
                                <th scope="col">Anticipo</th>
                                <th scope="col">Archivo</th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String proveedor;
                                String producto;
                                int cantidad;
                                double precio;
                                double iva;
                                int credito;
                                int entrega;
                                int anticipo;
                                int garantia;
                                int idCoti;

                                ArrayList<CotizacionRequisicion> arrayRequis = new ArrayList<CotizacionRequisicion>();
                                Consultas obj = new Consultas();
                                arrayRequis = obj.consultarComprasDetalleCoti(idReqCoti);
                                

                                if (arrayRequis.size() > 0) {
                                    for (int i = 0; i < arrayRequis.size(); i++) {
                                        idCoti = arrayRequis.get(i).getIdC();
                                        proveedor = arrayRequis.get(i).getProveedor();
                                        producto = arrayRequis.get(i).getProducto();
                                        cantidad = arrayRequis.get(i).getCantidad();
                                        precio = arrayRequis.get(i).getPrecio();
                                        iva = arrayRequis.get(i).getIva();
                                        credito = arrayRequis.get(i).getCredito();
                                        entrega = arrayRequis.get(i).getEntrega();
                                        anticipo = arrayRequis.get(i).getAnticipo();
                                        garantia = arrayRequis.get(i).getGarantia();
                                        String ruta = obj2.consultaArchivoComp(idReqCoti, idCoti);
                            %>
                            <tr>
                                <td><%=proveedor%></td>
                                <td><%=producto%></td>
                                <td><%=cantidad%></td>
                                <td><%=precio%></td>
                                <td><%=formateador.format(iva)%></td>
                                <td><%=formateador.format(cantidad * (iva + precio))%></td>
                                <td><%=credito%> Dias</td>
                                <td><%=garantia%> Dias</td>
                                <td><%=entrega%> Dias</td>
                                <td><%=anticipo%> %</td>
                                <td><button tarjet onClick="document.formulario.action='visor';" value="<%=ruta%>" name="search" class="btn btn-dark btn-sm">Ver PDF</button></td>
                                <td>
                                    <div class="form-check">
                                        <label>
                                            <input class="form-check-input" type="checkbox" name="checkbox<%=i%>" value="<%=idCoti%>" onclick='validar(formulario.checkbox<%=i%>)'>Seleccionar
                                        </label>
                                    </div>
                                </td>
                            </tr>
                            <% }
                                }%>
                        </tbody>
                    </table>
                        <button type="button" class="btn btn-primary btn-sm" onclick="validars()" data-toggle="modal" data-target="#observaciones">Continuar</button>
                    <div class="modal fade" id="observaciones" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Observaciones</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="input-group">
                                        <textarea class="form-control" aria-label="With textarea" name="observaciones" id="observaciones"></textarea>
                                    </div>
                                    <br/>
                                    <input type="hidden" class="hidden" name="idUsu" value="<%=idUsu%>" >
                                    <input type="hidden" class="hidden" name="tama" value="<%=arrayRequis.size()%>" >
                                    <button type="submit" class="btn btn-primary btn-sm">Generar Cuadro Comparativo</button>
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
