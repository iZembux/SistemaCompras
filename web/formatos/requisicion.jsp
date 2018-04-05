<%-- 
    Document   : requisicion
    Created on : 26-mar-2018, 12:22:16
    Author     : JefeDesarrollo
--%>

<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionFormato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String sucursal = null;
    String departamento = null;
    String nombre = null;
    String apellidoP = null;
    String apellidoM = null;
    String justificacion = null;
    String fecha = null;
    String producto = null;
    String descripcion = null;
    String marca = null;
    String modelo = null;
    String logo = null;
    String empresa = null;
    String cGeneral = "x";
    String cActivo = "x";
    int cantidad = 0;
    int idReqProd = 0;
    int activo = 0;

    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }

    ArrayList<RequisicionFormato> arrayRequis = new ArrayList<RequisicionFormato>();
    Consultas obj = new Consultas();
    arrayRequis = obj.consultarFormatoRequisicion(idReqProd);

    if (arrayRequis.size() > 0) {
        sucursal = arrayRequis.get(0).getSucursal();
        empresa = arrayRequis.get(0).getEmpresa();
        nombre = arrayRequis.get(0).getNombre();
        apellidoP = arrayRequis.get(0).getApellidoP();
        apellidoM = arrayRequis.get(0).getApellidoM();
        departamento = arrayRequis.get(0).getDepartamento();
        justificacion = arrayRequis.get(0).getJustificacion();
        fecha = arrayRequis.get(0).getFecha();
        producto = arrayRequis.get(0).getProducto();
        cantidad = arrayRequis.get(0).getCantidad();
        descripcion = arrayRequis.get(0).getDescripcion();
        marca = arrayRequis.get(0).getMarca();
        modelo = arrayRequis.get(0).getModelo();
        activo = arrayRequis.get(0).getActivo();
    }

    if (activo == 1) {
        cActivo = "x";
        cGeneral = "&nbsp;";
    } else if (activo == 0) {
        cActivo = "&nbsp;";
        cGeneral = "x";
    }
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>RequisicionCompra</title>
        <style>
            table {
                border-collapse:separate;
                border:solid black 1px;
                border-radius:20px;
                -mozborder-radius:20px;
            }

            td, th {
                border-left:solid black 1px;
                border-top:solid black 1px;
            }

            th {
                border-top: none;
            }
            td:first-child {
                border-left: none;
            }
            th:first-child, th:last-child {
                border-radius:20px;
                border-left: none;
            }
        </style>
    </head>

    <body>
        <table width="1153" align="center">
            <tbody>
                <tr style="border-top: hidden; border-left: hidden; border-right: hidden">
                    <th height="53" colspan="2"><img src="../img/<%=logo%>" alt="" width="219" height="65" align="left"/>
                    </th>
                    <th height="53" colspan="3" style="text-align: center; border-left: hidden; font-size: 1">
                        Requisicion de Compra
                    </th>
                </tr>
                <tr>
                    <td height="119" colspan="2" style="text-align: right; border-right: hidden">
                        <p>Centro de Negocios: </p>
                        <p>Solicitado por: </p>
                        <p>Departamento: </p>
                        <p>Encargado de la custodia del Bien: </p>
                        <p>Justificación de la compra: </p>
                    </td>
                    <td height="120" colspan="2" style="border-left: hidden">
                        <p style="background-color: #CFEFFA"> <%= " " + sucursal%></p>
                        <p style="background-color: #CFEFFA"> <%= " " + nombre + " " + apellidoP + " " + apellidoM%></p>
                        <p style="background-color: #CFEFFA"> <%= " " + departamento%></p>
                        <p style="background-color: #CFEFFA"> <%= " " + nombre + " " + apellidoP + " " + apellidoM%></p>
                        <p style="background-color: #CFEFFA"> <%= " " + justificacion%></p>
                    </td>
                    <td colspan="2" style="text-align: right; border-right: hidden">
                        <p>Fecha:</p>
                        <p>Empresa: </p>
                        <p>Compra General:</p>
                        <p>Activo Fijo:</p>
                        <p>&nbsp;</p>
                    </td>
                    <td colspan="1" style="border-left: hidden">
                        <p style="background-color: #CFEFFA"><%=fecha%></p>
                        <p style="background-color: #CFEFFA"><%=empresa%></p>
                        <p style="background-color: #CFEFFA"><%=cGeneral%></p>
                        <p style="background-color: #CFEFFA"><%=cActivo%></p>
                        <p>&nbsp;</p>
                    </td>
                </tr>
            </tbody>
        </table>
        <br>
        <table width="1153" align="center">
            <tbody  style="background-color: #CFEFFA">
                <tr align="center" style="background-color: white">
                    <th width="81" height="30">CANTIDAD</th>
                    <th width="294">DESCRIPCIÓN</th>
                    <th width="137">MODELO</th>
                    <th width="152">MARCA</th>
                    <th width="144">TAMAÑO</th>
                    <th width="123" style="border-right:solid black 1px">COLOR</th>
                    <th width="176">OBSERVACIONES</th>
                </tr>
                <tr align="center" >
                    <td height="45"><%=cantidad%></td>
                    <td><%=producto%></td>
                    <td><%=modelo%></td>
                    <td><%=marca%></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><%=descripcion%></td>
                </tr>
                <tr>
                    <td height="45">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td height="45">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td height="586">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
            </tbody>
        </table>
        <br>
        <table width="1153" align="center">
            <tbody>
                </tr>
                <tr align="center">
                    <th height="94" colspan="2" ><p>Solicitó</p>
                        <p><%=nombre + " " + apellidoP + " " + apellidoM%></p></th>
                    <th colspan="3" style="border-right:solid black 1px"><p>Autorizó</p>
                        <p>______________________________</p></th>
                    <th colspan="2"><p>Recibo Compras (Nombre y Fecha)</p>
                        <p>______________________________</p></th>
                </tr>
            </tbody>
        </table>
    </body>
</html>
