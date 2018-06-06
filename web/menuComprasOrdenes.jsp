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
        String suc = null;
        
         if (usuario.equals("83")) {                         //Valeria
            suc = "1,2,3,4,6,7,8";
        } else if (usuario.equals("4")) {                    //Veronica
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
        } else if (usuario.equals("25")) {                   //Angelica
            suc = "10,11,15,16,18";
        } else if (usuario.equals("0")) {                    //Roberto *Pendiente
            suc = "9,13,14,17";
        }
         
        int id_categoria = 1;
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
        <title>Ordenes de compra</title>
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
                        <th scope="col">Proveedor</th>
                        <th scope="col">Productos</th>
                        <th scope="col">Sucursal</th>
                        <th scope="col">Departamento</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int cantidad;
                        int idSuc;
                        int idP;
                        int idDep; 
                        String razonsocial;
                        String sucursal;
                        String depto;

                        ArrayList<OrdenFormato> arrayRequis = new ArrayList<OrdenFormato>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarOrdenesProvCompras(suc, id_categoria);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                idP = arrayRequis.get(i).getUsuCompras();
                                razonsocial = arrayRequis.get(i).getNombreP();
                                cantidad = arrayRequis.get(i).getCantidad();
                                sucursal = arrayRequis.get(i).getSucursal();
                                idSuc = arrayRequis.get(i).getIdP();
                                depto = arrayRequis.get(i).getDescripcion();
                                idDep = arrayRequis.get(i).getIdDepto();
                    %>
                    <tr>
                        <td><%=razonsocial%></td>
                        <td><%=cantidad%></td>
                        <td><%=sucursal%></td>
                        <td><%=depto%></td>
                        <td>
                            <div class="row">
                                <form action="formatos/ordenCompraAcum.jsp" method="post">
                                    <input type="hidden" name="categoria" value="<%=id_categoria%>" >
                                    <input type="hidden" name="proveedor" value="<%=idP%>" >
                                    <input type="hidden" name="suc" value="<%=idSuc%>" >
                                    <input type="hidden" name="dep" value="<%=idDep%>" >
                                    <button type="submit" class="btn btn-info btn-sm" >Ver Orden</button>
                                </form>
                                    <form action="detalleComprasOrdenes.jsp" method="post">
                                    <input type="hidden" name="idCategoria" value="<%=id_categoria%>" >
                                    <input type="hidden" name="idProveedor" value="<%=idP%>" >
                                    <input type="hidden" name="idSucursal" value="<%=idSuc%>" >
                                    <input type="hidden" name="idDepartamento" value="<%=idDep%>" >
                                    <button type="submit" class="btn btn-success btn-sm" >Detalle</button>
                                </form>
                            </div>
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
