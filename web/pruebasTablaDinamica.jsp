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
        String cat = null;

        if (usuario.equals("83")) {       //Valeria
            suc = "1,2,3,4,6,7,8,13";
            cat = "1,4,5,6";
        } else if (usuario.equals("4")) { //Veronica
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
            cat = "1,2,3,4";
        } else if (usuario.equals("25")) { //Angelica
            suc = "10,11,15,16,18";
            cat = "1";
        } else if (usuario.equals("226")) { //Roberto 
            suc = "9,14,17";
            cat = "1";
        } else if (usuario.equals("268")) { //Victor Peralta
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
            cat = "2";
        } else if (usuario.equals("48")) { //Esau Embriz
            suc = "1,2,3,4,6,7,8,13,9,14,17,10,11,15,16,18";
            cat = "7";
        }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script type="text/javascript" src="js/stacktable.js"></script>
        <title>Administracion</title>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#t1').stacktable();
            });
        </script>
    </head>
    <body>

        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="<%=rol%>" />  
            <jsp:param name="depto" value="<%=idDepto%>" />
        </jsp:include>

        <div class="container my-5">
            <div class="page-header">
                <h3>Seguimiento de Cotizaciones</h3>
            </div>
            <table id="t1" class="table stacktable" border="0">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Solicitante</th>
                        <th scope="col">Departamento</th>
                        <th scope="col">Sucursal</th>
                        <th scope="col">Producto</th>
                        <th scope="col">Estatus</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int noRequi = 0;
                        String solicitante = "";
                        String departamento = "";
                        String sucursal = "";
                        String producto = "";
                        String status = "";

                        ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                        Consultas obj = new Consultas();
                        arrayRequis = obj.consultarAdministracionRequisiciones(suc, cat);

                        if (arrayRequis.size() > 0) {
                            for (int i = 0; i < arrayRequis.size(); i++) {
                                noRequi = arrayRequis.get(i).getIdRequisicion();
                                solicitante = arrayRequis.get(i).getSolicitante();
                                departamento = arrayRequis.get(i).getDepartamento();
                                sucursal = arrayRequis.get(i).getSucursal();
                                producto = arrayRequis.get(i).getProducto();
                                status = arrayRequis.get(i).getStatus();

                    %>
                    <tr>
                        <td><%=noRequi%></td>
                        <td><%=solicitante%></td>
                        <td><%=departamento.toUpperCase()%></td>
                        <td><%=sucursal%></td> 
                        <td><%=producto%></td>
                        <td><%=status.toUpperCase()%></td>
                        <td>
                            <form action="formatos/requisicion.jsp" method="post" target="_blank">
                                <input type="hidden" class="hidden" name="idReqProd" value="<%=noRequi%>" >
                                <button type="submit" class="btn btn-info btn-sm">Ver Requisicion</button>
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
        <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <!--================================= Scrip de DataTables  =========================-->
        <script type="text/javascript">
                $(document).ready( function () {
                    $('#t1').DataTable();
                } );
        </script>


        <!--=============================== End Scrip de DataTables  =====================-->
    </body>
</html>
<% }%>