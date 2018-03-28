<%@page import="controller.Consultas"%>
<%@page import="model.OrdenFormato"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String sucursal = " ";
    String rfc = null;
    String direccion = null;
    String nombreP = null;
    String direccionP = null;
    String fecha = null;
    String unidadMedida = null;
    String producto = null;
    String descripcion = null;
    String logo = null;
    int telefonoP = 0;
    int cantidad = 0;
    int descuento = 0;
    int precio = 0;
    int idReqCoti = 0;

    int idP = 0;
    int idReqProd = 0;
    String usuarioC = null;

    try {
        idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
    } catch (Exception e) {
    }

    ArrayList<OrdenFormato> arrayRequis = new ArrayList<OrdenFormato>();
    Consultas obj = new Consultas();
    arrayRequis = obj.consultarFormatoOrden(idReqCoti);

    if (!arrayRequis.isEmpty()) {
        sucursal = arrayRequis.get(0).getSucursal();
        rfc = arrayRequis.get(0).getRfc();
        direccion = arrayRequis.get(0).getDireccion();
        nombreP = arrayRequis.get(0).getNombreP();
        direccionP = arrayRequis.get(0).getDireccionP();
        fecha = arrayRequis.get(0).getFecha();
        unidadMedida = arrayRequis.get(0).getUnidadMedida();
        producto = arrayRequis.get(0).getProducto();
        descripcion = arrayRequis.get(0).getDescripcion();
        telefonoP = arrayRequis.get(0).getTelefonoP();
        cantidad = arrayRequis.get(0).getCantidad();
        descuento = arrayRequis.get(0).getDescuento();
        precio = arrayRequis.get(0).getPrecio();
    }

    if (sucursal.contains(" ")) {
        logo = "Continental.png";
    } else if (sucursal.equals("Hyundai Metepec")) {
        logo = "KoreanMete.png";
    }

%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>RequisicionCompra</title>
    </head>
    <body style=" zoom: 85%">
        <table width="863" height="1113" border="1" style="border-collapse: collapse" align="center">
            <caption>&nbsp;
            </caption>
            <tbody>
                <tr>
                    <th height="96" colspan="7" scope="col"><p><img src="../img/<%=logo %>" alt="" width="295" height="176" align="left"/></p>
                        <h1 align="center"><%=sucursal%></h1>
                        <h4 align="center">RFC: <%=rfc%></h4>
                        <h4 align="center"><%=direccion%></h4></th>
                </tr>
                <tr style="border-top-style: hidden;">
                    <td height="58" colspan="4" style="border-right: hidden"><p><strong>Proveedor</strong>: ( <%=idP%> )</p>
                        <p><strong><%=nombreP%></strong></p>
                        <p><%=direccionP%></p>
                        <p>Telefono: <%=telefonoP%></p></td>
                    <td colspan="3"><p>ORDEN No.: AN00000000157
                        </p>
                        <p><strong>Fecha</strong>: <%=fecha%></p>
                        <p><strong>Entregar a: </strong></p>
                        <p>Condiciones de pago: </p></td>
                </tr>
                <tr>
                    <td width="105" height="32"><strong>Cantidad</strong></td>
                    <td width="52"><strong>U/M</strong></td>
                    <td width="281"><strong>Producto</strong></td>
                    <td width="82"><strong>Descripción</strong></td>
                    <td width="121" height="32"><strong>% Desc.</strong></td>
                    <td width="120"><strong>Costo Unitario</strong></td>
                    <td width="56"><strong>Importe</strong></td>
                </tr>
                <tr style="border: none">
                    <td height="32"><strong></strong><%=cantidad%></td>
                    <td><strong></strong><%=unidadMedida%></td>
                    <td><strong></strong><%=producto%></td>
                    <td><strong></strong><%=descripcion%></td>
                    <td><strong></strong><%=descuento%> %</td>
                    <td><strong></strong><%=precio%></td>
                    <td><strong></strong><%=cantidad * precio%></td> 
                </tr>
                <tr style="border: none">
                    <td height="169" colspan="7">&nbsp;</td>
                </tr>
                <tr style="border: none">
                    <td height="270" colspan="3"><%=usuarioC%>, COMPRAS, RQ <%=idReqProd%></td>  
                    <td colspan="2" align="right"><p><strong>Subtotal</strong></p>
                        <p><strong>Descuento</strong></p>
                        <p><strong>L.E.P.S.</strong></p>
                        <p>&nbsp;</p>
                        <p><strong>I.V.A</strong></p>
                        <p><strong>Total</strong></p>
                        <p>&nbsp;</p></td>
                    <td colspan="2" align="right"><p><%=(cantidad * precio) - (cantidad * precio * (descuento / 100))%></p>
                        <p><%=(cantidad * precio * (descuento / 100))%></p>
                        <p>0.00</p>
                        <p>&nbsp;</p>
                        <p><%=(cantidad * precio) + (cantidad * precio * 0.16)%></p>
                        <p><%=(cantidad * precio) - (cantidad * precio * (descuento / 100))%></p>
                        <p>&nbsp;</p></td>
                </tr>
                <tr style="border: none">
                    <td colspan="4"><p>SEÑOR PROVEEDOR</p>
                        <p>Para trámite de pago deberá presentar:</p>
                        <dl style="text-align: justify; font-size: 1">
                            <dt>- Factura original y copia (En su factura debe de indicar el No. de Orden de Compra a la que corresponde)</dt>
                            <dt>- Orden de compra (Dos copias)</dt>
                            <dt>- Sello o Firma de recepcion de materiales</dt>
                            <dt>- Estado de cuenta bancario donde aparezca número de cuenta CLABE a donde se realizará el deposito (debe coincidir con su 	razón social)</dt>
                            <dt>- Enviar archivo PDF y XML de factura al correo: veronica.martinez@continental.com.mx</dt>
                            <dt>- El horario de revisión de facturas es de 16:00 a 18:00 hrs. los días hábiles</dt>
                        </dl>
                    <td colspan="3" align="center"><p>_____________________</p>
                        <p>VERONICA MARTÍNEZ</p>
                        <p>GERENTE DE COMPRAS</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>ELABORÓ: <%=usuarioC%></p></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
