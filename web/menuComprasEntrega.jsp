<%-- 
    Muestra las cotizaciones que se han hecho de los proveedores disponibles por categoria de producto
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
        String usuario = (String) sesion.getAttribute("idUsuario");
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
        }
        
        int id_categoria = 0;
        try {
            id_categoria = Integer.parseInt(request.getParameter("categoria"));
        } catch (Exception e) {

        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Entrega</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Entrega de Productos</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Orden</th>
                        <th scope="col">Requi</th>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Solicitante</th>
                        <th scope="col">Sucursal</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idReqProd;
                        int idUsu;
                        int idOrden;
                        String producto;
                        String marca;
                        String solicitante;
                        String sucursal;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarComprasEntregado(12, id_categoria, suc);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idOrden = arrayRequis.get(i).getIdOrden();
                                idReqProd = arrayRequis.get(i).getIdReqProd();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                sucursal = arrayRequis.get(i).getSucursal();
                                idUsu = arrayRequis.get(i).getIdSolicita();
                    %>
                    <tr>
                        <td><%=idOrden%></td>
                        <td><%=idReqProd%></td>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=solicitante.toUpperCase() %></td>
                        <td><%=sucursal%></td>
                        <td><%=cantidadRequi%></td> 
                        <td>
                            <form action="actualizaRecibido.jsp" method="post" id="formActualiza" onsubmit="return confirm('Desea entregar el producto? \n Se requiere confirmación del usuario')">
                                <input type="hidden" class="hidden" name="idReqProd" value="<%=idReqProd%>" >
                                <input type="hidden" class="hidden" name="producto" value="<%=producto%>" >
                                <input type="hidden" class="hidden" name="cantidad" value="<%=cantidadRequi%>" >
                                <input type="hidden" class="hidden" name="idUsu" value="<%=idUsu%>" >
                                <input type="hidden" class="hidden" name="categoria" value="<%=id_categoria %>" >
                                <input type="hidden" class="hidden" name="nuevoStatus" value="16" >
                                <input type="hidden" class="hidden" name="entrega" value="1" >
                                <button type="submit" class="btn btn-success btn-sm">Entregar Producto</button>
                            </form>
                        </td>
                    </tr>
                    <% }
                        }%>
                </tbody>
            </table>
        </div>

        <jsp:include page="frag/footer.jsp" />
        <script src="js/swal.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>
