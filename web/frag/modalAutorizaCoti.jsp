
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.RequisicionProducto"%>
<%
    int idRequiSeleccionada = 0;
    try {
        idRequiSeleccionada = Integer.parseInt(request.getParameter("idRequi"));
        //System.out.println("ID REQUISICION: " + idRequiSeleccionada);
    } catch (Exception e) {
    }

    if (idRequiSeleccionada != 0) {
%>

<div class="jumbotron">
    <form action="navAutorizaRequi.jsp" method="post">
        <input type="hidden" class="hidden" name="idRequi" value="0" >
        <button type="submit" class="btn btn-primary btn-sm ml-auto">Cerrar</button>
    </form>
    <table class="table table-striped table-hover">
        <thead>
            <tr>
                <th scope="col">Producto</th>
                <th scope="col">Marca</th>
                <th scope="col">Cantidad</th>
                <th scope="col">Justificación</th>
                <th scope="col">Descripcion</th>
                <th scope="col"></th>
            </tr>
        </thead>
        <tbody>
            <%                            //Consulta por idRequi seleccionada
                int cantidad;
                String producto;
                String marca;
                String justificacion;
                String descripcion;

                ArrayList<RequisicionProducto> arrayRequis = new ArrayList<RequisicionProducto>();
                Consultas obj = new Consultas();
                arrayRequis = obj.consultarDetalleRequiGerente(idRequiSeleccionada);

                if (arrayRequis.size() > 0) {
                    for (int i = 0; i < arrayRequis.size(); i++) {
                        cantidad = arrayRequis.get(i).getCantidad();
                        producto = arrayRequis.get(i).getProducto();
                        justificacion = arrayRequis.get(i).getJustificacion();
                        descripcion = arrayRequis.get(i).getDescripcion();
            %>
            <tr>
                <td><%=producto%></td>
                <td><%="NA"%></td>
                <td><%=cantidad%></td>
                <td><%=justificacion%></td>
                <td><%=descripcion%></td>
                <td>
                    <input type="checkbox" class="form-check-input" id="exampleCheck1">
                    <label class="form-check-label" for="exampleCheck1">Aceptar</label>
                </td>
            </tr>
            <% }
                }%>
        </tbody>
    </table>
    <div class="row">
        <form action="navAutorizaRequi.jsp" method="post">
            <input type="hidden" class="hidden" name="idRequi" value="0" >
            <button type="submit" class="btn btn-success btn-sm">Autorizar Seleccionadas</button>
        </form>
        <form action="navAutorizaRequi.jsp" method="post">
            <input type="hidden" class="hidden" name="idRequi" value="0" >
            <button type="submit" class="btn btn-danger btn-sm">Rechazar todo</button>
        </form>
    </div>
</div>
<% }%>
