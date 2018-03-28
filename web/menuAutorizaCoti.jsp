<%-- 
    Muestra las requisiciones disponibles para la autorizacion de: 
    Gerente Administrativo - Status = 7
    Director Administrativo - Status = 8
    Director General - Status = 9
--%>

<%@page import="model.CotizacionRequisicion"%>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%
    int status = 0;
    String direccion = "";
    HttpSession sesion = request.getSession();
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String idDepto = (String) sesion.getAttribute("departamento");
        String rol = (String) sesion.getAttribute("rol");

        if (rol.equals("3")) {
            status = 7;
            direccion = "comparativoGerenteAdmin.jsp";
        } else if (rol.equals("4")) {
            status = 8;
            direccion = "comparativoDirectorAdmin.jsp";
        }

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
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Cotizaciones Disponibles</h3>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Producto</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidadRequi;
                        int idProducto;
                        int idReqCoti;
                        int idCoti = 0;
                        String producto;
                        String marca;

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        ArrayList<CotizacionRequisicion> arrayRequis2 = new ArrayList<CotizacionRequisicion>();
                        Consultas obj2 = new Consultas();

                        arrayRequis = obj.consultarCompras2(0, status);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idProducto = arrayRequis.get(i).getIdProducto();
                                cantidadRequi = arrayRequis.get(i).getCantidad();
                                producto = arrayRequis.get(i).getProducto();
                                marca = arrayRequis.get(i).getMarca();
                                idReqCoti = arrayRequis.get(i).getIdReqCoti();
                                arrayRequis2 = obj2.consultarComprasDetalleCoti(idReqCoti);
                                if (arrayRequis2.size() > 0) {
                                    idCoti = arrayRequis2.get(0).getIdC();
                                }
                    %>
                    <tr>
                        <td><%=producto%></td>
                        <td><%=marca%></td>
                        <td><%=cantidadRequi%></td> 
                        <td>
                            <form action="formatos/<%=direccion%>" method="post">
                                <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                                <button type="submit" class="btn btn-primary btn-sm">Ver Cuadro Comparativo</button>
                            </form>
                        </td>
                    </tr>
                    <% }
                        }%>
                </tbody>
            </table>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>