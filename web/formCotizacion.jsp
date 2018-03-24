<%-- 
    Document   : formCotizacion
    Created on : 14-mar-2018, 12:41:58
    Author     : JefeDesarrollo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String idDepto = (String) sesion.getAttribute("departamento"); 
        String rol = (String) sesion.getAttribute("rol");
        String idUsuario = (String) sesion.getAttribute("idUsuario");

        int idProducto = 0;
        int idReqCoti = 0;

        try {
            idProducto = Integer.parseInt(request.getParameter("idProducto"));
        } catch (Exception e) {
        }

        try {
            idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
        } catch (Exception e) {
        }

        try {
            idUsuario = request.getParameter("idUsuario");
        } catch (Exception e) {
        }
%>
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

        <div class="container">
            <div class="card w-50 mx-auto my-5">
                <h5 class="card-header">Cotización</h5>
                <div class="card-body">
                    <form method="post" action="insertaCotizacion.jsp">
                        <div class="form-group">
                            <label for="cantidad">Cantidad</label>
                            <input type="number" class="form-control" id="cantidad" name="cantidad">
                        </div>
                        <div for="precio" class="form-group">
                            <label>Precio Unitario</label>
                            <input type="text" class="form-control" id="precio" name="precio">
                        </div>
                        <div for="iva" class="form-group">
                            <label>Precio con IVA</label>
                            <input type="text" class="form-control" id="iva" name="iva">
                        </div>
                        <div for="credito" class="form-group">
                            <label>Dias de Crédito</label>
                            <input type="text" class="form-control" id="credito" name="credito">
                        </div>
                        <div for="entrega" class="form-group">
                            <label>Tiempo de Entrega</label>
                            <input type="text" class="form-control" id="entrega" name="entrega">
                        </div>
                        <div for="descuento" class="form-group">
                            <label>Descuento</label>
                            <input type="text" class="form-control" id="descuento" name="descuento">
                        </div>
                        <div for="anticipo" class="form-group">
                            <label>Anticipo</label>
                            <input type="text" class="form-control" id="anticipo" name="anticipo">
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" class="hidden" name="idUsuario" value="<%=idUsuario%>" >
                            <input type="hidden" class="hidden" name="idProducto" value="<%=idProducto%>" >
                            <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                            <input type="submit" class="btn btn-primary" value="Aceptar" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="frag/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
<% }%>