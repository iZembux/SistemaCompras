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
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                            <%= departamento %>
                        </td>
                        <td width="20%">&nbsp;</td>
                        <td width="30%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="20%">No. de O.C.</td>
                        <td width="30%">
                            <form>
                                <input type="text">
                            </form>
                        </td>
                        <td width="20%">&nbsp;</td>
                        <td width="30%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="20%">Proveedor</td>
                        <td width="30%">
                            <%= proveedor %>
                        </td>
                        <td width="20%">Fecha</td>
                        <td width="30%">
                            <form>
                                <input type="text">
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">Monto de compra</td>
                        <td width="30%">
                            <%= formateador.format(monto) %> 
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
                            <form>
                                <input type="text" size="5">
                            </form>
                        </td>
                        <td width="35%">Compra urgente</td>
                        <td width="15%" align="center">
                            <form>
                                <input type="text" size="5">
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td width="35%">Mejor calidad</td>
                        <td width="15%" align="center">
                            <form>
                                <input type="text" size="5">
                            </form>
                        </td>
                        <td width="35%">Unico fabricante</td>
                        <td width="15%" align="center">
                            <form>
                                <input type="text" size="5">
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td width="35%">Menor tiempo de entrega</td>
                        <td width="15%" align="center">
                            <form>
                                <input type="text" size="5">
                            </form>
                        </td>
                        <td width="35%">Mejores condiciones de pago</td>
                        <td width="15%" align="center">
                            <form>
                                <input type="text" size="5">
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td width="35%">Proyecto especial</td>
                        <td width="15%" align="center">
                            <form>
                                <input type="text" size="5">
                            </form>
                        </td>
                        <td width="35%">Otro</td>
                        <td width="15%" align="center">
                            <form>
                                <input type="text" size="5">
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br>
            Justificaci&oacute;n
            <table width="90%">
                <tr>
                    <td width="100%">
                        <%= justificacion %>
                    </td>
                </tr>
            </table>
            <br>
            <table width="100%">
                <tr>
                    <td width="33%">
                        <%= solicitante %>
                    </td>
                    <td width="33%">
                        <form>
                            <input type="text">
                        </form>
                    </td>
                    <td width="33%">
                        <form>
                            <input type="text">
                        </form>
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
    </body>
</html>
