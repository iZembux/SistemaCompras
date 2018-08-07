<%-- 
    Document   : registration
    Created on : Feb 28, 2018, 9:14:05 AM
    Author     : Diego
--%>

<%@page import="model.Sucursales"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Departamentos"%>
<%@page import="model.Categorias"%>
<%@page import="controller.ConsultaBase"%>
<%@ page import ="java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    ConsultaBase obConsulta = new ConsultaBase();
    ArrayList<Categorias> categorias = new ArrayList<Categorias>();
    ArrayList<Departamentos> departamentos = new ArrayList<Departamentos>();
    ArrayList<Sucursales> sucursales = new ArrayList<Sucursales>();
    
    /*=====================================      ==================================*/
    categorias = obConsulta.obtieneCategorias();
    departamentos = obConsulta.obtieneDepartamentos();
    sucursales = obConsulta.obtieneSucursales();
    
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Regístrate</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
        <link rel="stylesheet" href="css/signup.css">
    </head>
    <body>
        <!-- multistep form -->
        <form id="msform" action="SignUp" method="post" onKeypress="if(event.keyCode == 13) event.returnValue = false;">
            <!-- progressbar -->
            <ul id="progressbar">
                <li class="active">Datos de Cuenta</li>
                <li>Datos del Área</li>
                <li>Datos Personales</li>
            </ul>
            <!-- fieldsets -->
            <fieldset id="uno">
                <h2 class="fs-title">Crea tu cuenta</h2>
                <h3 class="fs-subtitle">Llena los campos</h3>
                <input type="text" required="required" name="usuario" placeholder="Usuario" />
                <input type="password" required="required" name="pass" id="pass" placeholder="Contraseña" />
                <input type="password" required="required" name="cpass" id="cpass" placeholder="Confirma Contraseña"/>
                <input type="button" name="next" class="next action-button" value="Siguiente" onclick="return(validarPassword()); MM_validateForm()"  />
            </fieldset>
            <fieldset>
                <h2 class="fs-title">Datos del Área</h2>
                <h3 class="fs-subtitle">Selecciona una opción</h3>
                <select id="sucursal" class="form-control" data-placeholder="Selecciona una Sucursal" required="required" name="sucursal">
                    <%
                        for (Sucursales sucursal : sucursales) {
                            String nsucursal = sucursal.getSucursal().toString();
                    %>
                    <option value='<%=sucursal.getId_sucursales()%>'><%=nsucursal%></option>
                    <%
                        }
                    %>
                </select>
                <br />
                <select id="sucursal" class="form-control" data-placeholder="Selecciona un Departamento" required="required" name="departamento">
                     <%
                        for (Departamentos dpt : departamentos) {
                            String dpto = dpt.getDepartamento().toString();
                    %>
                    <option value='<%=dpt.getId_departamentos()%>'><%=dpto%></option>
                    <%
                        }
                    %>
                </select>
                <br />
                <input type="button" name="previous" class="previous action-button" value="Anterior" />
                <input type="button" name="next" class="next action-button" value="Siguiente" />
            </fieldset>
            <fieldset>
                <h2 class="fs-title">Datos Personales</h2>
                <h3 class="fs-subtitle">Llena los campos</h3>
                <input type="text" name="nombre" placeholder="Nombre" />
                <input type="text" name="apellido" placeholder="Apellido Paterno" />
                <input type="text" name="apellidoM" placeholder="Apellido Materno" />
                <input type="text" name="email" placeholder="Correo Electronico" />
                <input type="button" name="previous" class="previous action-button" value="Anterior" />
                <input type="submit" name="submit" class="submit action-button" value="Enviar"/>
            </fieldset>
        </form>
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js'></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script  src="js/signup.js" charset="UTF-8"></script>
    </body>
    
</html>
