<%-- 
    Document   : proveedorUnico
    Created on : 6/09/2018, 09:40:56 AM
    Author     : fer_k
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String solicitante = " ";
    String departamento = " ";
    String proveedor = " ";
    String justificacion = " ";
    double monto = 0;
    int check1 = 0;
    int check2 = 0;
    int check3 = 0;
    int check4 = 0;
    int check5 = 0;
    int check6 = 0;
    int check7 = 0;
    int check8 = 0;
    int nuevoStatus = 0;
    int idReqProd = 0;
    int idCategoria = 0;

    DecimalFormat formateador = new DecimalFormat("###,###,###.##");

    try {
        solicitante = request.getParameter("solicitante").toUpperCase();
    } catch (Exception e) {
    }
    try {
        departamento = request.getParameter("departamento").toUpperCase();
    } catch (Exception e) {
    }
    try {
        proveedor = request.getParameter("proveedor").toUpperCase();
    } catch (Exception e) {
    }
    try {
        justificacion = request.getParameter("justificacion").toUpperCase();
    } catch (Exception e) {
    }
    try {
        monto = Double.parseDouble(request.getParameter("monto"));
    } catch (Exception e) {
    }
    try {
        check1 = Integer.parseInt(request.getParameter("check1"));
    } catch (Exception e) {
    }
    try {
        check2 = Integer.parseInt(request.getParameter("check2"));
    } catch (Exception e) {
    }
    try {
        check3 = Integer.parseInt(request.getParameter("check3"));
    } catch (Exception e) {
    }
    try {
        check4 = Integer.parseInt(request.getParameter("check4"));
    } catch (Exception e) {
    }
    try {
        check5 = Integer.parseInt(request.getParameter("check5"));
    } catch (Exception e) {
    }
    try {
        check6 = Integer.parseInt(request.getParameter("check6"));
    } catch (Exception e) {
    }
    try {
        check7 = Integer.parseInt(request.getParameter("check7"));
    } catch (Exception e) {
    }
    try {
        check8 = Integer.parseInt(request.getParameter("check8"));
    } catch (Exception e) {
    }
    try {
        nuevoStatus = Integer.parseInt(request.getParameter("nuevoStatus"));
    } catch (Exception e) {
    }
    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }
    try {
        idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
    } catch (Exception e) {
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
                <form action="../actualizaProveedorUnico.jsp" method="post">
                    <input type="hidden" class="hidden" name="solicitante" value="<%=solicitante%>">
                    <input type="hidden" class="hidden" name="departamento" value="<%=departamento%>">
                    <input type="hidden" class="hidden" name="proveedor" value="<%=proveedor%>">
                    <input type="hidden" class="hidden" name="justificacion" value="<%=justificacion%>">
                    <input type="hidden" class="hidden" name="tamano" value="<%=monto%>">
                    <input type="hidden" class="hidden" name="check1" value="<%=check1%>"> 
                    <input type="hidden" class="hidden" name="check2" value="<%=check2%>">
                    <input type="hidden" class="hidden" name="check3" value="<%=check3%>">
                    <input type="hidden" class="hidden" name="check4" value="<%=check4%>">
                    <input type="hidden" class="hidden" name="check5" value="<%=check5%>">
                    <input type="hidden" class="hidden" name="check6" value="<%=check6%>">
                    <input type="hidden" class="hidden" name="check7" value="<%=check7%>">
                    <input type="hidden" class="hidden" name="check8" value="<%=check8%>">
                    <input type="hidden" class="hidden" name="idReqProd" value="<%= idReqProd%>" >
                    <input type="hidden" class="hidden" name="idCategoria" value="<%= idCategoria%>" >
                    <input type="hidden" class="hidden" name="nuevoStatus" value="7" >
                    <button type="submit" class="btn btn-success btn-sm">Solicitar Autorizaciones</button>
                </form>
            </div>
        </div>
    </body>
</html>
