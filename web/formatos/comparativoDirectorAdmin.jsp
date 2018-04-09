<%-- 
    Document   : comparativoGerenteAdmin
    Created on : 16-mar-2018, 11:46:08
    Author     : JefeDesarrollo

    Muestra el cuadro comparativo autorizado por el gerente administrativo
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="controller.Consultas"%>
<%@page import="model.CotizacionRequisicion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String proveedor = "N/A", proveedor2 = "N/A", proveedor3 = "N/A";
    String producto = " ";
    String solicitante = " ";
    String departamento = " ";
    String sucursal = " ";
    String fecha = " ";
    String cActivo = null;
    String cGeneral = null;

    int cantidad = 0, cantidad2 = 0, cantidad3 = 0;
    int precio = 0, precio2 = 0, precio3 = 0;
    int iva = 0, iva2 = 0, iva3 = 0;
    int credito = 0, credito2 = 0, credito3 = 0;
    int entrega = 0, entrega2 = 0, entrega3 = 0;
    int anticipo = 0, anticipo2 = 0, anticipo3 = 0;
    int idCotizacion = 0, idCotizacion2 = 0, idCotizacion3 = 0;
    int status = 0, status2 = 0, status3 = 0;
    int idReqCoti = 0;
    int idCotizacionSeleccionada = 0;
    int precioTotal = 0;
    int nuevoStatus = 0;
    int activo = 0;
    int solicitantes = 0;

    try {
        idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
    } catch (Exception e) {
    }

    ArrayList<CotizacionRequisicion> arrayRequis2 = new ArrayList<CotizacionRequisicion>();
    ArrayList<Integer> idCoti = new ArrayList<Integer>();
    Consultas obj2 = new Consultas();
    arrayRequis2 = obj2.consultarCotizacionesSeleccionadas(idReqCoti);

    for (int i = 0; i < arrayRequis2.size(); i++) {
        try {
            int aux = arrayRequis2.get(i).getIdC();
            idCoti.add(aux);
        } catch (Exception e) {
        }
    }

    ArrayList<CotizacionRequisicion> arrayRequis = new ArrayList<CotizacionRequisicion>();
    Consultas obj = new Consultas();
    Consultas obj3 = new Consultas();

    try {
        solicitantes = obj3.contarSolicitantesCoti(idCoti.get(0));
    } catch (Exception e) {
    }

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
        credito = arrayRequis.get(0).getCredito();
        entrega = arrayRequis.get(0).getEntrega();
        anticipo = arrayRequis.get(0).getAnticipo();
        status = arrayRequis.get(0).getStatus();
        activo = arrayRequis.get(0).getActivo();
    } catch (Exception e) {
    }
    try {
        arrayRequis = obj.consultarCotizaciones(idCoti.get(1));
        idCotizacion2 = arrayRequis.get(0).getIdC();
        proveedor2 = arrayRequis.get(0).getProveedor();
        cantidad2 = arrayRequis.get(0).getCantidad();
        precio2 = arrayRequis.get(0).getPrecio();
        iva2 = arrayRequis.get(0).getIva();
        credito2 = arrayRequis.get(0).getCredito();
        entrega2 = arrayRequis.get(0).getEntrega();
        anticipo2 = arrayRequis.get(0).getAnticipo();
        status2 = arrayRequis.get(0).getStatus();
    } catch (Exception e) {
    }
    try {
        arrayRequis = obj.consultarCotizaciones(idCoti.get(2));
        idCotizacion3 = arrayRequis.get(0).getIdC();
        proveedor3 = arrayRequis.get(0).getProveedor();
        cantidad3 = arrayRequis.get(0).getCantidad();
        precio3 = arrayRequis.get(0).getPrecio();
        iva3 = arrayRequis.get(0).getIva();
        credito3 = arrayRequis.get(0).getCredito();
        entrega3 = arrayRequis.get(0).getEntrega();
        anticipo3 = arrayRequis.get(0).getAnticipo();
        status3 = arrayRequis.get(0).getStatus();
    } catch (Exception e) {
    }

    if (activo == 1) {
        cActivo = "X";
        cGeneral = "&nbsp;";
    } else if (activo == 0) {
        cActivo = "&nbsp;";
        cGeneral = "X";
    }
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Documento sin título</title>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    </head>

    <body>
        <div class="container">
            <div class="card mx-auto w-50">
                <h5 class="card-header">Cotizacion Seleccionada por Compras</h5>
                <div class="card-body" style="text-align: center;">
                    <%
                        //Status 3 para la cotizacion aprobada por el gerente
                        if (status == 3) {
                            idCotizacionSeleccionada = idCotizacion;
                            precioTotal = precio * cantidad + iva;
                    %>
                    <h6><strong>Cotizacion 1</strong></h6>
                    <% } else if (status2 == 3) {
                        idCotizacionSeleccionada = idCotizacion2;
                        precioTotal = precio2 * cantidad2 + iva2;
                    %>
                    <h6><strong>Cotizacion 2</strong></h6>
                    <% } else if (status3 == 3) {
                        idCotizacionSeleccionada = idCotizacion3;
                        precioTotal = precio3 * cantidad3 + iva3;
                    %>
                    <h6><strong>Cotizacion 3</strong></h6>
                    <% }
                        if (precioTotal <= 30000) {
                            nuevoStatus = 10;
                        } else {
                            nuevoStatus = 9;
                        }
                    %>
                    <div class="row">
                        <form action="../actualizaCotizacion.jsp" method="post">
                            <input type="hidden" class="hidden" name="redirecciona" value="1" >
                            <input type="hidden" name="precioTotal" value="<%=precioTotal%>">
                            <input type="hidden" name="cotiSelccionada" value="<%=idCotizacionSeleccionada%>">
                            <input type="hidden" class="hidden" name="nuevoStatusCoti" value="4" >
                            <input type="hidden" class="hidden" name="nuevoStatusRequi" value="<%=nuevoStatus%>" >
                            <button type="submit" class="btn btn-success btn-sm">Aceptar</button>
                        </form>
                        <form action="../actualizaCotizacion.jsp" method="post">
                            <input type="hidden" class="hidden" name="redirecciona" value="1" >
                            <input type="hidden" name="precioTotal" value="<%=precioTotal%>">
                            <input type="hidden" name="cotiSelccionada" value="<%=idCotizacionSeleccionada%>">
                            <input type="hidden" class="hidden" name="nuevoStatusCoti" value="5" >
                            <input type="hidden" class="hidden" name="nuevoStatus" value="14" >
                            <button type="submit" class="btn btn-danger btn-sm">Rechazar</button>
                        </form>
                    </div>
                </div>
            </div>

            <br>
            <br>
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
                        <% if (solicitantes > 1) { %>
                        <td width="30%" style="border-top: hidden">Compras</td>
                        <% } else {%>
                        <td width="30%" style="border-top: hidden"><%=solicitante%></td>
                        <% }%>
                        <td width="25%" style="border: hidden">&nbsp;</td>
                        <td width="15%" style="border: hidden">Compra General</td>
                        <td width="10%" style="border-top: hidden"><%=cGeneral%></td>
                        <td width="10%" style="border: hidden">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="border: hidden">Fecha:</td>
                        <td><%=fecha%></td>
                        <td style="border: hidden">&nbsp;</td>
                        <td style="border: hidden">Activo Fijo</td>
                        <td style=""><%=cActivo%></td>
                        <td style="border: hidden">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="border: hidden">Departamento:</td>
                        <% if (solicitantes > 1) { %>
                        <td>Compras</td>
                        <% } else {%>
                        <td><%=departamento%></td>
                        <% }%>
                        <td style="border: hidden">&nbsp;</td>
                        <td style="border: hidden">&nbsp;</td>
                        <td style="">&nbsp;</td>
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
                        <td><%=precio * cantidad%></td>
                        <td><%=precio2%></td>
                        <td><%=precio2 * cantidad2%></td>
                        <td><%=precio3%></td>
                        <td><%=precio3 * cantidad3%></td>
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
                        <td width="10%">$<%=precio * cantidad%></td>
                        <td width="10%" style="border-top: hidden">&nbsp;</td>
                        <td width="10%">$<%=precio2 * cantidad2%></td>
                        <td width="10%" style="border-top: hidden">&nbsp;</td>
                        <td width="10%">$<%=precio3 * cantidad3%></td>
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
                        <td>$<%=precio * cantidad + iva%></td>
                        <td style="border-top: hidden; border-bottom: hidden">&nbsp;</td>
                        <td>$<%=precio2 * cantidad2 + iva2%></td>
                        <td style="border-top: hidden; border-bottom: hidden">&nbsp;</td>
                        <td>$<%=precio3 * cantidad3 + iva3%></td>
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
                        <td><%=entrega2%></td>
                        <td>&nbsp;</td>
                        <td><%=entrega3%></td>
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
            <table width="100%" style="border-collapse: collapse; font-size: 10px; text-align: center">
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
                        <td>
                            <% if (status == 3 || status2 == 3 || status3 == 3) { %>
                            <i class="fas fa-check"></i>
                            <% }%>
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            Alma Torales
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <br>
            <br>
        </div>
    </body>
</html>
