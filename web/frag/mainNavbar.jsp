
<%
    int rol = Integer.parseInt(request.getParameter("rol"));
    int depto = Integer.parseInt(request.getParameter("depto"));
    int idUsuario = Integer.parseInt((String) session.getAttribute("idUsuario"));

%>
<head>
    <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
</head>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="menuSolicita.jsp">
        <img src="img/conti.png" height="30" alt="">
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <% if (rol == 1 && depto != 7) { %>
            <a class="nav-link" href="menuSolicita.jsp"> 
                Solicitar Producto
            </a>
            <a class="nav-link" href="menuSeguimiento.jsp"> 
                Seguimiento de Solicitud
            </a>
            <!--<a class="nav-link" href="menuHistorialPedido.jsp"> 
                Historial de Pedidos
            </a>-->
            <% } else {
                if (depto == 7) { %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Requisiciones
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <%
                        if (idUsuario == 226 || idUsuario == 25 || idUsuario == 4 || idUsuario == 83) {
                    %>
                    <a class="dropdown-item" href="menuComprasRequisiciones.jsp?categoria=1"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Papeleria 
                            </div>
                        </div>
                    </a>
                    <%  }
                        if (idUsuario == 83 || idUsuario == 4) {
                    %>
                    <a class="dropdown-item" href="menuComprasRequisiciones.jsp?categoria=4"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Cafetería  
                            </div>
                        </div>
                    </a>
                    <%
                        }
                        if (idUsuario == 268 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasRequisiciones.jsp?categoria=2"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Tecnologia  
                            </div>
                        </div>
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasRequisiciones.jsp?categoria=5"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Jarceria  
                            </div>
                        </div>
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasRequisiciones.jsp?categoria=6"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Ferreteria  
                            </div>
                        </div>
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 48 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasRequisiciones.jsp?categoria=7"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Servicios
                            </div>
                        </div>
                    </a>
                    <%
                        }
                    %>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Cot. Disponibles
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <%
                        if (idUsuario == 226 || idUsuario == 25 || idUsuario == 4 || idUsuario == 83) {
                    %>
                    <a class="dropdown-item" href="menuComprasCotizaciones.jsp?categoria=1"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Papeleria 
                            </div> 
                        </div>
                    </a>
                    <%  }
                        if (idUsuario == 83 || idUsuario == 4) {
                    %>
                    <a class="dropdown-item" href="menuComprasCotizaciones.jsp?categoria=4"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Cafetería 
                            </div> 
                        </div>
                    </a>
                    <%
                        }
                        if (idUsuario == 268 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasCotizaciones.jsp?categoria=2"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Tecnologia 
                            </div> 
                        </div>
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasCotizaciones.jsp?categoria=5"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Jarceria 
                            </div> 
                        </div>
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasCotizaciones.jsp?categoria=6"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Ferreteria 
                            </div> 
                        </div>
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 48 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasCotizaciones.jsp?categoria=7"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Servicios 
                            </div> 
                        </div>
                    </a>
                    <%
                        }
                    %>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Cot. Autorizadas
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <%
                        if (idUsuario == 226 || idUsuario == 25 || idUsuario == 4 || idUsuario == 83) {
                    %>
                    <a class="dropdown-item" href="menuComprasOrdenes.jsp?categoria=1"> 
                        Cotizaciones Papeleria
                    </a>
                    <%  }
                        if (idUsuario == 83 || idUsuario == 4) {
                    %>
                    <a class="dropdown-item" href="menuComprasOrdenes.jsp?categoria=4"> 
                        Cotizaciones Cafeteria
                    </a>
                    <%
                        }
                        if (idUsuario == 268 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasOrdenes.jsp?categoria=2"> 
                        Cotizaciones Tecnologia
                    </a>
                    <%
                        }
                    %>

                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasOrdenes.jsp?categoria=5"> 
                        Cotizaciones Jarceria
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasOrdenes.jsp?categoria=6"> 
                        Cotizaciones Ferreteria
                    </a>
                    <%
                        }
                    %>
                     <%
                        if (idUsuario == 48 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasOrdenes.jsp?categoria=7"> 
                        Cotizaciones Servicios
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 226 || idUsuario == 25 || idUsuario == 4 || idUsuario == 83) {
                    %>
                    <a class="dropdown-item" href="menuComprasOrdenesHistorial.jsp?categoria=1"> 
                        Historial Ordenes Papeleria
                    </a>
                    <%  }
                        if (idUsuario == 83 || idUsuario == 4) {
                    %>
                    <a class="dropdown-item" href="menuComprasOrdenesHistorial.jsp?categoria=4"> 
                        Historial Ordenes Cafeteria
                    </a>
                    <%
                        }
                        if (idUsuario == 268 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasOrdenesHistorial.jsp?categoria=2"> 
                        Historial Ordenes Tecnología
                    </a>
                    <%
                        }
                    %>
                    
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasOrdenesHistorial.jsp?categoria=5"> 
                        Historial Ordenes Jarceria
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasOrdenesHistorial.jsp?categoria=6"> 
                        Historial Ordenes Ferreteria
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 48 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasOrdenesHistorial.jsp?categoria=7"> 
                        Historial Ordenes Servicios
                    </a>
                    <%
                        }
                    %>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Recepcion
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <%
                        if (idUsuario == 226 || idUsuario == 25 || idUsuario == 4 || idUsuario == 83) {
                    %>
                    <a class="dropdown-item" href="menuComprasRecepcion.jsp?categoria=1"> 
                        Papeleria
                    </a>
                    <%  }
                        if (idUsuario == 83 || idUsuario == 4) {
                    %>
                    <a class="dropdown-item" href="menuComprasRecepcion.jsp?categoria=4"> 
                        Cafeteria
                    </a>
                    <%
                        }
                        if (idUsuario == 268 || idUsuario == 4) {
                    %>
                    <a class="dropdown-item" href="menuComprasRecepcion.jsp?categoria=2"> 
                        Tecnologia
                    </a>
                    <%
                        }
                    %>
                    
                    <%
                    if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasRecepcion.jsp?categoria=5"> 
                        Jarceria
                    </a>
                    <%
                        }
                    %>
                     <%
                    if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasRecepcion.jsp?categoria=6"> 
                        Ferreteria
                    </a>
                    <%
                        }
                    %>
                     <%
                    if (idUsuario == 48 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasRecepcion.jsp?categoria=7"> 
                        Servicios
                    </a>
                    <%
                        }
                    %>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Entrega
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <%
                        if (idUsuario == 226 || idUsuario == 25 || idUsuario == 4 || idUsuario == 83) {
                    %>
                    <a class="dropdown-item" href="menuComprasEntrega.jsp?categoria=1"> 
                        Papeleria
                    </a>
                    <%  }
                        if (idUsuario == 83 || idUsuario == 4) {
                    %>
                    <a class="dropdown-item" href="menuComprasEntrega.jsp?categoria=4"> 
                        Cafeteria
                    </a>
                    <%
                        }
                        if (idUsuario == 268 || idUsuario == 4) {
                    %>
                    <a class="dropdown-item" href="menuComprasEntrega.jsp?categoria=2"> 
                        Tecnologia
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25) {
                    %> 
                    <a class="dropdown-item" href="menuComprasEntrega.jsp?categoria=5">
                        Jarceria  
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 83 || idUsuario == 4 || idUsuario == 25)  {
                    %> 
                    <a class="dropdown-item" href="menuComprasEntrega.jsp?categoria=6">
                        Ferreteria  
                    </a>
                    <%
                        }
                    %>
                    <%
                        if (idUsuario == 48 || idUsuario == 4) {
                    %> 
                    <a class="dropdown-item" href="menuComprasEntrega.jsp?categoria=7">
                        Servicios  
                    </a>
                    <%
                        }
                    %>
                </div>
            </li>
            <%-- <% if (rol == 3) { %> --%>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Admin
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuComprasAdministracionRequisiciones.jsp"> 
                        Seguimiento de Requisiciones
                    </a>

                    <a class="dropdown-item" href="menuComprasAdministracion.jsp"> 
                        Seguimiento de Cotizaciones
                    </a>

                </div>
            </li>
            <%-- <% } %> --%>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Pedidos
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuSolicita.jsp"> 
                        Solicitar Producto
                    </a>
                    <a class="dropdown-item" href="menuSeguimiento.jsp"> 
                        Seguimiento de Solicitud
                    </a>
                    <!--<a class="dropdown-item" href="menuHistorialPedido.jsp"> 
                        Historial de Pedidos
                    </a>-->
                </div>
            </li>
            <% if (idUsuario == 4) { %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Comparativos/ordenes
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuComprasOrdenesAdminCompras.jsp"> 
                        Autorizar Comparativo
                    </a>
                    <!--
                    <a class="dropdown-item" href="menuHistorialAutorizaCoti.jsp"> 
                        Historial de Comparativos
                    </a>
                    -->
                    <a class="dropdown-item" href="menuOrdenesGerenteCompras.jsp"> 
                        Autorizar Ordenes
                    </a>
                    <a class="dropdown-item" href="menuComprasHistorialOrdenes.jsp">
                        Historial Comparativos
                    </a>
                </div>
            </li>   

            <% }
                }
                if (rol == 3 || rol == 4 || rol == 5) {
                    if (depto != 7) {
            %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Pedidos
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuSolicita.jsp"> 
                        Solicitar Producto
                    </a>
                    <a class="dropdown-item" href="menuSeguimiento.jsp"> 
                        Seguimiento de Solicitud
                    </a>
                    <a class="dropdown-item" href="menuHistorialPedido.jsp"> 
                        Historial de Pedidos
                    </a>
                </div>
            </li>
            <% } %>
            
            <% if (idUsuario != 282) { %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Autorizaciones Depto.
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuAutorizaRequi.jsp"> 
                        Autorizar Requisicion
                    </a>
                    <a class="dropdown-item" href="menuHistorialAutorizaRequi.jsp"> 
                        Historial de Autorizaciones
                    </a>
                </div>
            </li>
            <% } %>
            
            <% if (idUsuario == 34 || idUsuario == 210 || idUsuario == 122 || idUsuario == 12) { %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-check-square"></i> Autorizaciones Gerentes.
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuAutorizaRequiAdmin.jsp"> 
                        Autorizar Requisicion
                    </a>
                </div>
            </li>
            
            <% } %>
            
            <% 
                if (idUsuario == 282) { 
            %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-dollar-sign"></i> Comparativos
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuComprasOrdenesAdmin.jsp"> 
                        Autorizar Comparativo
                    </a>
                    <!--
                    <a class="dropdown-item" href="menuHistorialAutorizaCoti.jsp"> 
                        Historial de Comparativos
                    </a>
                    -->
                    <a class="dropdown-item" href="menuComprasHistorialOrdenes.jsp">
                        Historial de Comparativos
                    </a>
                </div>
            </li>   
            <% 
                } 
            %>
            
            <%-- 
            <% if ( idUsuario == 122) { %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-check-square"></i> Autorizaciones Gerentes.
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuAutorizaRequiAdmin.jsp"> 
                        Autorizar Requisicion
                    </a>
                </div>
            </li>  
            <% } %>
            --%>
            <% if (idUsuario == 294) { %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-dollar-sign"></i> Comparativos
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuComprasOrdenesAdminDir.jsp"> 
                        Autorizar Comparativo
                    </a>
                    <!--
                    <a class="dropdown-item" href="menuHistorialAutorizaCoti.jsp"> 
                        Historial de Comparativos
                    </a>
                    -->
                    <a class="dropdown-item" href="menuComprasHistorialOrdenes.jsp">
                        Historial de Comparativos
                    </a>
                </div>
            </li>   
            <% } %>
            <% if (depto == 23) {%>
            <a class="nav-link" href="menuAutorizaDictamen.jsp"> 
                Dictamenes
            </a>
            <% }
                }
                if (rol == 4) {  %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-check-square"></i> Autorizaciones Generales
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuAutorizaRequiGeneral.jsp"> 
                        Autorizar Requisicion
                    </a>
                    <a class="dropdown-item" href="menuHistorialAutorizaRequi.jsp"> 
                        Historial de Autorizaciones
                    </a>
                </div>
            </li> 
            <% }
                if (rol == 5) { %>


            <% }

                }
                if (depto == 31) {  %>
            <a class="nav-link" href="menuContabilidadOrdenes.jsp"> 
                Ordenes de Compra
            </a>
            <% }%>
            <% if (rol == 2) {  %>
            <a class="nav-link" href="menuSolicita.jsp"> 
                Solicitar Producto
            </a>
            <a class="nav-link" href="menuSeguimiento.jsp"> 
                Seguimiento de Solicitud
            </a>
            <a class="nav-link" href="menuDictamen.jsp"> 
                Hacer Dictamen
            </a>
            <% }%>
            <a class="nav-link" href="logout.jsp"> 
                Cerrar Sesión
            </a>
        </ul>

    </div>
</nav>
