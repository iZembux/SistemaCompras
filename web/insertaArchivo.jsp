<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.*"
    import="org.apache.commons.fileupload.*"
    import="org.apache.commons.fileupload.servlet.*"
    import="org.apache.commons.fileupload.disk.*"
    import="java.io.*"
%>

<%
    //Ruta donde se guardara el fichero
    String ruta = "C:\\Compras\\";
    File destino = new File(ruta);
    ServletRequestContext src = new ServletRequestContext(request);

    if (ServletFileUpload.isMultipartContent(src)) {
        DiskFileItemFactory factory = new DiskFileItemFactory((1024 * 1024), destino);
        ServletFileUpload upload = new ServletFileUpload(factory);

        java.util.List lista = upload.parseRequest(src);
        File file = null;
        java.util.Iterator it = lista.iterator();

        while (it.hasNext()) {
            FileItem item = (FileItem) it.next();
            if (item.isFormField()) {
                out.println(item.getFieldName() + "<br>");
            } else {
                
                file = new File(item.getName());
                String nombre = file.getName();
                item.write(new File(destino, nombre));
                out.println(nombre);
            }
        }
    }
%>
