<%-- 
    Document   : registration
    Created on : Feb 28, 2018, 9:14:05 AM
    Author     : Diego
--%>

<%@ page import ="java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

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
        <form id="msform" action="SignUp" method="post">
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
                <script>
                    function validarPassword() {
                        var espacios = false;
                        var cont = 0;
 
                       
                        var p1 = document.getElementById("pass").value;
                        var p2 = document.getElementById("cpass").value;
                        if (p1.length == 0 || p2.length == 0) {
                            alert("OLVIDASTE INGRESAR UNA CONTRASEÑA");
                            return false;
                        }
                        if (p1 != p2) {
                            alert("HEY!! TUS CONTRASEÑAS NO COINCIDEN");
                            return false;
                        } 
                    }
                </script>
                <input type="button" name="next" class="next action-button" value="Siguiente" onclick="return(validarPassword()); MM_validateForm()"  />
            </fieldset>
            <fieldset>
                <h2 class="fs-title">Datos del Área</h2>
                <h3 class="fs-subtitle">Selecciona una opción</h3>
                <select id="sucursal" class="form-control" data-placeholder="Selecciona una Sucursal" required="required" name="sucursal">
                    <optgroup label="--- CONTINENTAL ---">
                        <option value="1">CONTINENTAL METEPEC</option>
                        <option value="2">CONTINENTAL LERMA</option>
                        <option value="3">CONTINENTAL TENANCINGO</option>
                        <option value="4">CONTINENTAL ATLACOMULCO</option>
                    </optgroup>
                    <optgroup label="--- FIAT ---"> 
                        <option value="5">CONTINENTAL METEPEC</option>
                    </optgroup>
                    <optgroup label="--- MITSUBISHI ---">
                        <option value="6">MITSUBISHI METEPEC</option> 
                    </optgroup>
                    <optgroup label="--- HYUNDAI ---">
                        <option value="7">HYUNDAI METEPEC</option>
                        <option value="8">HYUNDAI PATRIOTISMO</option>
                        <option value="9">HYUNDAI SANTA FE</option>
                    </optgroup>
                    <optgroup label="--- SAN RAFAEL ---">
                        <option value="10">SAN RAFAEL</option>
                    </optgroup>
                    <optgroup label="--- AUTOPOLANCO ---">
                        <option value="11">AUTOPOLANCO CHRYSLER</option>
                        <option value="12">AUTOPOLANCO MITSUBISHI</option>
                        <option value="13">AUTOPOLANCO ALFA ROMEO</option>
                    </optgroup>
                    <optgroup label="--- TOYOTA ---">
                        <option value="14">TOYOTA</option>
                        <option value="15">TOYOTA CSC</option>
                    </optgroup>
                </select>
                <br />
                <select id="sucursal" class="form-control" data-placeholder="Selecciona un Departamento" required="required" name="departamento">
                     <option value="1">ADMINISTRACIÓN</option>
                     <option value="2">AUDITORIA</option>
                     <option value="3">BODY SHOP</option>
                     <option value="4">CAPITAL HUMANO</option>
                     <option value="5">CASOFIN</option>
                     <option value="6">COMERCIAL</option>
                     <option value="7">COMPRAS</option>
                     <option value="8">CONTABILIDAD</option>
                     <option value="9">CONTRALORÍA</option>
                     <option value="10">CRÉDITO Y COBRANZA</option>
                     <option value="11">DIRECCIÓN ADJUNTA</option>
                     <option value="12">DIRECCIÓN COMERCIAL</option>
                     <option value="13">FINANZAS</option>
                     <option value="14">LOGISTICA</option>
                     <option value="15">MANTENIMIENTO</option>
                     <option value="16">MERCADOTECNIA</option>
                     <option value="17">POSTVENTA</option>
                     <option value="18">REFACCIONES</option>
                     <option value="20">SEMINUEVOS</option>
                     <option value="21">SERVICIO</option>
                     <option value="22">TALLER</option>
                     <option value="23">TI</option>
                     <option value="24">VENTAS</option>
                     <option value="25">VENTAS CORPORATIVAS</option>
                     <option value="26">GERENCIA GENERAL</option>
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
        <script  src="js/signup.js"></script>
    </body>
    
</html>