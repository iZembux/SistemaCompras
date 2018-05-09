<%@page import="java.text.DecimalFormat"%>
<%@page import="model.RequisicionFormato"%>
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
    String descripcion = " ";
    String logo = null;
    String telefonoP = null;
    String nombreC = null;
    String apellidoC = null;
    String apellidoMC = null;
    int cantidad = 0;
    int descuento = 0;
    double precio = 0;
    int credito = 0;
    int idCotizacion = 0;
    int idP = 0;
    int idDep = 0;
    int idUsuCompras = 0;
    double subtotal = 0;

    int idProv = 0;
    int categoria = 0;
    int idSuc = 0;

    try {
        categoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }
    try {
        idProv = Integer.parseInt(request.getParameter("proveedor"));
    } catch (Exception e) {
    }
    try {
        idSuc = Integer.parseInt(request.getParameter("suc"));
    } catch (Exception e) {
    }
    try {
        idDep = Integer.parseInt(request.getParameter("dep"));
    } catch (Exception e) {
    }

    ArrayList<OrdenFormato> arrayRequis = new ArrayList<OrdenFormato>();
    ArrayList<RequisicionFormato> arrayRequis2 = new ArrayList<RequisicionFormato>();
    ArrayList<OrdenFormato> arrayRequis3 = new ArrayList<OrdenFormato>();
    Consultas obj = new Consultas();
    DecimalFormat formateador = new DecimalFormat("###,###,###.##");
    

    arrayRequis = obj.consultarOrdenesProvAcum(idProv, idSuc, categoria, idDep);
    if (!arrayRequis.isEmpty()) {
        idCotizacion = arrayRequis.get(0).getIdCotizacion();
        idP = arrayRequis.get(0).getIdP();
        sucursal = arrayRequis.get(0).getSucursal();
        rfc = arrayRequis.get(0).getRfc();
        direccion = arrayRequis.get(0).getDireccion();
        nombreP = arrayRequis.get(0).getNombreP();
        direccionP = arrayRequis.get(0).getDireccionP();
        fecha = arrayRequis.get(0).getFecha();
        telefonoP = arrayRequis.get(0).getTelefonoP();
        credito = arrayRequis.get(0).getDiasCredito();
        idUsuCompras = arrayRequis.get(0).getUsuCompras();
    }

    arrayRequis2 = obj.consultarUsuario(idUsuCompras);
    if (!arrayRequis.isEmpty()) {
        nombreC = arrayRequis2.get(0).getNombre();
        apellidoC = arrayRequis2.get(0).getApellidoP();
        apellidoMC = arrayRequis2.get(0).getApellidoM();
    }

    if (sucursal.contains("CONTINENTAL") || sucursal.contains("FIAT TOLUCA") || sucursal.contains("MITSUBISHI TOLUCA")) {
        logo = "Continental.png";
    } else if (sucursal.equals("HYUNDAI METEPEC")) {
        logo = "KoreanMotors.png";
    } else if (sucursal.equals("HYUNDAI PATRIOTISMO")) {
        logo = "HyundaiPatriotismo.png";
    } else if (sucursal.equals("HYUNDAI SANTA FE")) {
        logo = "HyundaiStafe.png";
    } else if (sucursal.equals("TOYOTA SANTA FE")) {
        logo = "Nihon.jpg";
    } else if (sucursal.equals("TOYOTA PUERTA SANTA FE")) {
        logo = "PuertaSantaFe.jpg";
    } else if (sucursal.equals("SAN RAFAEL")) {
        logo = "SanRafael.png";
    } else if (sucursal.equals("AUTOPOLANCO")) {
        logo = "Autopolanco.jpeg";
    } else if (sucursal.equals("CASOFIN")) {
        logo = "Casofin.jpg";
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
                    <th height="96" colspan="7" scope="col"><p><img src="../img/<%=logo%>" alt="" width="295"  align="left"/></p>
                        <h2 align="center"><%=sucursal%></h2>
                        <h4 align="center">RFC: <%=rfc%></h4>
                        <h4 align="center"><%=direccion%></h4></th>
                </tr>
                <tr style="border-top-style: hidden;">
                    <td height="58" colspan="4" style="border-right: hidden"><p><strong>Proveedor</strong>: ( <%=idP%> )</p>
                        <p><strong><%=nombreP%></strong></p>
                        <p><%=direccionP%></p>
                        <p>Telefono: <%=telefonoP%></p></td>
                    <td colspan="3"><p>ORDEN No.: AN00000000<%= idCotizacion%>
                        </p>
                        <p><strong>Fecha</strong>: <%=fecha%></p>
                        <p><strong>Entregar a:</strong> COMPRAS</p>
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
                <% arrayRequis3 = obj.consultarOrdenesProvAcum(idProv, idSuc, categoria, idDep);
                System.out.println(arrayRequis3.size());
                    if (arrayRequis3.size() > 0) {
                        for (int i = 0; i < arrayRequis3.size(); i++) {
                            cantidad = arrayRequis.get(i).getCantidad();
                            unidadMedida = arrayRequis.get(i).getUnidadMedida();
                            producto = arrayRequis.get(i).getProducto();
                            //descripcion = arrayRequis.get(i).getDescripcion();
                            descuento = arrayRequis.get(i).getDescuento();
                            precio = arrayRequis.get(i).getPrecio();
                            subtotal += (cantidad * precio);

                %>
                <tr style="border: none; text-align: center">
                    <td height="32"><strong></strong><%=cantidad%></td>
                    <td><strong></strong><%=unidadMedida%></td>
                    <td><strong></strong><%=producto%></td>
                    <td><strong></strong><%=descripcion%></td>
                    <td><strong></strong><%=descuento%> %</td>
                    <td><strong></strong>$<%=precio%></td>
                    <td><strong></strong>$<%=cantidad * precio%></td> 
                </tr>
                <% }
                    }
                %>
                <tr style="border: none">
                    <td height="169" colspan="7">&nbsp;</td>
                </tr>
                <tr style="border: none">
                    <td height="270" colspan="3"></td>  
                    <td colspan="2" align="right"><p><strong>Subtotal</strong></p>
                        <p><strong>Descuento</strong></p>
                        <p><strong>L.E.P.S.</strong></p>
                        <p>&nbsp;</p>
                        <p><strong>I.V.A</strong></p>
                        <p><strong>Total</strong></p>
                        <p>&nbsp;</p></td>
                    <td colspan="2" align="right"><p><%=formateador.format((subtotal) - (subtotal * (descuento / 100)))%></p>
                        <p><%=formateador.format((cantidad * precio * (descuento / 100)))%></p>
                        <p>0.00</p>
                        <p>&nbsp;</p>
                        <p><%=formateador.format(subtotal * 0.16)%></p>
                        <p><%=formateador.format((subtotal) - (subtotal * (descuento / 100)) + (subtotal * 0.16))%></p>
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
                        <p>ELABORÓ: <%=nombreC + " " + apellidoC + " " + apellidoMC%></p></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
