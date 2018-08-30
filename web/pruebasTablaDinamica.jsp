<%-- 
    Muestra el historial de requisiciones autorizadas por el gerente
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
        String sucursal = (String) sesion.getAttribute("sucursal");

        String idUsu = (String) sesion.getAttribute("idUsuario");
        String idDepto2 = idDepto;
        if (idUsu.equals("34")) {
            idDepto2 = "8,10,13";
        }
        if (idUsu.equals("210")) {
            idDepto2 = "1,8,10,13";
        }
        if (idUsu.equals("114")) {
            idDepto2 = "21,26,1,13,18";
        }
        if (idUsu.equals("65") || idUsu.equals("133")) {
            idDepto2 = "1,6,8,9,13,24,25,26";
        }

        if (idUsu.equals("14")) {
            idDepto2 = "1,24,6";
        }
        if (idUsu.equals("4")) {
            idDepto2 = "7,28";
        }
        if (idUsu.equals("88")) {
            idDepto2 = "8,10,13";
            sucursal = "10,18";
        }
        if (idUsu.equals("181")) {
            idDepto2 = "1,14";
        }
        if (idUsu.equals("153")) {
            idDepto2 = "3,21";
            sucursal = "1,2,3,4,6,7";
        }
        if (idUsu.equals("173") || idUsu.equals("167")) {
            idDepto2 = "1,10,12,26";
        }
        if (idUsu.equals("57")) {
            idDepto2 = "18,19,21";
            sucursal = "8";
        }

        if (idUsu.equals("60") || idUsu.equals("4")) {
            sucursal = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18";
        }
        if (idUsu.equals("100")) {
            sucursal = "1,6";
        }
        if (idUsu.equals("126")) {
            sucursal = "9,14";
        }
        if (idUsu.equals("127")) {
            sucursal = "1,9,10,11";
        }
        if (idUsu.equals("138")) {
            sucursal = "1,9,10,11";
        }
        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
        Consultas obj = new Consultas();
        arrayRequis = obj.consultarHistorialGerente(idDepto2, sucursal);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Historial</title>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
            <jsp:param name="idUsu" value="<%=idUsu%>" />
        </jsp:include>


        <div class="container my-5">
            <div class="page-header">
                <h3>Historial de Autorizaciones</h3>
            </div>
                <!-- Table Markup -->
                <table id="showcase-example-1" class="table" data-paging="true" data-filtering="true" data-sorting="true" data-editing="true" data-state="true"></table>

                <!-- Editing Modal Markup -->
                <div class="modal fade" id="editor-modal" tabindex="-1" role="dialog" aria-labelledby="editor-title">
                    <style scoped>
                        /* provides a red astrix to denote required fields - this should be included in common stylesheet */
                        .form-group.required .control-label:after {
                            content:"*";
                            color:red;
                            margin-left: 4px;
                        }
                    </style>
                    <div class="modal-dialog" role="document">
                        <form class="modal-content form-horizontal" id="editor">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="editor-title">Add Row</h4>
                            </div>
                            <div class="modal-body">
                                <input type="number" id="id" name="id" class="hidden"/>
                                <div class="form-group required">
                                    <label for="firstName" class="col-sm-3 control-label">First Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required>
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label for="lastName" class="col-sm-3 control-label">Last Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="jobTitle" class="col-sm-3 control-label">Job Title</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="jobTitle" name="jobTitle" placeholder="Job Title">
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label for="startedOn" class="col-sm-3 control-label">Started On</label>
                                    <div class="col-sm-9">
                                        <input type="date" class="form-control" id="startedOn" name="startedOn" placeholder="Started On" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="dob" class="col-sm-3 control-label">Date of Birth</label>
                                    <div class="col-sm-9">
                                        <input type="date" class="form-control" id="dob" name="dob" placeholder="Date of Birth">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="status" class="col-sm-3 control-label">Status</label>
                                    <div class="col-sm-9">
                                        <select class="form-control" id="status" name="status">
                                            <option value="Active">Active</option>
                                            <option value="Disabled">Disabled</option>
                                            <option value="Suspended">Suspended</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Save changes</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
            jQuery(function($){
                var $modal = $('#editor-modal'),
                        $editor = $('#editor'),
                        $editorTitle = $('#editor-title'),
                        ft = FooTable.init('#showcase-example-1', {
                                columns: $.get('658741'),
                                rows: $.get('69857')
                        })
            });
        </script>
    </body>
</html>
<% }%>