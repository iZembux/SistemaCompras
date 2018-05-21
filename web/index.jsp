<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    
    int banderaregistro = 0;
    int login = 0;
    String loginS = "";

        try {
            banderaregistro = Integer.parseInt(request.getParameter("registro"));
        } catch (Exception e) {
            System.out.println("Catch de banderaregistro " + banderaregistro);
        }
        try {
            loginS = (String) sesion.getAttribute("login");
            login = Integer.parseInt(loginS);
        } catch (Exception e) {
        }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Inicio de Sesión</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <!--===============================================================================================-->

        <script type="text/javascript">
            var l = <%=login%>;
            if ( l == 1) {
                    alert('Datos de acceso incorrectos');
            }else{
                alert('Bienvenido: '+<%%>)
            }
        </script>

    </head>
    <body>


        <div class="container-login100" style="background-image: url('images/usingcredit.jpg');">
            <div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
                <form class="login100-form validate-form" action="Acceso" method="post">
                    <span class="login100-form-title p-b-37">
                        Inicio de Sesión
                    </span>
                    <div class="wrap-input100 validate-input m-b-20" data-validate="Usuario">
                        <input class="input100" type="text" name="usuario" placeholder="Ingresa Usuario">
                        <span class="focus-input100"></span>
                    </div>

                    <div class="wrap-input100 validate-input m-b-25" data-validate = "Ingresa Contraseña">
                        <input class="input100" type="password" name="pass" placeholder="contraseña">
                        <span class="focus-input100"></span>
                    </div>

                    <div class="container-login100-form-btn">
                        <button class="login100-form-btn">
                            Iniciar Sesión
                        </button>
                    </div>
                    <div class="text-center">
                        <a href="registro.jsp" class="txt2 hov1">
                            Registrarse
                        </a>
                    </div>
                </form>
                <br />
                    <div class="text-center">
                        <a href="logProveedor.jsp" class="txt2 hov1">
                            ¿Eres Proveedor?
                        </a>
                    </div>
                <!--<form action="RegistroProveedor" method="post">
                    <div class="text-center"><button class="txt2 hov1">
                        Registro Proveedor
                    </button></div>
                </form>-->
            </div>
        </div>

        <div id="dropDownSelect1"></div>

        <!--===============================================================================================-->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="js/main.js"></script>
         <!--===============================================================================================-->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    </body>
</html>