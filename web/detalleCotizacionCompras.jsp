<%-- 
    Muestra las requisiciones disponibles por cada id de producto y categoria
    status 4
--%>

<%@page import="model.CotizacionRequisicion"%>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%
    int idCategoria = 0;
    int idProducto = 0;
    int idReqCoti = 0;
    try {
        idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
    } catch (Exception e) {
    }
    try {
        idProducto = Integer.parseInt(request.getParameter("idProducto"));
    } catch (Exception e) {
    }
    try {
        idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
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
            <jsp:param name="rol" value="4" />  
            <jsp:param name="depto" value="5" />
        </jsp:include>

        <div class="container">
            <div class="jumbotron">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th scope="col">Proveedor</th>
                            <th scope="col">Producto</th>
                            <th scope="col">Cantidad</th>
                            <th scope="col">Precio Unitario</th>
                            <th scope="col">Precio Con IVA</th>
                            <th scope="col">Descuento</th>
                            <th scope="col">Precio Final</th>
                            <th scope="col">Dias de Credito</th>
                            <th scope="col">Tiempo de Entrega</th>
                            <th scope="col">Anticipo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String proveedor;
                            String producto;
                            int cantidad;
                            int precio;
                            int iva;
                            int descuento;
                            int credito;
                            int entrega;
                            int anticipo;

                            ArrayList<CotizacionRequisicion> arrayRequis = new ArrayList<CotizacionRequisicion>();
                            Consultas obj = new Consultas();
                            arrayRequis = obj.consultarComprasDetalleCoti(idReqCoti);

                            if (arrayRequis.size() > 0) {
                                for (int i = 0; i < arrayRequis.size(); i++) {
                                    proveedor = arrayRequis.get(i).getProveedor();
                                    producto = arrayRequis.get(i).getProducto();
                                    cantidad = arrayRequis.get(i).getCantidad();
                                    precio = arrayRequis.get(i).getPrecio();
                                    iva = arrayRequis.get(i).getIva();
                                    descuento = arrayRequis.get(i).getDescuento();
                                    credito = arrayRequis.get(i).getCredito();
                                    entrega = arrayRequis.get(i).getEntrega();
                                    anticipo = arrayRequis.get(i).getAnticipo();
                        %>
                        <tr>
                            <td><%=proveedor%></td>
                            <td><%=producto%></td>
                            <td><%=cantidad%></td>
                            <td><%=precio%></td>
                            <td><%=iva%></td>
                            <td><%=descuento%> %</td>
                            <td><%=(iva * cantidad) - descuento%></td>
                            <td><%=credito%> Dias</td>
                            <td><%=entrega%> Dias</td>
                            <td><%=anticipo%> %</td>
                        </tr>
                        <% }
                            }%>
                    </tbody>
                </table>
                <form action="formatos/comparativo.jsp" method="post">
                    <button type="submit" class="btn btn-primary btn-sm">Generar Cuadro Comparativo</button>
                </form>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>

