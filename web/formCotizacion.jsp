<%-- 
    Document   : formCotizacion
    Created on : 14-mar-2018, 12:41:58
    Author     : JefeDesarrollo
--%>

<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Precios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    String usuarioValidado = (String) sesion.getAttribute("usuarioIngresado");
    if (usuarioValidado == null) {
        response.sendRedirect("index.jsp");
    } else {
        String idUsuario = (String) sesion.getAttribute("idUsuario");

        int idProducto = 0;
        int idReqCoti = 0;
        int cantidad = 0;
        Consultas obConsultas = new Consultas();
        Precios obPrecio = new Precios();
        ArrayList<Precios> PreciosCotizacion = new ArrayList<Precios>();
        

        try {
            idProducto = Integer.parseInt(request.getParameter("idProducto"));
        } catch (Exception e) {
        }

        try {
            idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
        } catch (Exception e) {
        }

        try {
            cantidad = Integer.parseInt(request.getParameter("cantidad"));
        } catch (Exception e) {
        }
        obPrecio = obConsultas.consultaItemsCotizacion(idProducto, Integer.parseInt(idUsuario));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Autorizar</title>
        <script>
            function alerta(){
                confirm("¿Seguro que desea enviar esta cotizacion?");
            }
            window.addEventListener("keypress", function(event){
            if (event.keyCode == 13){
                event.preventDefault();
            }
        }, false);
    
        </script>
        <script type = 'text/javascript'>
            function nombre_ar(id_archivo) {
        var archivo = document.getElementById(id_archivo).value;

        if (navigator.userAgent.indexOf('Linux') != -1) {
            var SO = "Linux";
        } else if ((navigator.userAgent.indexOf('Win') != -1) && (navigator.userAgent.indexOf('95') != -1)) {
            var SO = "Win";
        } else if ((navigator.userAgent.indexOf('Win') != -1) && (navigator.userAgent.indexOf('NT') != -1)) {
            var SO = "Win";
        } else if (navigator.userAgent.indexOf('Win') != -1) {
            var SO = "Win";
        } else if (navigator.userAgent.indexOf('Mac') != -1) {
            var SO = "Mac";
        } else {
            var SO = "no definido";
        }

        if (SO = "Win") {
            var arr_ruta = archivo.split("\\");
        } else {
            var arr_ruta = archivo.split("/");
        }


        var nombre_archivo = (arr_ruta[arr_ruta.length - 1]);
        var ext_validas = /\.(pdf|gif|jpg|png)$/i.test(nombre_archivo);
        if (!ext_validas) {
            borrar();
            alert("Archivo con extensión no válida\nSu archivo: " + nombre_archivo);
            return false;
        }
        }
        function borrar() {
            document.getElementById('valor').innerHTML = "";
            var vacio = document.getElementById('archivo').value = "";
        }
        
        </script>
    </head>
    <body>

        <jsp:include page="frag/mainNavbarProveedor.jsp"/>

        <div class="container">
            <div class="card w-50 mx-auto my-5">
                <h5 class="card-header">Cotización</h5>
                <div class="card-body">
                    <form method="post" action="guardarArchivos.jsp" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="cantidad">Cantidad</label>
                            <input type="number" class="form-control" id="cantidad" name="cantidad" readonly="readonly" value="<%= cantidad %>">
                        </div>
                        <div for="precio" class="form-group">
                            <label>Precio Unitario Sin IVA <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>
                            <input type="double" class="form-control" id="precio" required="true" min="1" name="precio" value="">
                        </div>
                        <div for="credito" class="form-group">
                            <label>Dias de Crédito <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>
                            <input type="number" class="form-control" id="credito" required="true" name="credito" value="">
                        </div>
                        <div for="entrega" class="form-group">
                            <label>Tiempo de Entrega (Días) <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>
                            <input type="number" class="form-control" id="entrega" required="true" name="entrega" value="">
                        </div>
                        <div for="garantia" class="form-group">
                            <label>Garantía (Días) <b><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>
                            <input type="number" class="form-control" id="garantia" required="true" name="garantia" value="">
                        </div>
                        <div for="descuento" class="form-group">
                            <label>% Descuento</label>
                            <input type="number" class="form-control" id="descuento"  name="descuento" value="<%= obPrecio.getDescuento() %>">
                        </div>
                        <div for="anticipo" class="form-group">
                            <label> % Anticipo</label>
                            <input type="number" class="form-control" id="anticipo"  name="anticipo" value="<%= obPrecio.getAnticipo() %>">
                        </div>
                        <div for="archivo" class="form-group">
                            <label> Subir Archivo <b><span class="badge badge-info" data-toggle="tooltip" data-placement="bottom"  title="Deberá adjuntar un PDF">?</span><FONT COLOR="red" title="Éste campo es obligatorio">*</FONT></b></label>
                            <input type="file" class="form-control" id="archivo" accept="application/pdf" required="true" name="archivo">
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" class="hidden" name="idUsuario" value="<%=idUsuario%>" >
                            <input type="hidden" class="hidden" name="idProducto" value="<%=idProducto%>" >
                            <input type="hidden" class="hidden" name="idReqCoti" value="<%=idReqCoti%>" >
                            <input type="submit" class="btn btn-primary" value="Aceptar" onclick="verificar()"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="frag/footer.jsp" />
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script type="text/javascript">
            function verificar() {
            swal({
                title: "¿Estás seguro?",
                text: "Al presionar aceptar estás de acuerdo en que la información proporcionada es verídica y será respetada en la compra!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willSend) => {
                if (willSend) {
                    swal("Listo! Tu cotización ha sido enviada!", {
                icon: "success",
            });
            });
            }}
        </script>
    </body>
</html>
<% }%>
