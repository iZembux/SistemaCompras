<%-- 
    Document   : subirFactura
    Created on : 22/05/2018, 12:22:18 PM
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
    int idRequi = 0;
    String sql = "";
    String sqlM = "";
    HttpSession sesion = request.getSession();
    String caracteristicas = "";
    String validarUsuariosesion = (String) sesion.getAttribute("usuarioIngresado");
    String idUsuariosesion = (String) sesion.getAttribute("idUsuario");
    String prefijo = "Requisicion", extension = "", Ruta = "", ruta = "";
    int idUsuarioIntsesion = Integer.parseInt(idUsuariosesion);
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;
    RequestDispatcher dispatcher;

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
            File archivo_server = new File("C:/compras/DICTAMEN/DTI_" + nombre_archivo_nuevo + "." + extension);
            Ruta = "C:/compras/DICTAMEN/DTI_" + nombre_archivo_nuevo + "." + extension;
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
                if (elemento.equals("idReqP")) {
                    idRequi = Integer.parseInt(item.getString());
                }
            } catch (Exception e) {
                System.out.println("No recibi valor de elemento int cantidad" + idRequi);
            }
            
            try {
                if (elemento.equals("datosProducto")) {
                    caracteristicas = item.getString();
                }
            } catch (Exception e) {
                System.out.println("No recibi valor de elemento string caracteristicas" + idRequi);
            }
        }
    }

    String sqlDictamen
            = "INSERT INTO "
            + "scompras.dictamenes(id_req_prod,id_usuario_dictamina,ruta_dictamen,ruta_caratula,caracteristicas) "
            + "VALUES ("
            + idRequi + ","
            + idUsuarioIntsesion + ", "
            + "'" + Ruta + "',"
            + "(select rutaCaratula from scompras.req_prod where id_req_prod = " + idRequi + "), "
            + "'" + caracteristicas + "');";
    Statement st1 = con.createStatement();
    st1.executeUpdate(sqlDictamen);
    System.out.println("ID Requi: " + idRequi);
    sql = "UPDATE scompras.req_prod SET rutaDictamen = '" + Ruta + "' WHERE id_req_prod = '" + idRequi + "';";
    st.executeUpdate(sql);
    response.sendRedirect("menuDictamen.jsp");

%>
