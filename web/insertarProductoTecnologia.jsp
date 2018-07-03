<%-- 
    Document   : guardarArchivos
    Created on : 9/04/2018, 01:08:53 PM
    Author     : LuisMtz
--%>

<%@page import="controller.Mail"%>
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
    int nuevaRequisicion = 1;
    int idUsuario = 0;
    int idRequisicion = 0;
    int idCotizacion = 0;
    int idStatus = 3;
    int idProducto = 0;
    int cantidad = 0;
    int idDepto = 0;
    int activo = 1;
    int sucursal = 0;
    String descripcion = null;
    String justificacion = null;
    String sqlM = "";

    HttpSession sesion = request.getSession();
    String validarUsuariosesion = (String) sesion.getAttribute("usuarioIngresado");
    String idUsuariosesion = (String) sesion.getAttribute("idUsuario");
    String prefijo = "Requisicion", extension = "", Ruta = "", ruta = "";
    int idUsuarioIntsesion = Integer.parseInt(idUsuariosesion);
    Mail objMail = new Mail();

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
            try{
            nombre_archivo = item.getName();
            String str = new String(nombre_archivo);
            int longitudCadena = str.length();
            nombre_archivo_nuevo = str.substring(0, longitudCadena - 4);
            
            File archivo_server = new File("C:/compras/CARATULAS/CARATULA_" + nombre_archivo_nuevo + "." + extension);
            Ruta = "C:/compras/CARATULAS/CARATULA_" + nombre_archivo_nuevo + "." + extension;
            
            try {
                if (banderaGeneral == 1) {
                    item.write(archivo_server);
                }
                /*y lo escribimos en el servido*/
            } catch (Exception e) {
                banderaGeneral = 1;
                System.out.println("Ocurrio un error al guardar el archivo" + e);
            }
            }catch(Exception e){
                System.out.println("Sin Archivo PDF");
            }
        } else {

            //Comienzo metodo para obtener ids y mandarlos a la insercion de Resumen//
            elemento = item.getFieldName();

            try {
                    if (elemento.equals("idUsuario")) {
                        idUsuario = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("idStatus")) {
                        idStatus = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("modelo")) {
                        idProducto = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("cantidad")) {
                        cantidad = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("descripcion")) {
                        descripcion = item.getString();
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("justificacion")) {
                        justificacion = item.getString();
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("nuevaRequisicion")) {
                        nuevaRequisicion = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("idDepto")) {
                        idDepto = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("activo")) {
                        activo = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                }
            try {
                    if (elemento.equals("sucursal")) {
                        sucursal = Integer.parseInt(item.getString());
                    }
                } catch (Exception e) {
                }

        }
    }
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    PreparedStatement ps;

    //Pregunta si es una requisicion nueva (1) o si es continuacion de otra (0)
    if (nuevaRequisicion == 1) {
        st.executeUpdate("insert into requisiciones(id_requisicion, id_usuario, fecha) "
                + "values ('" + idRequisicion + "','" + idUsuario + "',CURRENT_TIMESTAMP)");

        //Envia correo al gerente del area
        sql = "SELECT correo, nombre, apellido FROM scompras.usuario where id_rol = 3 and id_departamento = " + idDepto + " and id_sucursal = " + sucursal + ";";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        if (rs.next()) {
            String correo = rs.getString("correo");
            String nombre = rs.getString("nombre");
            String apellido = rs.getString("apellido");
            objMail.enviarCorreo(correo, nombre, apellido, "Tiene una nueva requisicion por revisar");
        }

    }

    rs = st.executeQuery("SELECT  max(id_requisicion) as id from requisiciones where id_usuario = " + idUsuario + ";");
    if (rs.next()) {
        idRequisicion = rs.getInt("id");
    }

    //Inserta el producto en la ultima requisicion creada
    int i = st.executeUpdate("insert into req_prod(id_requisicion, id_producto, id_req_coti, id_status, cantidad, descripcion, justificacion, activo_fijo, rutaCaratula) "
            + "values ('" + idRequisicion + "','" + idProducto + "','" + idCotizacion + "','" + idStatus + "','" + cantidad + "','" + descripcion + "','" + justificacion + "','" + activo +  "','" + Ruta + "')");
    if (i > 0) {
        response.sendRedirect("insertaProductoContinuacion.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%>