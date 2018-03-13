<!DOCTYPE html>

<html>
    <head>
        <title>Bienvenido</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">     
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <span class="navbar-brand mb-0 h1">Bienvenido al sistema de compras</span>
        </nav>

        <div class="container">
            <div class="jumbotron">
                <div class="card w-50 mx-auto">
                    <div class="card-body">
                        <h5 class="card-title">Iniciar Sesión</h5> <form method="post" action="login.jsp">
                            <div for="email" class="form-group">
                                <label>Correo</label>
                                <input type="email" class="form-control" id="email" name="email">
                            </div>
                            <div for="pass" class="form-group">
                                <label>Contraseña</label>
                                <input type="text" class="form-control" id="pass">
                            </div>
                            <div for="login" class="form-group">
                                <input type="submit" class="btn btn-primary" value="Iniciar" />
                            </div>
                            <div for="login" class="form-group">
                                <label> Aún no estás registrado? </label> 
                                <a data-toggle="modal" data-target="#modalRegistro" class="text-primary" href="#">Registrate aqui</a>
                            </div>    
                        </form>
                    </div>
                </div>

                <div class="modal fade" id="modalRegistro" tabindex="-1" role="dialog" aria-labelledby="modalRegistro" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Ingresa tus datos</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form method="post" action="registro.jsp">
                                    <div for="nombre" class="form-group">
                                        <label>Nombre</label>
                                        <input type="text" class="form-control" name="nombre">
                                    </div>
                                    <div for="apellido" class="form-group">
                                        <label>Apellido</label>
                                        <input type="text" class="form-control" name="apellido">
                                    </div>
                                    <div for="correo" class="form-group">
                                        <label>Correo</label>
                                        <input type="email" class="form-control" name="correo">
                                    </div>
                                    <div for="pass" class="form-group">
                                        <label>Contraseña</label>
                                        <input type="text" class="form-control" name="pass">
                                    </div>
                                    <div class="form-group">
                                        <label for="sucursal">Unidad de negocio</label>
                                        <select class="form-control" name="sucursal">
                                            <option>Continental Metepec</option>
                                            <option>Hyundai Metepec</option>
                                            <option>Fiat Toluca</option>
                                            <option>Mitsubishi Toluca</option>
                                        </select>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="submit" class="btn btn-primary" value="Save changes" />
                                    </div>
                                </form>
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