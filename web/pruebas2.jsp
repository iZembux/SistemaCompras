<%@page import="controller.Mail"%>
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
    String mensaje = null;
    String correo = null;
    Mail objMail = new Mail();

    try {
        mensaje = request.getParameter("mensaje");
    } catch (Exception e) {
        System.out.println("Ho se ha recibido mensaje");
    }
    try {
        correo = request.getParameter("correo");
    } catch (Exception e) {
        System.out.println("Ho se ha recibido mensaje");
    }

    System.out.println(mensaje);
    
    Stack<Character> pila = new Stack<Character>();
    for (int x = 0; x < mensaje.length(); x++) {
        pila.add(mensaje.charAt(x));
    }

    for (int i = pila.size()-1; i > -1; i--) {
        objMail.enviarCorreo2(correo, pila.get(i).toString());
    }

%>
