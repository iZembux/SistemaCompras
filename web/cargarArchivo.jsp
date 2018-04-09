<%-- 
    Document   : cargarArchivo
    Created on : 6/04/2018, 04:43:45 PM
    Author     : LuisMtz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletRequestContext"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Cargar Archivo</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="utf-8">
        <script>
            /* yeah we need this empty stylesheet here. It's cool chrome & chromium fix
             chrome fix https://code.google.com/p/chromium/issues/detail?id=167083
             https://code.google.com/p/chromium/issues/detail?id=332189
             */
            
            function subir(){
    var i=document.getElementById('fileUp-input');
 
    if(window.FileReader){
        for(var j=0;j<i.files.length;j++){//como mi input file es múltiple, recorro sus elementos (archivos) que pueden ser varios
            var reader = new FileReader();//instanciamos FileReader
            reader.onloadend = (function(f){//creamos la función que recogerá los datos
                return function(e){
                    var content = e.target.result.split(",",2)[1];//obtenemos el contenido del archivo, estará codificado en Base64
                    enviarArchivo(f.name,content);le paso a una función el nombre del archivo y su contenido. Esta función puede pasar el contenido por ajax u otro medio al servidor
                            }
                        })(i.files[j]);
                        reader.readAsDataURL(i.files[j]);//
                    }
                }
            }
        </script>
    </head>
    <body>   
        <div class="wrap">
            <header class="page-header">
                <div class="navbar">
                    <ul class="nav navbar-nav navbar-right pull-right">
                        <li class="visible-phone-landscape">
                            <a href="#" id="search-toggle">
                                <i class="fa fa-search"></i>
                            </a>
                        </li>
                </div>
            </header>        
            <div class="content container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-1">
                        <section class="widget">
                            <div class="body">
                                <form id="fileupload" action="subir.jsp" method="POST" enctype="multipart/form-data">
                                    <div class="row">
                                        <div class="col-md-12 fileupload-progress fade">
                                            <!-- The global progress bar -->
                                            <div class="progress progress-xs active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                                <div class="progress-bar progress-bar-inverse" style="width:0%;"></div>
                                            </div>
                                            <!-- The extended global progress state -->
                                            <div class="progress-extended">&nbsp;</div>
                                        </div>
                                    </div>
                                    <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
                                    <div class="form-actions fileupload-buttonbar no-margin">
                                        <!-- The fileinput-button span is used to style the file input field as button -->
                                        <span class="btn btn-default fileinput-button mr-xs">
                                            <span>Agregar archivo...</span>
                                            <input type="file" name="files[]" > 
                                            <!--<input type="file" name="file" size="20" />-->
                                        </span>
                                        <button type="submit" class="btn btn-primary start mr-xs">
                                            <span>Comenzar carga</span>
                                        </button>
                                    </div>
                                    <!-- The table listing the files available for upload/download -->
                                    <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
                                </form>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
            <div class="loader-wrap hiding hide">
                <i class="fa fa-circle-o-notch fa-spin"></i>
            </div>
        </div>
        <!-- common libraries. required for every page-->
        <script src="lib/jquery/dist/jquery.min.js"></script>
        <script src="lib/jquery-pjax/jquery.pjax.js"></script>
        <script src="lib/bootstrap-sass/assets/javascripts/bootstrap.min.js"></script>
        <script src="lib/widgster/widgster.js"></script>
        <script src="lib/underscore/underscore.js"></script>

        <!-- common application js -->
        <script src="js/app.js"></script>
        <script src="js/settings.js"></script>

        <!-- page specific scripts -->
        <!-- page specific libs -->
        <script src="lib/jquery-ui/ui/core.js"></script>
        <script src="lib/jquery-ui/ui/widget.js"></script>
        <!-- The Templates plugin is included to render the upload/download listings -->
        <script src="//blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>
        <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
        <script src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
        <!-- The Canvas to Blob plugin is included for image resizing functionality -->
        <script src="//blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
        <!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
        <script src="lib/bootstrap/dist/js/bootstrap.min.js"></script>
        <!-- blueimp Gallery script -->
        <script src="//blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>
        <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
        <script src="lib/blueimp-file-upload/js/jquery.iframe-transport.js"></script>
        <!-- The basic File Upload plugin -->
        <script src="lib/blueimp-file-upload/js/jquery.fileupload.js"></script>
        <!-- The File Upload processing plugin -->
        <script src="lib/blueimp-file-upload/js/jquery.fileupload-process.js"></script>
        <!-- The File Upload image preview & resize plugin -->
        <script src="lib/blueimp-file-upload/js/jquery.fileupload-image.js"></script>
        <!-- The File Upload audio preview plugin -->
        <script src="lib/blueimp-file-upload/js/jquery.fileupload-audio.js"></script>
        <!-- The File Upload video preview plugin -->
        <script src="lib/blueimp-file-upload/js/jquery.fileupload-video.js"></script>
        <!-- The File Upload validation plugin -->
        <script src="lib/blueimp-file-upload/js/jquery.fileupload-validate.js"></script>
        <!-- The File Upload user interface plugin -->
        <script src="lib/blueimp-file-upload/js/jquery.fileupload-ui.js"></script>
        <!-- page application js -->
        <script src="js/component-fileupload.js"></script>

        <!-- The template to display files available for upload -->
        <script id="template-upload" type="text/x-tmpl">
            {% for (var i=0, file; file = o.files[i]; i++) { %}
            <tr class="template-upload fade">
            <td>
            <span class="preview"></span>
            </td>
            <td>
            <p class="name">{%=file.name%}</p>
            <strong class="error text-danger"></strong>
            </td>
            <td>
            <p class="size">Procesando...</p>
            <div class="progress progress-xs active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
            </td>
            <td> 
            {% if (!i && !o.options.autoUpload) { %}
<button class="btn btn-primary btn-sm start" disabled>
    <i class="glyphicon glyphicon-upload"></i>
    <span>Comenzar</span>
</button>
{% } %}
{% if (!i) { %}
<button class="btn btn-warning btn-sm cancel">
    <i class="glyphicon glyphicon-ban-circle"></i>
    <span>Cancelar</span>
</button>
{% } %}
</td>
</tr>
            {% } %}
        </script>
        <!-- The template to display files available for download -->
        <script id="template-download" type="text/x-tmpl">
            {% for (var i=0, file; file=o.files[i]; i++) { %}
<tr class="template-download fade">
    <td>
        <span class="preview">
            {% if (file.thumbnailUrl) { %}
            <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
            {% } %}
        </span>
    </td>
    <td>
        <p class="name">
            {% if (file.url) { %}
            <a href="{%=file.url%}" title="{%=file.name%}" download = "{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}> {%=file.name%}</a>
            {% } else { %}
            <span>{%=file.name%}</span>
            {% } %}
        </p>
        {% if (file.error) { %}
        <div><span class="label label-danger">Error</span> {%=file.error%}</div>
        {% } %}
    </td>
    <td>
        <span class="size">{%=o.formatFileSize(file.size)%}</span>
    </td>
    <td>
        {% if (file.deleteUrl) { %}
        <button class="btn btn-danger btn-sm delete" data-type=" {%=file.deleteType%} " data-url="{%=file.deleteUrl%}" {% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
            <i class="glyphicon glyphicon-trash"></i>
            <span>Borrar</span>
        </button>
        {% } else { %}
        <button class="btn btn-warning btn-sm cancel">
            <i class="glyphicon glyphicon-ban-circle"></i>
            <span>Cancelar</span>
        </button>
        {% } %}
    </td>
</tr>
{% } %}
        </script>

    </body>
</html>