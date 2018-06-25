<%-- 
    Document   : guardarArchivos
    Created on : 9/04/2018, 01:08:53 PM
    Author     : LuisMtz
--%>

<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="java.io.*" %>
<%@ page import ="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    int idReqCoti = 0;
    int banderaGeneral = 0;
    String sql = "";
    int cantidad = 0;
    int credito = 0;
    int entrega = 0;
    int garantia = 0;
    double precio = 0;
    double iva = 0;
    double descuento = 0;
    double anticipo = 0;
    int nuevoStatus = 6;
    int idUsuario = 0;
    int idProducto = 0;
    String sqlM = "";
    HttpSession sesion = request.getSession();
    String validarUsuariosesion = (String) sesion.getAttribute("usuarioIngresado");
    String idUsuariosesion = (String) sesion.getAttribute("idUsuario");
    String prefijo = "Requisicion", extension = "", Ruta = "",ruta ="";
    int idUsuarioIntsesion = Integer.parseInt(idUsuariosesion);
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

        // ----- Variables para for ------//    
        String elemento = "";
        String nombre_archivo = "";
        String nombre_archivo_nuevo = "";
        /*FileItemFactory es una interfaz para crear FileItem*/
        FileItemFactory file_factory = new DiskFileItemFactory();
        /*ServletFileUpload esta clase convierte los input file a FileItem*/
        ServletFileUpload servlet_up = new ServletFileUpload(file_factory);
        /*sacando los FileItem del ServletFileUpload en una lista */
        List items = servlet_up.parseRequest(request);

        for (int i = 0; i < items.size(); i++) {
            /*FileItem representa un archivo en memoria que puede ser pasado al disco duro*/
            FileItem item = (FileItem) items.get(i);
            /*item.isFormField() false=input file; true=text field*/
            if (!item.isFormField()) {
                /*cual sera la ruta al archivo en el servidor*/
              int j = item.getName().lastIndexOf('.');
                if (j >= 0) {
                    extension = item.getName().substring(j + 1);
                }      
                 //Metodo para validar extension
                if (extension.equals("pdf") || extension.equals("")) {
                    banderaGeneral = 1;
                } else {
                    banderaGeneral = 2;   
                System.out.println("Extension no permitida");
                 }    
                 nombre_archivo = item.getName();
        String str = new String(nombre_archivo);
        int longitudCadena = str.length();
        nombre_archivo_nuevo = str.substring(0, longitudCadena - 4);
        File archivo_server = new File("C:/compras/COT_"+nombre_archivo_nuevo +"." +  extension);
        Ruta = "C:/compras/COT_"+nombre_archivo_nuevo+"." +  extension;
        try {
            if (banderaGeneral == 1) {
                item.write(archivo_server);
            }
            /*y lo escribimos en el servido*/
        } catch (Exception e) {
            banderaGeneral = 1;   
            System.out.println("Ocurrio un error al guardar el archivo" + e);
                }
            } else {

                //Comienzo metodo para obtener ids y mandarlos a la insercion de Resumen//
                elemento = item.getFieldName();

                try {
                    if (elemento.equals("cantidad")) {
                        cantidad = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento int cantidad" + cantidad);
                }

                try {
                    if (elemento.equals("credito")) {
                        credito = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento int credito" + credito);
                }

                try {
                    if (elemento.equals("entrega")) {
                        entrega = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento int entrega" + entrega);
                }

                try {
                    if (elemento.equals("garantia")) {
                        garantia = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento int garantia" + garantia);
                }

                try {
                    if (elemento.equals("precio")) {
                        precio = Double.parseDouble(item.getString()) ;
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento Double precio" + precio);
                }
                try {
                        iva = precio * 0.16;
                    } catch (Exception e) {
                    }

                try {
                    if (elemento.equals("descuento")) {
                        descuento = Double.parseDouble(item.getString());
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento Double descuento" + descuento);
                }

                try {
                    if (elemento.equals("idUsuario")) {
                        idUsuario = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento int idUsuario" + idUsuario);
                }

                try {
                    if (elemento.equals("idReqCoti")) {
                        idReqCoti = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento String idReqCoti" + idReqCoti);
                }

                try {
                    if (elemento.equals("idProducto")) {
                        idProducto = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                    System.out.println("No recibi valor de elemento int idProducto" + idProducto);
                }
                
            }
        }

    
    
    
    // --- Inserta Cotización ---
    sql = "Insert into cotizacion (id_req_coti, id_proveedor, id_producto, cantidad, precio, iva, diascredito, tiempoentrega, descuento, anticipo, garantia, rutaPDF) values "
          + "("+idReqCoti+", "+idUsuario+", "+idProducto+", "+cantidad+","+precio+", "+iva+", "+credito+", "+entrega+", "+descuento+", "+anticipo+","+garantia+",'"+Ruta+"')";
    st.executeUpdate(sql); 
    // --- Actualiza estatus ---
    st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " where id_req_coti = "+ idReqCoti +"");
    // --- Inserta Precio Producto --
    st.executeUpdate("call insertaPrecios('"+idProducto+"','"+idUsuario+"','"+precio+",'"+credito+"','"+entrega+"','"+garantia+"','"+descuento+"','"+anticipo+"')");
    /*
    sqlM = "Insert into scompras.multimedia (id_coti,id_proveedor,ruta) values ("+idReqCoti+","+idUsuario+",'"+Ruta+"');";
    st.executeUpdate(sqlM);
    */
    response.sendRedirect("menuRequisicionesProveedor.jsp"); 

%>

