<%-- 
    Document   : seguimiento
    Created on : Mar 5, 2018, 12:30:16 PM
    Author     : user
--%>
<%
    int id_requi = Integer.parseInt(request.getParameter("id_requi"));
    System.out.println("Id de Requisición: " + id_requi);
%>

<div class="modal fade" id="modalDetalle" tabindex="-1" role="dialog" aria-labelledby="modalDetalle" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Detalle del Producto</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">No.</th>
                            <th scope="col">Cantidad</th>
                            <th scope="col">Producto</th>
                            <th scope="col">Marca</th>
                            <th scope="col">Justificacion</th>
                            <th scope="col">Descripcion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%=id_requi%></td>
                            <td>3</td>
                            <td>Cuaderno</td>
                            <td>Scribe</td>
                            <td>Reportes</td>
                            <td>N/A</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
