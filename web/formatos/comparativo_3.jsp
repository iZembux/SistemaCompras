<%-- 
    Document   : comparativo
    Created on : 16-mar-2018, 11:46:08
    Author     : JefeDesarrollo
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="model.Comparativo"%>
<%@page import="model.RequisicionFormato"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="controller.Consultas"%>
<%@page import="model.CotizacionRequisicion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int cuadro = 0;
    int idReqProd = 0;

    String proveedor = "N/A", proveedor2 = "N/A", proveedor3 = "N/A";
    String producto = " ";
    String solicitante = " ";
    String departamento = " ";
    String sucursal = " ";
    String fecha = " ";
    String cActivo = null;
    String cGeneral = null;
    String observaciones = " ";
    String unidadMedida = "";

    int cantidad = 0, cantidad2 = 0, cantidad3 = 0;
    double precio = 0, precio2 = 0, precio3 = 0;
    double iva = 0, iva2 = 0, iva3 = 0;
    double total = 0, total2 = 0, total3 = 0;
    int credito = 0, credito2 = 0, credito3 = 0;
    int entrega = 0, entrega2 = 0, entrega3 = 0;
    int anticipo = 0, anticipo2 = 0, anticipo3 = 0;
    int garantia = 0, garantia2 = 0, garantia3 = 0;
    int activo = 0;
    int solicitantes = 0;
    int idUsu = 0;
    int idGanadora = 0;
    int idCuadro = 0;

    ArrayList<Integer> idCoti = new ArrayList<Integer>();
    ArrayList<Integer> idRP = new ArrayList<Integer>();
    ArrayList<Comparativo> lista1 = new ArrayList<Comparativo>();
    ArrayList<Comparativo> lista2 = new ArrayList<Comparativo>();
    ArrayList<Comparativo> lista3 = new ArrayList<Comparativo>();

    ArrayList<Comparativo> lista4 = new ArrayList<Comparativo>();

    ArrayList<CotizacionRequisicion> cotizaciones = new ArrayList<CotizacionRequisicion>();
    Consultas obj = new Consultas();

    cuadro = Integer.parseInt(request.getParameter("cuadro"));
    idReqProd = Integer.parseInt(request.getParameter("idReqProd"));

    ArrayList<Integer> req = new ArrayList<Integer>();

    System.out.println("-----------GENERACION DE CUADRO COMPARATIVO-----------------");

    cotizaciones = obj.consultarCotizacionesCuadroAdmin(9, cuadro);
    if (cotizaciones.size() > 0) {
        departamento = cotizaciones.get(0).getDepto();
        sucursal = cotizaciones.get(0).getSucursal();
        fecha = cotizaciones.get(0).getFecha();
        activo = cotizaciones.get(0).getActivo();
        proveedor = cotizaciones.get(0).getProveedor();
        idGanadora = cotizaciones.get(0).getIdGanadora();

        Comparativo obj4 = new Comparativo();
        obj4.setCantidad(cotizaciones.get(0).getCantidad());
        obj4.setProducto(cotizaciones.get(0).getProducto());
        System.out.println("Articulo: " + cotizaciones.get(0).getProducto());

        lista4.add(obj4);

        Comparativo obj1 = new Comparativo();
        obj1.setIdCotizacion(cotizaciones.get(0).getIdC());
        System.out.println("Cotizacion 1: " + cotizaciones.get(0).getIdC());
        idCoti.add(cotizaciones.get(0).getIdC());

        obj1.setCantidad(cotizaciones.get(0).getCantidad());
        credito = (cotizaciones.get(0).getCredito());
        entrega = (entrega = cotizaciones.get(0).getEntrega());
        anticipo = (cotizaciones.get(0).getAnticipo());
        garantia = (cotizaciones.get(0).getGarantia());
        obj1.setPrecio(cotizaciones.get(0).getPrecio());

        iva += cotizaciones.get(0).getIva();
        obj1.setIva(iva);
        total += ((cotizaciones.get(0).getPrecio()) * cotizaciones.get(0).getCantidad());
        obj1.setTotal(total);

        lista1.add(obj1);
        if (cotizaciones.size() >= 2) {
            proveedor2 = cotizaciones.get(1).getProveedor();
            cantidad2 = cotizaciones.get(1).getCantidad();

            Comparativo obj2 = new Comparativo();
            obj2.setIdCotizacion(cotizaciones.get(1).getIdC());
            System.out.println("Cotizacion 2: " + cotizaciones.get(1).getIdC());
            idCoti.add(cotizaciones.get(1).getIdC());

            obj2.setCantidad(cotizaciones.get(1).getCantidad());
            credito2 = (cotizaciones.get(1).getCredito());
            entrega2 = (entrega = cotizaciones.get(1).getEntrega());
            anticipo2 = (cotizaciones.get(1).getAnticipo());
            garantia2 = (cotizaciones.get(1).getGarantia());
            obj2.setPrecio(cotizaciones.get(1).getPrecio());
            iva2 += cotizaciones.get(1).getIva();
            obj2.setIva(iva2);
            total2 += ((cotizaciones.get(1).getPrecio()) * cotizaciones.get(1).getCantidad());
            obj2.setTotal(total2);
            lista2.add(obj2);
        }
        if (cotizaciones.size() == 3) {
            proveedor3 = cotizaciones.get(2).getProveedor();
            cantidad3 = cotizaciones.get(2).getCantidad();

            Comparativo obj3 = new Comparativo();
            obj3.setIdCotizacion(cotizaciones.get(2).getIdC());
            System.out.println("Cotizacion 3: " + cotizaciones.get(2).getIdC());
            idCoti.add(cotizaciones.get(2).getIdC());

            obj3.setCantidad(cotizaciones.get(2).getCantidad());
            credito3 = (cotizaciones.get(2).getCredito());
            entrega3 = (entrega = cotizaciones.get(2).getEntrega());
            anticipo3 = (cotizaciones.get(2).getAnticipo());
            garantia3 = (cotizaciones.get(2).getGarantia());
            obj3.setPrecio(cotizaciones.get(2).getPrecio());
            iva3 += cotizaciones.get(2).getIva();
            obj3.setIva(iva3);
            total3 += ((cotizaciones.get(2).getPrecio()) * cotizaciones.get(2).getCantidad());
            obj3.setTotal(total3);
            lista3.add(obj3);
        }
    }

    Consultas obj2 = new Consultas();
    try {
        observaciones = request.getParameter("observaciones");
    } catch (Exception e) {
    }
    try {
        solicitantes = obj2.contarSolicitantesCoti(idCoti.get(0));
        if(solicitantes == 1) {
            solicitante = obj.consultaSolicitante(idReqProd);
        }
    } catch (Exception e) { }
    
    try {
        unidadMedida = obj.consultaUnidadMedida(idReqProd);
    } catch (Exception e) { }
    
    try {
        idUsu = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }

    if (activo == 1) {
        cActivo = "X";
        cGeneral = "&nbsp;";
    } else if (activo == 0) {
        cActivo = "&nbsp;";
        cGeneral = "X";
    }

    int provGanador = obj.consultarProveedorGanador(idGanadora);
    String nombreProveedor = obj.consultarNombreProveedor(provGanador);

    boolean uno = false;
    boolean dos = false;
    boolean tres = false;
    System.out.println("Cotizacion propuesta " + idGanadora);
    for (int i = 0; i < lista1.size(); i++) {
        if (lista1.get(i).getIdCotizacion() == idGanadora) {
            uno = true;
            break;
        } else if (lista2.get(i).getIdCotizacion() == idGanadora) {
            dos = true;
            break;
        } else if (lista3.get(i).getIdCotizacion() == idGanadora) {
            tres = true;
            break;
        }
    }
    DecimalFormat formateador = new DecimalFormat("###,###,###.##");
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Cuadro Comparativo</title>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
        <script>
            function imprimeDiv(nombreDiv) {
                var contenido = document.getElementById(nombreDiv).innerHTML;
                var contenidoOriginal = document.body.innerHTML;

                document.body.innerHTML = contenido;

                window.print();

                document.body.innerHTML = contenidoOriginal;
            }
        </script>
    </head>

    <body>
        <div class="container">
            <div class="card mx-auto w-50">
                <h5 class="card-header">Cotizacion aprobada por Compras:</h5>
                <div class="card-body" style="text-align: center;">
                    <form action="../actualizaCotizacionCompras_3.jsp" method="post">
                        <div>
                            <label><h4><%=nombreProveedor%></h4></label>
                        </div>
                        <hr>
                        <div class="form-check form-check-inline">
                            <%if (uno) {%>
                            <input class="form-check-input" type="radio" name="sel" id="exampleRadios1" value="1" required="true" checked="true">
                            <%} else {%>
                            <input class="form-check-input" type="radio" name="sel" id="exampleRadios1" value="1" required="true"> 
                            <% }
                                for (int i = 0; i < lista1.size(); i++) {%>
                            <input type="hidden" class="hidden" name="cotiSelccionada1<%=i%>" value="<%=lista1.get(i).getIdCotizacion()%>" >
                            <% } %>
                            <label class="form-check-label" for="exampleRadios1">
                                Cotizacion 1
                            </label>
                        </div>
                        <div class="form-check form-check-inline">
                            <%if (dos) {%>
                            <input class="form-check-input" type="radio" name="sel" id="exampleRadios1" value="2" required="true" checked="true"> 
                            <%} else {%>
                            <input class="form-check-input" type="radio" name="sel" id="exampleRadios1" value="2" required="true"> 
                            <%}
                                for (int i = 0; i < lista2.size(); i++) {%>
                            <input type="hidden" class="hidden" name="cotiSelccionada2<%=i%>" value="<%=lista2.get(i).getIdCotizacion()%>" >
                            <% } %>
                            <label class="form-check-label" for="exampleRadios2">
                                Cotizacion 2
                            </label>
                        </div>
                        <div class="form-check form-check-inline">
                            <%if (tres) {%>
                            <input class="form-check-input" type="radio" name="sel" id="exampleRadios1" value="3" required="true" checked="true"> 
                            <%} else {%>
                            <input class="form-check-input" type="radio" name="sel" id="exampleRadios1" value="3" required="true"> 
                            <% }
                                for (int i = 0; i < lista3.size(); i++) {%>
                            <input type="hidden" class="hidden" name="cotiSelccionada3<%=i%>" value="<%=lista3.get(i).getIdCotizacion()%>" >
                            <% } %>
                            <label class="form-check-label" for="exampleRadios3">
                                Cotizacion 3
                            </label>
                        </div>
                        <% for (int i = 0; i < idRP.size(); i++) {%>
                        <input type="hidden" class="hidden" name="idRP<%=i%>" value="<%=idRP.get(i)%>" >
                        <% }%>
                        <% for (int i = 0; i < idCoti.size(); i++) {%>
                        <input type="hidden" class="hidden" name="idCoti<%=i%>" value="<%=idCoti.get(i)%>" >
                        <% }%>
                        <input type="hidden" class="hidden" name="tam2" value="<%=idCoti.size()%>">
                        <input type="hidden" class="hidden" name="tamano" value="<%=lista1.size()%>">
                        <input type="hidden" class="hidden" name="nuevoStatusCoti" value="2" >
                        <input type="hidden" class="hidden" name="nuevoStatusRequi" value="19" >
                        <input type="hidden" class="hidden" name="idUsu" value="<%=idUsu%>" >
                        <input type="hidden" class="hidden" name="idCuadro" value="<%=cuadro%>" >
                        <br/>
                        <br/>
                        <button type="submit" class="btn btn-success btn-sm">Aceptar o Modificar Proveedor</button>
                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#modalCancela" onclick="abre()">Rechazar</button>
                    </form>
                </div>
            </div>
        </div>
        <br>
        <br>
        <div class="container" id="imp">
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
                        <td><%=departamento.toUpperCase()%></td>
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
                    <% for (int j = 0; j < lista4.size(); j++) {%>
                    <tr height="50px">
                        <td><%=lista4.get(j).getCantidad()%></td>
                        <td><%=unidadMedida%></td>
                        <td><%=lista4.get(j).getProducto()%></td>
                        <td><%=lista1.get(j).getPrecio()%></td>
                        <td><%=lista1.get(j).getPrecio() * lista1.get(j).getCantidad()%></td>
                        <% if (lista2.size() > 0) {%>
                        <td><%=lista2.get(j).getPrecio()%></td>
                        <td><%=lista2.get(j).getPrecio() * lista2.get(j).getCantidad()%></td>
                        <% } else { %>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <% } %>
                        <% if (lista3.size() > 0) {%>
                        <td><%=lista3.get(j).getPrecio()%></td>
                        <td><%=lista3.get(j).getPrecio() * lista3.get(j).getCantidad()%></td>
                        <% } else { %>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <% } %>
                    </tr>
                    <% }%>
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
                        <td width="10%">$<%=formateador.format(total)%></td>
                        <td width="10%" style="border-top: hidden">&nbsp;</td>
                        <td width="10%">$<%=formateador.format(total2)%></td>
                        <td width="10%" style="border-top: hidden">&nbsp;</td>
                        <td width="10%">$<%=formateador.format(total3)%></td>
                    </tr>
                    <tr>
                        <td style="border-left: hidden; border-top: hidden">&nbsp;</td>
                        <td>IVA</td>
                        <td style="border-top: hidden">&nbsp;</td>
                        <td>$<%=formateador.format(iva)%></td>
                        <td style="border-top: hidden">&nbsp;</td>
                        <td>$<%=formateador.format(iva2)%></td>
                        <td style="border-top: hidden">&nbsp;</td>
                        <td>$<%=formateador.format(iva3)%></td>
                    </tr>
                    <tr>
                        <td style="border-left: hidden; border-top: hidden; border-bottom: hidden">&nbsp;</td>
                        <td>TOTAL EN PESOS</td>
                        <td style="border-top: hidden; border-bottom: hidden">&nbsp;</td>
                        <td>$<%=formateador.format(total + iva)%></td>
                        <td style="border-top: hidden; border-bottom: hidden">&nbsp;</td>
                        <td>$<%=formateador.format(total2 + iva2)%></td>
                        <td style="border-top: hidden; border-bottom: hidden">&nbsp;</td>
                        <td>$<%=formateador.format(total3 + iva3)%></td>
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
                        <td width="10%"><%=credito%> Dias</td>
                        <td width="10%">&nbsp;</td>
                        <td width="10%"><%=credito2%> Dias</td>
                        <td width="10%">&nbsp;</td>
                        <td width="10%"><%=credito3%> Dias</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td style="text-align: left">TIEMPO DE ENTREGA</td>
                        <td>&nbsp;</td>
                        <td><%=entrega%> Dias</td>
                        <td>&nbsp;</td>
                        <td><%=entrega2%> Dias</td>
                        <td>&nbsp;</td>
                        <td><%=entrega3%> Dias</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td style="text-align: left">GARANTIA</td>
                        <td>&nbsp;</td>
                        <td><%=garantia%> Dias</td>
                        <td>&nbsp;</td>
                        <td><%=garantia2%> Dias</td>
                        <td>&nbsp;</td>
                        <td><%=garantia3%> Dias</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td style="text-align: left">ANTICIPO</td>
                        <td>&nbsp;</td>
                        <td><%=anticipo%> %</td>
                        <td>&nbsp;</td>
                        <td><%=anticipo2%> %</td>
                        <td>&nbsp;</td>
                        <td><%=anticipo3%> %</td>
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
                        <td><%= observaciones%></td>
                    </tr>
                </tbody>
            </table>
            <br>
            <br>
           
        </div>
        <br>
        <br>
        <form> 
            <input style="Position:Absolute; left:83%; top:18%; color: #17202A; background-color: #D7DBDD; width:75px; height: 30px; font-size: 12pt;" type='button' onclick='imprimeDiv("imp")' value='Imprimir'  class="oculto"/> 
        </form> 
        <!-- Modal Cancela Cuadro -->
        <div class="modal fade" id="modalCancela" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Agregar Comentarios</h4>
                        <button type="button" class="close" data-dismiss="modal">×</button>
                    </div>
                    <div class="modal-body form-control">                        
                        <form name="cancelaComparativo" action="../rechazaComparativo.jsp" method="POST">
                            <input type="hidden" class="hidden" name="idCuadroCancela" id="idCuadroCancela" value="<%=cuadro%>" >
                            <label for="comentariosCancela">Motivo de la cancelación</label>
                            <textarea class="form-control" rows="6" id="datosProducto" name="comentarioCancela" required="true" style="resize: none;"></textarea>
                            <br>
                            <center><input type="submit" class="btn btn-alet" value="RECHAZAR"/></center>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script type="text/javascript">
            function abre() {
                $('#modalCancela').modal({show: true});
            }
        </script>
    </body>
    <%
        System.out.println("------------------------------------------------------------");
    %>
</html>
