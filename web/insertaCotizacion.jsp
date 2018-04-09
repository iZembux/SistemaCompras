<%-- 
    Document   : registration
    Created on : Feb 28, 2018, 9:14:05 AM
    Author     : user
--%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@ page import ="java.sql.*" %>
<%
    int cantidad = 0;
    int credito = 0;
    int entrega = 0;
    int garantia = 0;
    double precio = 0;
    double iva = 0;
    double descuento = 0;
    double anticipo = 0;
    int idReqCoti = 0;
    int nuevoStatus = 6;
    int idUsuario = 0;
    int idProducto = 0;
    
    try {
        cantidad = Integer.parseInt(request.getParameter("cantidad"));
    } catch (Exception e) {
    }
    try {
        credito = Integer.parseInt(request.getParameter("credito"));
    } catch (Exception e) {
    }
    try {
        entrega = Integer.parseInt(request.getParameter("entrega"));
    } catch (Exception e) {
    }
     try {
        garantia = Integer.parseInt(request.getParameter("garantia"));
    } catch (Exception e) {
    }
    try {
        precio = Double.parseDouble(request.getParameter("precio")); 
    } catch (Exception e) {
    }
    try {
        iva = precio * 0.16; 
    } catch (Exception e) {
    }
    try {
        descuento = Double.parseDouble(request.getParameter("descuento")); 
    } catch (Exception e) {
    }
    try {
        anticipo = Double.parseDouble(request.getParameter("anticipo")); 
    } catch (Exception e) {
    }
    
    try {
        idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
    } catch (Exception e) {
    }

    try {
        idReqCoti = Integer.parseInt(request.getParameter("idReqCoti"));
    } catch (Exception e) {
    }
    
    try {
        idProducto = Integer.parseInt(request.getParameter("idProducto"));
    } catch (Exception e) {
    }
    /*FileItemFactory es una interfaz para crear FileItem*/
        FileItemFactory file_factory = new DiskFileItemFactory();
 
        /*ServletFileUpload esta clase convierte los input file a FileItem*/
        ServletFileUpload servlet_up = new ServletFileUpload(file_factory);
        /*sacando los FileItem del ServletFileUpload en una lista */
        List items = servlet_up.parseRequest(request);
 
        for(int i=0;i<items.size();i++){
            /*FileItem representa un archivo en memoria que puede ser pasado al disco duro*/
            FileItem item = (FileItem) items.get(i);
            /*item.isFormField() false=input file; true=text field*/
            if (! item.isFormField()){
                /*cual sera la ruta al archivo en el servidor*/
                File archivo_server = new File("c:/subidos/"+idUsuario+"_Archivo_"+item.getName());
                /*y lo escribimos en el servido*/
                item.write(archivo_server);
            }
        }
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

    st.executeUpdate("UPDATE req_prod SET id_status = " + nuevoStatus + " where id_req_coti = "+ idReqCoti +"");
    
    st.executeUpdate("Insert into cotizacion (id_req_coti, id_proveedor, id_producto, cantidad, precio, iva, diascredito, tiempoentrega, descuento, anticipo, garantia) values "
            + "("+idReqCoti+", "+idUsuario+", "+idProducto+", "+cantidad+","+precio+", "+iva+", "+credito+", "+entrega+", "+descuento+", "+anticipo+","+garantia+")"); 
    response.sendRedirect("menuRequisicionesProveedor.jsp"); 

%>
