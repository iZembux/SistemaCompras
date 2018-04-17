<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="application/pdf; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import= "java.io.*" %>
    <%
//CODIGO JSP 
        String documento = request.getParameter("search");

        FileInputStream ficheroInput = new FileInputStream("" + documento + "");
        int tamanoInput = ficheroInput.available();
        byte[] datosPDF = new byte[tamanoInput];
        ficheroInput.read(datosPDF, 0, tamanoInput);

        response.setHeader("Content-disposition", "inline; filename=instalacion_tomcat.pdf");
        response.setContentType("application/pdf");
        response.setContentLength(tamanoInput);
        response.getOutputStream().write(datosPDF);
        ficheroInput.close();
    %>
