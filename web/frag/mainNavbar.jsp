
<%
    int rol = Integer.parseInt(request.getParameter("rol"));
    int depto = Integer.parseInt(request.getParameter("depto"));
%>
<head>
    <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
</head>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">
        <img src="img/conti.png" height="30" alt="">
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Requisiciones <span class="badge badge-secondary">9</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuComprasRequisiciones.jsp"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Papeleria 
                            </div>
                            <div class="col col-lg-3">
                                <span class="badge badge-dark">4 </span>
                            </div>   
                        </div>
                    </a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Cotizaciones <span class="badge badge-secondary">9</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuComprasCotizaciones.jsp"> 
                        <div class="row">
                            <div class="col col-lg-9">
                                Papeleria 
                            </div>
                            <div class="col col-lg-3">
                                <span class="badge badge-dark">4 </span>
                            </div>   
                        </div>
                    </a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-shopping-cart"></i> Pedidos
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
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-check-square"></i> Autorizaciones <span class="badge badge-secondary">9</span>
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
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-dollar-sign"></i> Cotizaciones <span class="badge badge-secondary">9</span>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="menuAutorizaCoti.jsp"> 
                        Autorizar Cotizacion
                    </a>
                    <a class="dropdown-item" href="menuHistorialAutorizaCoti.jsp"> 
                        Historial de Cotizaciones
                    </a>
                </div>
            </li>       
            <a class="nav-link" href="menuRequisicionesProveedor.jsp"> 
                Proveedor
            </a>
        </ul>
        <a class="nav-item ml-auto" href="logout.jsp">
            <i class="fas fa-power-off"></i> Cerrar sesión
        </a>
    </div>
</nav>
