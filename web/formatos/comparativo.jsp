<%-- 
    Document   : comparativo
    Created on : 16-mar-2018, 11:46:08
    Author     : JefeDesarrollo
--%>

<%@page import="controller.Consultas"%>
<%@page import="model.CotizacionRequisicion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String proveedor = null, proveedor2 = null, proveedor3 = null;
    String producto = null, producto2 = null, producto3 = null;
    String solicitante = null;
    String departamento = null;
    String sucursal = null;
    String fecha = null;
    int cantidad = 0, cantidad2 = 0, cantidad3 = 0;
    int precio = 0, precio2 = 0, precio3 = 0;
    int iva = 0, iva2 = 0, iva3 = 0;
    int descuento = 0, descuento2 = 0, descuento3 = 0;
    int credito = 0, credito2 = 0, credito3 = 0;
    int entrega = 0, entrega2 = 0, entrega3 = 0;
    int anticipo = 0, anticipo2 = 0, anticipo3 = 0;
    int idCotizacion = 0, idCotizacion2 = 0, idCotizacion3 = 0;

    ArrayList<Integer> idCoti = new ArrayList<Integer>();
    for (int i = 0; i < 3; i++) {
        try {
            idCoti.add(Integer.parseInt(request.getParameter("checkbox" + i)));
        } catch (Exception e) {
        }
    }

    ArrayList<CotizacionRequisicion> arrayRequis = new ArrayList<CotizacionRequisicion>();
    Consultas obj = new Consultas();
    try {
        arrayRequis = obj.consultarCotizaciones(idCoti.get(0));
        solicitante = arrayRequis.get(0).getSolicitante();
        departamento = arrayRequis.get(0).getDepto();
        sucursal = arrayRequis.get(0).getSucursal();
        fecha = arrayRequis.get(0).getFecha();
        idCotizacion = arrayRequis.get(0).getIdC();
        proveedor = arrayRequis.get(0).getProveedor();
        producto = arrayRequis.get(0).getProducto();
        cantidad = arrayRequis.get(0).getCantidad();
        precio = arrayRequis.get(0).getPrecio();
        iva = arrayRequis.get(0).getIva();
        descuento = arrayRequis.get(0).getDescuento();
        credito = arrayRequis.get(0).getCredito();
        entrega = arrayRequis.get(0).getEntrega();
        anticipo = arrayRequis.get(0).getAnticipo();
    } catch (Exception e) {
        System.out.println("No hay mas cotizaciones");
    }
    try {
        arrayRequis = obj.consultarCotizaciones(idCoti.get(1));
        idCotizacion2 = arrayRequis.get(0).getIdC();
        proveedor2 = arrayRequis.get(0).getProveedor();
        producto2 = arrayRequis.get(0).getProducto();
        cantidad2 = arrayRequis.get(0).getCantidad();
        precio2 = arrayRequis.get(0).getPrecio();
        iva2 = arrayRequis.get(0).getIva();
        descuento2 = arrayRequis.get(0).getDescuento();
        credito2 = arrayRequis.get(0).getCredito();
        entrega2 = arrayRequis.get(0).getEntrega();
        anticipo2 = arrayRequis.get(0).getAnticipo();
    } catch (Exception e) {
        System.out.println("No hay mas cotizaciones");
    }
    try {
        arrayRequis = obj.consultarCotizaciones(idCoti.get(2));
        idCotizacion3 = arrayRequis.get(0).getIdC();
        proveedor3 = arrayRequis.get(0).getProveedor();
        producto3 = arrayRequis.get(0).getProducto();
        cantidad3 = arrayRequis.get(0).getCantidad();
        precio3 = arrayRequis.get(0).getPrecio();
        iva3 = arrayRequis.get(0).getIva();
        descuento3 = arrayRequis.get(0).getDescuento();
        credito3 = arrayRequis.get(0).getCredito();
        entrega3 = arrayRequis.get(0).getEntrega();
        anticipo3 = arrayRequis.get(0).getAnticipo();
    } catch (Exception e) {
        System.out.println("No hay mas cotizaciones");
    }

%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Documento sin título</title>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    </head>

    <body>
        <table width="100%" border="1" style="border-collapse: collapse; text-align: center">
            <tbody>
                <tr>
                    <td width="15%" style=" border-top: hidden; border-left: hidden; border-bottom: hidden">&nbsp;</td>
                    <td><strong>COMPARATIVO DE COMPRAS</strong></td>
                </tr>
            </tbody>
        </table>
        <br>
        <br>
        <br>
        <br>
        <table width="100%" border="1" style="border-collapse: collapse; font-size: 10px">
            <tbody>
                <tr>
                    <td width="10%" style="border: hidden">Solicita:</td>
                    <td width="30%" style="border-top: hidden"><%=solicitante%></td>
                    <td width="25%" style="border: hidden">&nbsp;</td>
                    <td width="15%" style="border: hidden">Compra General</td>
                    <td width="10%" style=""></td>
                    <td width="10%" style="border: hidden">&nbsp;</td>
                </tr>
                <tr>
                    <td style="border: hidden">Fecha:</td>
                    <td><%=fecha%></td>
                    <td style="border: hidden">&nbsp;</td>
                    <td style="border: hidden">Activo Fijo</td>
                    <td style=""></td>
                    <td style="border: hidden">&nbsp;</td>
                </tr>
                <tr>
                    <td style="border: hidden">Departamento:</td>
                    <td><%=departamento%></td>
                    <td style="border: hidden">&nbsp;</td>
                    <td style="border: hidden">&nbsp;</td>
                    <td style="border: hidden">&nbsp;</td>
                    <td style="border: hidden">&nbsp;</td>
                </tr>
                <tr>
                    <td style="border: hidden">Sucursal:</td>
                    <td><%=sucursal%></td>
                    <td style="border: hidden">&nbsp;</td>
                    <td style="border: hidden">&nbsp;</td>
                    <td style="border: hidden">&nbsp;</td>
                    <td style="border: hidden">&nbsp;</td>
                </tr>
            </tbody>
        </table>
        <br>
        <br>
        <table width="100%" border="1" style="border-collapse: collapse; text-align: center; font-size: 10px">
            <tbody>
                <tr>
                    <td width="5%" style="border: hidden">&nbsp;</td>
                    <td width="5%" style="border: hidden">&nbsp;</td>
                    <td width="30%" style="border-bottom: hidden; border-top: hidden">&nbsp;</td>
                    <td width="65%" colspan="6"><strong>PROVEEDORES </strong></td>
                </tr>
                <tr>
                    <td style="border: hidden">&nbsp;</td>
                    <td style="border: hidden">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td width="20%" colspan="2" style="height: 150px"><%=proveedor%></td>
                    <td width="20%" colspan="2"><%=proveedor2%></td>
                    <td width="20%" colspan="2"><%=proveedor3%></td>
                </tr>
                <tr>
                    <td style="border-left: hidden; border-right: hidden">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td style="border-left: hidden; border-top: hidden">&nbsp;</td>
                    <td colspan="2"><strong>COTIZACION 1 </strong></td>
                    <td colspan="2"><strong>COTIZACION 2 </strong></td>
                    <td colspan="2"><strong> COTIZACION 3</strong></td>
                </tr>
                <tr>
                    <td><strong> CANT</strong></td>
                    <td><strong> U/M</strong></td>
                    <td><strong> DESCRIPCION</strong></td>
                    <td width="10%"><strong> P. UNITARIO</strong></td>
                    <td width="10%"><strong>P.TOTAL </strong></td>
                    <td width="10%"><strong>P. UNITARIO </strong></td>
                    <td width="10%"><strong>P. TOTAL </strong></td>
                    <td width="10%"><strong> P. UNITARIO</strong></td>
                    <td width="10%"><strong>P. TOTAL </strong></td>
                </tr>
                <tr height="50px">
                    <td><%=cantidad%></td>
                    <td>&nbsp;</td>
                    <td><%=producto%></td>
                    <td><%=precio%></td>
                    <td><%=precio*cantidad%></td>
                    <td><%=precio2%></td>
                    <td><%=precio2*cantidad2%></td>
                    <td><%=precio3%></td>
                    <td><%=precio3*cantidad3%></td>
                </tr>
                <tr height="50px">
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr height="50px">
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </tbody>
        </table>
        <br>
        <br>
        <table width="100%" border="1" style="border-collapse: collapse; text-align: right; font-size: 10px">
            <tbody>
                <tr>
                    <td width="10%" style="border-left: hidden; border-top: hidden">&nbsp;</td>
                    <td width="30%">SUBTOTAL</td>
                    <td width="10%" style="border-top: hidden">&nbsp;</td>
                    <td width="10%">$<%=precio*cantidad%></td>
                    <td width="10%" style="border-top: hidden">&nbsp;</td>
                    <td width="10%">$<%=precio2*cantidad2%></td>
                    <td width="10%" style="border-top: hidden">&nbsp;</td>
                    <td width="10%">$<%=precio3*cantidad3%></td>
                </tr>
                <tr>
                    <td style="border-left: hidden; border-top: hidden">&nbsp;</td>
                    <td>IVA</td>
                    <td style="border-top: hidden">&nbsp;</td>
                    <td>$<%=iva%></td>
                    <td style="border-top: hidden">&nbsp;</td>
                    <td>$<%=iva2%></td>
                    <td style="border-top: hidden">&nbsp;</td>
                    <td>$<%=iva3%></td>
                </tr>
                <tr>
                    <td style="border-left: hidden; border-top: hidden; border-bottom: hidden">&nbsp;</td>
                    <td>TOTAL EN PESOS</td>
                    <td style="border-top: hidden; border-bottom: hidden">&nbsp;</td>
                    <td>$<%=precio*cantidad+iva%></td>
                    <td style="border-top: hidden; border-bottom: hidden">&nbsp;</td>
                    <td>$<%=precio2*cantidad2+iva2%></td>
                    <td style="border-top: hidden; border-bottom: hidden">&nbsp;</td>
                    <td>$<%=precio3*cantidad3+iva3%></td>
                </tr>
            </tbody>
        </table>
        <br>
        <br>
        <table width="100%" style="border-collapse: collapse; text-align: center; font-size: 10px">
            <tbody>
                <tr>
                    <td width="10%">&nbsp;</td>
                    <td width="30%" style="text-align: left">CREDITO EN DIAS</td>
                    <td width="10%">&nbsp;</td>
                    <td width="10%"><%=credito%></td>
                    <td width="10%">&nbsp;</td>
                    <td width="10%"><%=credito2%></td>
                    <td width="10%">&nbsp;</td>
                    <td width="10%"><%=credito3%></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td style="text-align: left">TIEMPO DE ENTREGA</td>
                    <td>&nbsp;</td>
                    <td><%=entrega%></td>
                    <td>&nbsp;</td>
                    <td><%=entrega%></td>
                    <td>&nbsp;</td>
                    <td><%=entrega%></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td style="text-align: left">ANTICIPO</td>
                    <td>&nbsp;</td>
                    <td><%=anticipo%></td>
                    <td>&nbsp;</td>
                    <td><%=anticipo2%></td>
                    <td>&nbsp;</td>
                    <td><%=anticipo3%></td>
                </tr>
            </tbody>
        </table>
        <br>
        <br>
        <table width="100%" border="1" style="border-collapse: collapse; font-size: 10px">
            <tbody>
                <tr>
                    <td style="border-top: hidden; border-left: hidden; border-right: hidden"><strong>OBSERVACIONES</strong></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </tbody>
        </table>
        <br>
        <br>
        <table width="100%" style="border-collapse: collapse; font-size: 10px">
            <tbody>
                <tr>
                    <td>ELABORÓ</td>
                    <td>Nivel 1</td>
                    <td>Nivel 2</td>
                    <td>Nivel 3</td>
                    <td>Nivel 4</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>GERENCIA DE COMPRAS</td>
                    <td><i class="fas fa-check"></i></td>
                    <td><i class="fas fa-check"></i></td>
                    <td><i class="fas fa-check"></i></td>
                    <td><i class="fas fa-times"></i></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
