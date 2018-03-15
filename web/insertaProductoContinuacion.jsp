<%-- 
    Cuando se inserta un producto pregunta si se desea solicitar otro producto en
    la misma requisicion (nuevaRequisicion = 0).
    Si no se desea solicitar mas, se redirige a la pagina de seguimiento.
--%>

<!DOCTYPE html>

<html>
    <head>
        <title>Bienvenido</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">     
    </head>
    <body>
        <jsp:include page="frag/mainNavbar.jsp">
            <jsp:param name="rol" value="4" />  
            <jsp:param name="depto" value="3" />
        </jsp:include>

        <div class="container">
            <div class="jumbotron">
                <div class="page-header">
                    <h3>¿Deseas continuar comprando?</h3>
                </div>
                <div class="card w-75 mx-auto my-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="card" style="width: 18rem;">
                                    <img class="card-img-top" src="http://placehold.it/500x325" alt="Card image cap">
                                    <div class="card-body">
                                        <form action="menuSolicita.jsp" method="post">
                                            <input type="hidden" class="form-control" id="nuevaRequisicion" name="nuevaRequisicion" value="0">
                                            <button type="submit" class="btn btn-success btn-sm">Continuar Comprando</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="card" style="width: 18rem;">
                                    <img class="card-img-top" src="http://placehold.it/500x325" alt="Card image cap">
                                    <div class="card-body">
                                        <form action="menuSeguimiento.jsp" method="post">
                                            <button type="submit" class="btn btn-primary btn-sm">Terminar</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="frag/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>