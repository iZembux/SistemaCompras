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
    int cantidad = 0;
    int idReqProd = 0;

    try {
        idReqProd = Integer.parseInt(request.getParameter("idReqProd"));
    } catch (Exception e) {
    }

    ArrayList<RequisicionFormato> arrayRequis = new ArrayList<RequisicionFormato>();
    Consultas obj = new Consultas();
    arrayRequis = obj.consultarFormatoRequisicion(idReqProd);

    if (arrayRequis.size() > 0) {
        sucursal = arrayRequis.get(0).getSucursal();
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
    }

%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>RequisicionCompra</title>
    </head>

    <body>
        <table width="1153" height="1217" border="1" align="center">
            <tbody>
                <tr style="border-top: hidden; border-left: hidden; border-right: hidden">
                    <th height="53" colspan="2" scope="col"><img src="" alt="" width="219" height="65" align="left"/>
                    </th>
                    <th height="53" colspan="5" scope="col" style="align-content: center; border-left: hidden; font-size: 1">
                        Requisicion de Compra
                    </th>
                </tr>
                <tr style="">
                    <td height="239" colspan="4">
                        <p>Centro de Negocios: <%=sucursal%></p>
                        <p>Solcitado por: <%=nombre + " " + apellidoM + " " + apellidoP%></p>
                        <p>Departamento: <%=departamento%></p>
                        <p>Encargado de la custodia del Bien:</p>
                        <p>Justificación de la compra: <%=justificacion%></p></td>
                    <td colspan="3"><p>&nbsp;</p>
                        <p>Fecha: <%=fecha%></p>
                        <p>Empresa: </p>
                        <p>Compra General:</p>
                        <p>Activo Fijo:</p></td>
                </tr>
                <tr align="center">
                </tr>
                <tr align="center">
                    <td width="81" height="66">CANTIDAD</td>
                    <td width="294" >DESCRIPCIÓN / ESPECIFICACIÓN TÉCNICA</td>
                    <td width="137">MODELO</td>
                    <td width="152">MARCA</td>
                    <td width="144">TAMAÑO</td>
                    <td width="123">COLOR</td>
                    <td width="176">OBSERVACIONES</td>
                </tr>
                <tr align="center">
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

                </tr>
                <tr align="center">
                    <td height="94" colspan="2" ><p>Solicitó (Nombre y Firma)</p>
                        <p>______________________________</p></td>
                    <td colspan="3"><p>Autorizó (Nombre y Firma)</p>
                        <p>______________________________</p></td>
                    <td colspan="2"><p>Recibo Compras (Nombre y Fecha)</p>
                        <p>______________________________</p></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
