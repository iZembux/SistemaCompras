
<%@page import="model.CotizacionRequisicion"%>
<%@page import="controller.Consultas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.Mail"%>
<%@ page import ="java.sql.*" %>
<%
    int nuevoStatusRequi = 0;
    int nuevoStatusCoti = 0;
    int idCotizacion = 0;
    int idCotizaciones = 0;
    int idRP = 0;
    int idUsu = 0;
    int idComparativo = 0;
    double cantidad = 0;
    double precio = 0;
    double iva = 0;
    double total = 0;
    String observaciones = null;

    int tam = 0;
    int tam2 = 0;
    int seleccionada = 0;

    Mail objMail = new Mail();

    try {
        nuevoStatusRequi = Integer.parseInt(request.getParameter("nuevoStatusRequi"));
    } catch (Exception e) {
    }
    try {
        idUsu = Integer.parseInt(request.getParameter("idUsu"));
    } catch (Exception e) {
    }
    try {
        observaciones = request.getParameter("observaciones");
    } catch (Exception e) {
    }

    int id_categoria = 0;
    try {
        id_categoria = Integer.parseInt(request.getParameter("categoria"));
    } catch (Exception e) {
    }

    try {
        tam = Integer.parseInt(request.getParameter("tamano"));
    } catch (Exception e) {
        System.out.println("No llego el parametro del tamaño " + e);
    }

    try {
        tam2 = Integer.parseInt(request.getParameter("tam2"));
    } catch (Exception e) {
    }

    try {
        seleccionada = Integer.parseInt(request.getParameter("sel"));
    } catch (Exception e) {
    }

    ArrayList<CotizacionRequisicion> arrayRequis = new ArrayList<CotizacionRequisicion>();
    Consultas obj = new Consultas();
    arrayRequis = obj.consultarCotizaciones(idCotizacion);
    if (arrayRequis.size() > 0) {
        cantidad = arrayRequis.get(0).getCantidad();
        precio = arrayRequis.get(0).getPrecio();
        iva = arrayRequis.get(0).getIva();
        total = ((precio + iva) * cantidad);
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scompras", "root", "stmsc0nt");
    Statement st = con.createStatement();
    ResultSet rs;

    rs = st.executeQuery("SELECT  max(idcuadro) as id from comparativos;");
    if (rs.next()) {
        idComparativo = rs.getInt("id") + 1;
    }

    System.out.println("------------------COTIZACIONES GANADORAS--------------------");
    System.out.println("Proveedor: " + seleccionada);
    System.out.println("Numero de cotizaciones: " + tam);
    System.out.println("Comparativo: " + idComparativo);
    for (int j = 0; j < tam; j++) {
            idCotizacion = Integer.parseInt(request.getParameter("cotiSelccionada" + seleccionada + j));

            System.out.println("Cotizacion ganadora: " + idCotizacion);
            st.executeUpdate("update cotizacion set id_status_cotizacion = " + nuevoStatusCoti + ", observaciones = '" + observaciones + "',\n"
                    + "aut_compras = " + idUsu + ", fecha_aut_compras = CURRENT_TIMESTAMP where id_cotizacion = " + idCotizacion + ";");

            idRP = Integer.parseInt(request.getParameter("idRP" + j));
            System.out.println("*Requisicion " + idRP + " Nuevo staus ==> " + nuevoStatusRequi);
            st.executeUpdate("update req_prod rp, cotizacion c set id_status = " + nuevoStatusRequi + ", id_cot_ganadora = " + idCotizacion + ", "
                    + "id_cuadro = " + idComparativo + " "
                    + "where c.id_req_coti = rp.id_req_coti and c.id_cotizacion = " + idCotizacion + " and id_req_prod = " + idRP + ";");

        
    }

    for (int i = 0; i < tam2; i++) {
        try {
            idCotizaciones = Integer.parseInt(request.getParameter("idCoti" + i));

            System.out.println("Cotizaciones en el cuadro: " + idCotizaciones);

            st.executeUpdate("insert into comparativos (idcotizacion, idcuadro) values (" + idCotizaciones + ", " + idComparativo + ")");

        } catch (Exception e) {
            System.out.println("Error :( ");
        }
    }
    System.out.println("------------------------------------------------------------");
    //Envia Correo a Gerente Admin
    response.sendRedirect("menuComprasCotizaciones.jsp?categoria=" + id_categoria + "");
%>