<%@page import="controller.Mail"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"
         import="java.util.*"
         import="org.apache.commons.fileupload.*"
         import="org.apache.commons.fileupload.servlet.*"
         import="org.apache.commons.fileupload.disk.*"
         import="java.io.*"
         %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Subidor Devtroce</title>
    </head>
    <body>
        <%--
            <form action=insertaArchivo.jsp method=post enctype=multipart/form-data>
                    <table>
                            <tr>
                            <td>Archivo</td>
                            <td><input type=file name=fichero></td>
                            </tr>
                            <tr><td colspan=2><input type=submit value=subir name=enviar>
                            </td>
                            </tr>
                    </table>
            </form>
        --%>

        <form action=pruebas2.jsp method=post>
             <label>Mensaje</label>
            <input type="text" class="form-control" id="mensaje" name="mensaje">
             <label>Correo</label>
            <input type="text" class="form-control" id="mensaje" name="correo" value="luis.martinez@continental.com.mx">
            <input type=submit value=enviar name=enviar>
        </form>

    </body>
</html>