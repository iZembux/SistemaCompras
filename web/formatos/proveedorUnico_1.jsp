<%-- 
    Document   : proveedorUnico
    Created on : 6/09/2018, 09:40:56 AM
    Author     : fer_k
--%>

<%@page import="model.FormatoUnico"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Consultas"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String solicitante = " ";
    String departamento = " ";
    String proveedor = " ";
    String justificacion = " ";
    String fecha = " ";
    double monto = 0;
    int check1 = 0;
    int check2 = 0;
    int check3 = 0;
    int check4 = 0;
    int check5 = 0;
    int check6 = 0;
    int check7 = 0;
    int check8 = 0;
    int idFormato = 0;
    int usuario = 0;

    DecimalFormat formateador = new DecimalFormat("###,###,###.##");

    try {
        idFormato = Integer.parseInt(request.getParameter("idFormato"));
    } catch (Exception e) {
    }

    try {
        usuario = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }
    
    Consultas obj = new Consultas();

    ArrayList<FormatoUnico> list = new ArrayList<FormatoUnico>();

    list = obj.consultarProveedorUnico(idFormato);
    if (list.size() > 0) {
        departamento = list.get(0).getDepartamento();
        proveedor = list.get(0).getProveedor();
        fecha = list.get(0).getFecha();
        monto = list.get(0).getMonto();
        check1 = list.get(0).getCheck1();
        check2 = list.get(0).getCheck2();
        check3 = list.get(0).getCheck3();
        check4 = list.get(0).getCheck4();
        check5 = list.get(0).getCheck5();
        check6 = list.get(0).getCheck6();
        check7 = list.get(0).getCheck7();
        check8 = list.get(0).getCheck8();
        justificacion = list.get(0).getJustificacion();
        solicitante = list.get(0).getSolicitante();

    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <title>Formato Proveedor Unico</title>
    </head>
    <body>
        <div style="min-width: 650px; 
             max-width: 900px; 
             margin: auto;
             border-style: solid;
             padding: 25px 25px 25px 25px;">
            <font face="Arial">
            <table width="100%" style="border: 2px solid black">
                <tbody>
                    <tr align="center">
                        <td><strong>Departamento de Compras</strong></td>
                    </tr>
                    <tr align="center">
                        <td><strong>Justificaci&oacute;n de Selecci&oacute;n de Proveedor</strong></td>
                    </tr>
                </tbody>
            </table>
            <br>
            <table width="100%" border="0" align="center">
                <tbody>
                    <tr>
                        <td width="20%">Departamento</td>
                        <td width="30%">
                            <%= departamento%>
                        </td>
                        <td width="20%">&nbsp;</td>
                        <td width="30%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="20%">No. de O.C.</td>
                        <td width="30%">

                        </td>
                        <td width="20%">&nbsp;</td>
                        <td width="30%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="20%">Proveedor</td>
                        <td width="30%">
                            <%= proveedor%>
                        </td>
                        <td width="20%">Fecha</td>
                        <td width="30%">
                            <%= fecha%>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">Monto de compra</td>
                        <td width="30%">
                            <%= formateador.format(monto)%> 
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </tbody>
            </table>
            <br>
            Criterios de selecci&oacute;n del proveedor
            <br><br>
            <table width="100%" border="0" align="center">
                <tbody>
                    <tr>
                        <td width="35%">Ahorro en costo</td>
                        <td width="15%" align="center">
                            <%if (check1 == 1) {%>
                            X     
                            <% }%>
                        </td>
                        <td width="35%">Compra urgente</td>
                        <td width="15%" align="center">
                            <%if (check5 == 1) {%>
                            X     
                            <% }%>
                        </td>
                    </tr>
                    <tr>
                        <td width="35%">Mejor calidad</td>
                        <td width="15%" align="center">
                            <%if (check2 == 1) {%>
                            X     
                            <% }%>
                        </td>
                        <td width="35%">Unico fabricante</td>
                        <td width="15%" align="center">
                            <%if (check6 == 1) {%>
                            X     
                            <% }%>
                        </td>
                    </tr>
                    <tr>
                        <td width="35%">Menor tiempo de entrega</td>
                        <td width="15%" align="center">
                            <%if (check3 == 1) {%>
                            X     
                            <% }%>
                        </td>
                        <td width="35%">Mejores condiciones de pago</td>
                        <td width="15%" align="center">
                            <%if (check7 == 1) {%>
                            X     
                            <% }%>
                        </td>
                    </tr>
                    <tr>
                        <td width="35%">Proyecto especial</td>
                        <td width="15%" align="center">
                            <%if (check4 == 1) {%>
                            X     
                            <% }%>
                        </td>
                        <td width="35%">Otro</td>
                        <td width="15%" align="center">
                            <%if (check8 == 1) {%>
                            X     
                            <% }%>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br>
            Justificaci&oacute;n
            <table width="90%">
                <tr>
                    <td width="100%">
                        <%= justificacion%>
                    </td>
                </tr>
            </table>
            <br>
            <table width="100%">
                <tr>
                    <td width="33%">
                        <%= solicitante%>
                    </td>
                    <td width="33%">

                    </td>
                    <td width="33%">

                    </td>
                </tr>
                <tr>
                    <td width="33%">Solicitante</td>
                    <td width="33%">Autoriz&oacute;</td>
                    <td width="33%">Autoriz&oacute;</td>
                </tr>
            </table>
            </font>
        </div>

        <div class="card mx-auto w-50">
            <div class="card-body" style="text-align: center;">
                <div class="row" >
                    <form action="../actualizaProveedorUnico_1.jsp" method="post">
                        <input type="hidden" class="hidden" name="idFormato" value="<%= idFormato%>" >
                        <input type="hidden" class="hidden" name="usuario" value="<%= usuario%>" >
                        <input type="hidden" class="hidden" name="nuevoStatus" value="9" >
                        <button type="submit" class="btn btn-success btn-sm">Autorizar</button>
                    </form>
                    <form action="../actualizaProveedorUnico.jsp" method="post">
                        <input type="hidden" class="hidden" name="usuario" value="<%= usuario%>" >
                        <input type="hidden" class="hidden" name="idFormato" value="<%= idFormato%>" >
                        <input type="hidden" class="hidden" name="nuevoStatus" value="14" >
                        <button type="submit" class="btn btn-danger btn-sm">Rechazar</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
