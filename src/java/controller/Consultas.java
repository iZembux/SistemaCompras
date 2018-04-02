package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.CotizacionRequisicion;
import model.Item;
import model.OrdenFormato;
import model.RequisicionFormato;
import model.RequisicionProducto;

public class Consultas {

    /**
     * Consulta las requisiciones recien creadas (status 3) dependiendo del
     * departamento al que pertenece el usuario
     *
     * @param departamento Indica el departamento del gerente
     * @return
     */
    public ArrayList<RequisicionProducto> consultarRequiGerente(String departamento) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND u.id_departamento = " + departamento + "\n"
                        + "    AND rp.id_status = 3\n"
                        + "    GROUP BY rp.id_requisicion\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("fecha"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarDetalleRequiGerente(int id_requisicion) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_req_prod AS IDREQUISICION,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    rp.justificacion AS JUSTIFICACION,\n"
                        + "    rp.descripcion AS DESCRIPCION\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    and r.id_requisicion = " + id_requisicion + "\n"
                        + "    AND rp.id_status = 3\n"
                        + "    group by rp.id_req_prod;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdReqProd(rs.getInt("IDREQUISICION"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setJustificacion(rs.getString("JUSTIFICACION"));
                    obj.setDescripcion(rs.getString("DESCRIPCION"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarHistorialGerente(String departamento) {
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    r.id_requisicion AS REQUISICION,\n"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    rp.cantidad AS CANTIDAD,\n"
                        + "    p.marca AS MARCA,\n"
                        + "    rp.justificacion AS JUSTIFICACION,\n"
                        + "    rp.descripcion AS DESCRIPCION,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    s.descripcion AS STATUS\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    status s\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status = s.id_status\n"
                        + "    AND u.id_departamento = " + departamento + "\n"
                        + "    AND rp.id_status > 3\n"
                        + "ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("REQUISICION"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setJustificacion(rs.getString("JUSTIFICACION"));
                    obj.setDescripcion(rs.getString("DESCRIPCION"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setStatus(rs.getString("STATUS"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarRequiGerenteAdmin(int departamento) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status = 4\n"
                        + "    GROUP BY rp.id_requisicion\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setSolicitante(rs.getString("PRODUCTO"));
                    obj.setSolicitante(rs.getString("MARCA"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    /**
     * Consulta las requisiciones aprobadas por el gerente (status 4)
     * dependiendo de la categoria del producto
     *
     * @param id_categoria Indica la categoria a la que pertenecen los producots
     * solicitados
     * @param status El status de la requisicion
     * @return
     */
    public ArrayList<RequisicionProducto> consultarCompras(int id_categoria, int status) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    rp.id_producto AS IDPRODUCTO,"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    GROUP BY rp.id_producto\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setIdProducto(rs.getInt("IDPRODUCTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setIdReqCoti(rs.getInt("COTI"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    /**
     * Consulta las requisiciones aprobadas por el gerente (status 4)
     * dependiendo de la categoria del producto
     *
     * @param id_categoria Indica la categoria a la que pertenecen los producots
     * solicitados
     * @param status El status de la requisicion
     * @return
     */
    public ArrayList<RequisicionProducto> consultarCompras2(int id_categoria, int status) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    rp.id_producto AS IDPRODUCTO,"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    GROUP BY rp.id_req_coti\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setIdProducto(rs.getInt("IDPRODUCTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setIdReqCoti(rs.getInt("COTI"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    /**
     * Consulta las requisiciones enviadas por el proveedor (status 11)
     *
     * @param status El status de la requisicion
     * @return
     */
    public ArrayList<RequisicionProducto> consultarComprasRecibido(int status) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    rp.id_producto AS IDPRODUCTO,"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    GROUP BY rp.id_producto\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setIdProducto(rs.getInt("IDPRODUCTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setIdReqCoti(rs.getInt("COTI"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarComprasDetalle(int departamento, int idProducto) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_req_prod as REQPROD,\n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    rp.cantidad AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status = 4\n"
                        + "    AND rp.id_producto = " + idProducto + "\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdReqProd(rs.getInt("REQPROD"));
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<CotizacionRequisicion> consultarComprasDetalleCoti(int idReqCoti) {
        int cont = 0;
        ArrayList<CotizacionRequisicion> listaRequi = new ArrayList<CotizacionRequisicion>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    c.id_cotizacion AS COTIZACION,\n"
                        + "    pr.razonsocial AS PROVEEDOR,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    c.id_proveedor AS IDP,\n"
                        + "    c.cantidad AS CANTIDAD,\n"
                        + "    c.precio AS PRECIO,\n"
                        + "    c.iva AS IVA,\n"
                        + "    c.descuento AS DESCUENTO,\n"
                        + "    c.diascredito AS CREDITO,\n"
                        + "    c.tiempoentrega AS ENTREGA,\n"
                        + "    c.anticipo AS ANTICIPO\n"
                        + "FROM\n"
                        + "    productos p,\n"
                        + "    cotizacion c,\n"
                        + "    proveedores pr\n"
                        + "WHERE\n"
                        + "    pr.idproveedor = c.id_proveedor\n"
                        + "        AND p.id_productos = c.id_producto\n"
                        + "        AND c.id_req_coti = " + idReqCoti + "";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    CotizacionRequisicion obj = new CotizacionRequisicion();
                    obj.setIdC(rs.getInt("COTIZACION"));
                    obj.setProveedor(rs.getString("PROVEEDOR"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setIdP(rs.getInt("IDP"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setPrecio(rs.getInt("PRECIO"));
                    obj.setIva(rs.getInt("IVA"));
                    obj.setDescuento(rs.getInt("DESCUENTO"));
                    obj.setCredito(rs.getInt("CREDITO"));
                    obj.setEntrega(rs.getInt("ENTREGA"));
                    obj.setAnticipo(rs.getInt("ANTICIPO"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<CotizacionRequisicion> consultarProveedorCoti(int idReqCoti, String idProveedor) {
        int cont = 0;
        ArrayList<CotizacionRequisicion> listaRequi = new ArrayList<CotizacionRequisicion>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    u.nombre AS PROVEEDOR,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    c.id_proveedor AS IDP,\n"
                        + "    c.cantidad AS CANTIDAD,\n"
                        + "    c.precio AS PRECIO,\n"
                        + "    c.iva AS IVA,\n"
                        + "    c.descuento AS DESCUENTO,\n"
                        + "    c.diascredito AS CREDITO,\n"
                        + "    c.tiempoentrega AS ENTREGA,\n"
                        + "    c.anticipo AS ANTICIPO\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    productos p,\n"
                        + "    cotizacion c\n"
                        + "WHERE\n"
                        + "    u.id_usuario = c.id_proveedor\n"
                        + "        AND p.id_productos = c.id_producto\n"
                        + "        AND c.id_req_coti = " + idReqCoti + "\n"
                        + "        AND c.id_proveedor = " + idProveedor + ";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    CotizacionRequisicion obj = new CotizacionRequisicion();
                    obj.setProveedor(rs.getString("PROVEEDOR"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setIdP(rs.getInt("IDP"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setPrecio(rs.getInt("PRECIO"));
                    obj.setIva(rs.getInt("IVA"));
                    obj.setDescuento(rs.getInt("DESCUENTO"));
                    obj.setCredito(rs.getInt("CREDITO"));
                    obj.setEntrega(rs.getInt("ENTREGA"));
                    obj.setAnticipo(rs.getInt("ANTICIPO"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarComprasProv(int departamento, String status) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    rp.id_producto AS IDPRODUCTO,"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    rp.id_status AS STATUS\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status in (" + status + ")\n"
                        + "    GROUP BY rp.id_producto\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setIdProducto(rs.getInt("IDPRODUCTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setIdReqCoti(rs.getInt("COTI"));
                    obj.setIdStatus(rs.getInt("STATUS"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarStatusProducto(String id_usuario) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_req_prod AS ID,\n"
                        + "    r.id_requisicion AS NOREQUI,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    rp.cantidad AS CANTIDAD,\n"
                        + "    s.descripcion AS STATUS,\n"
                        + "    s.porcentaje AS PORCENTAJE,\n"
                        + "    r.fecha AS FECHA\n"
                        + "    \n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    status s\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "        AND r.id_requisicion = rp.id_requisicion\n"
                        + "        AND p.id_productos = rp.id_producto\n"
                        + "        AND rp.id_status =  s.id_status\n"
                        + "        AND u.id_usuario = " + id_usuario + ";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdReqProd(rs.getInt("ID"));
                    obj.setIdRequisicion(rs.getInt("NOREQUI"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setDescripcion(rs.getString("STATUS"));
                    obj.setPorcentaje(rs.getString("PORCENTAJE"));
                    obj.setFecha(rs.getString("FECHA"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<Item> consultarItems() {
        ArrayList<Item> items = new ArrayList<>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select id_productos, nombre, id_categoria, serie, marca, modelo, id_unidadmedida from productos";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Item objItem = new Item();
                    objItem.setId(rs.getInt("id_productos"));
                    objItem.setNombre(rs.getString("nombre"));
                    objItem.setModelo(rs.getString("modelo"));
                    objItem.setMarca(rs.getString("marca"));
                    items.add(objItem);
                }

            } catch (SQLException e) {
                System.out.println("ERROR 2 AL CONSULTAR ITEMS SQL: " + e.getMessage());
            }
        }
        return items;
    }

    public ArrayList<Item> consultarItems2(String nombre) {
        System.out.println("Entree");
        ArrayList<Item> items = new ArrayList<>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select  marca from productos where nombre = '" + nombre + "'";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Item objItem = new Item();
                    objItem.setMarca(rs.getString("marca"));
                    items.add(objItem);
                }

            } catch (SQLException e) {
                System.out.println("ERROR 2 AL CONSULTAR ITEMS SQL: " + e.getMessage());
            }
        }
        return items;
    }

    public ArrayList<CotizacionRequisicion> consultarCotizaciones(int idCoti) {
        ArrayList<CotizacionRequisicion> listaRequi = new ArrayList<CotizacionRequisicion>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT\n"
                        + "    c.id_cotizacion AS COTIZACION,\n"
                        + "    pr.razonsocial AS PROVEEDOR,\n"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    d.departamento AS DEPTO,\n"
                        + "    s.sucursal AS SUCURSAL,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    c.id_proveedor AS IDP,\n"
                        + "    c.cantidad AS CANTIDAD,\n"
                        + "    c.precio AS PRECIO,\n"
                        + "    c.iva AS IVA,\n"
                        + "    c.descuento AS DESCUENTO,\n"
                        + "    c.diascredito AS CREDITO,\n"
                        + "    c.tiempoentrega AS ENTREGA,\n"
                        + "    c.anticipo AS ANTICIPO,\n"
                        + "    c.id_status_cotizacion AS STATUS\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    productos p,\n"
                        + "    cotizacion c,\n"
                        + "    req_prod rp,\n"
                        + "    requisiciones r,\n"
                        + "    departamentos d,\n"
                        + "    sucursales s,\n"
                        + "    proveedores pr\n"
                        + "WHERE\n"
                        + "    pr.idproveedor = c.id_proveedor\n"
                        + "    AND rp.id_req_coti = c.id_req_coti\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND r.id_usuario = u.id_usuario\n"
                        + "    AND u.id_departamento = d.id_departamentos\n"
                        + "    AND u.id_sucursal = s.id_sucursales\n"
                        + "    AND p.id_productos = c.id_producto\n"
                        + "    AND id_cotizacion = " + idCoti + "\n"
                        + "    group by c.id_cotizacion";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    CotizacionRequisicion obj = new CotizacionRequisicion();
                    obj.setIdC(rs.getInt("COTIZACION"));
                    obj.setProveedor(rs.getString("PROVEEDOR"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setDepto(rs.getString("DEPTO"));
                    obj.setSucursal(rs.getString("SUCURSAL"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setIdP(rs.getInt("IDP"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setPrecio(rs.getInt("PRECIO"));
                    obj.setIva(rs.getInt("IVA"));
                    obj.setDescuento(rs.getInt("DESCUENTO"));
                    obj.setCredito(rs.getInt("CREDITO"));
                    obj.setEntrega(rs.getInt("ENTREGA"));
                    obj.setAnticipo(rs.getInt("ANTICIPO"));
                    obj.setStatus(rs.getInt("STATUS"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    /**
     * Consulta la informacion necesaria para llenar el formato de la
     * requisicion
     *
     * @param idRequProd Id de cada requisicion individual
     * @return
     */
    public ArrayList<RequisicionFormato> consultarFormatoRequisicion(int idRequProd) {
        ArrayList<RequisicionFormato> listaRequi = new ArrayList<RequisicionFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    s.sucursal,\n"
                        + "    u.nombre as solicitante,\n"
                        + "    u.apellido,\n"
                        + "    u.apellidoM,\n"
                        + "    d.departamento,\n"
                        + "    rp.justificacion,\n"
                        + "    r.fecha,\n"
                        + "    p.nombre as producto,\n"
                        + "    rp.cantidad,\n"
                        + "    rp.descripcion,\n"
                        + "    p.marca,\n"
                        + "    p.modelo\n"
                        + "FROM\n"
                        + "    sucursales s,\n"
                        + "    usuario u,\n"
                        + "    departamentos d,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    rp.id_requisicion = r.id_requisicion\n"
                        + "        AND r.id_usuario = u.id_usuario\n"
                        + "        AND d.id_departamentos = u.id_departamento\n"
                        + "        AND s.id_sucursales = u.id_sucursal\n"
                        + "        AND rp.id_producto = p.id_productos\n"
                        + "        AND rp.id_req_prod = " + idRequProd + "";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    RequisicionFormato obj = new RequisicionFormato();
                    obj.setSucursal(rs.getString("sucursal"));
                    obj.setNombre(rs.getString("solicitante"));
                    obj.setApellidoP(rs.getString("apellido"));
                    obj.setApellidoM(rs.getString("apellidoM"));
                    obj.setDepartamento(rs.getString("departamento"));
                    obj.setJustificacion(rs.getString("justificacion"));
                    obj.setFecha(rs.getString("fecha"));
                    obj.setProducto(rs.getString("producto"));
                    obj.setCantidad(rs.getInt("cantidad"));
                    obj.setDescripcion(rs.getString("descripcion"));
                    obj.setMarca(rs.getString("marca"));
                    obj.setModelo(rs.getString("modelo"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    /**
     * Consulta la informacion necesaria para llenar el formato de orden de
     * compra
     *
     * @param idReqCoti Id de la cotizacion
     * @return
     */
    public ArrayList<OrdenFormato> consultarFormatoOrden(int idReqCoti) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    pr.idproveedor as idP,\n"
                        + "    pr.razonsocial as nombreP,\n"
                        + "    pr.direccion as direccionP,\n"
                        + "    pr.telefono as telefono,\n"
                        + "    pr.rfc as rfc,\n"
                        + "    r.fecha as fecha,\n"
                        + "    rp.cantidad as cantidad,\n"
                        + "    p.nombre as producto,\n"
                        + "    um.descripcion as unidadM,\n"
                        + "    rp.descripcion as descripcion,\n"
                        + "    c.descuento as descuento,\n"
                        + "    c.precio as precio,\n"
                        + "    c.tiempoentrega\n"
                        + "FROM\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    cotizacion c,\n"
                        + "    productos p,\n"
                        + "    proveedores pr,\n"
                        + "    unidadmedida um\n"
                        + "WHERE\n"
                        + "    c.id_proveedor = pr.idproveedor\n"
                        + "        AND rp.id_req_coti = c.id_req_coti\n"
                        + "        AND r.id_requisicion = rp.id_requisicion\n"
                        + "        AND rp.id_producto = p.id_productos\n"
                        + "        AND um.id_unidadmedida = p.id_unidadmedida\n"
                        + "        AND c.id_req_coti = " + idReqCoti + "";
                System.out.println(sql);
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrdenFormato obj = new OrdenFormato();
                    obj.setIdP(rs.getInt("idP"));
                    //obj.setSucursal(rs.getString("sucursal"));
                    obj.setRfc(rs.getString("rfc"));
                    //obj.setDireccion(rs.getString("direccion"));
                    obj.setNombreP(rs.getString("nombreP"));
                    obj.setDireccionP(rs.getString("direccionP"));
                    obj.setFecha(rs.getString("fecha"));
                    obj.setUnidadMedida(rs.getString("unidadM"));
                    obj.setProducto(rs.getString("producto"));
                    obj.setCantidad(rs.getInt("cantidad"));
                    obj.setDescripcion(rs.getString("descripcion"));
                    obj.setTelefonoP(rs.getString("telefono"));
                    obj.setDescuento(rs.getInt("descuento"));
                    obj.setPrecio(rs.getInt("precio"));
                    
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    /**
     * Consulta las cotizaciones que fueron seleccionadas por compras para el
     * cuadro comparativo
     *
     * @param idReqCoti el id que tienen las requisiciones asociadas a una
     * cotizacion
     * @return ArrayList de cotizaciones
     */
    public ArrayList<CotizacionRequisicion> consultarCotizacionesSeleccionadas(int idReqCoti) {
        ArrayList<CotizacionRequisicion> listaRequi = new ArrayList<CotizacionRequisicion>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT\n"
                        + "    c.id_cotizacion AS COTIZACION,\n"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    d.departamento AS DEPTO,\n"
                        + "    s.sucursal AS SUCURSAL,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    c.id_proveedor AS IDP,\n"
                        + "    c.cantidad AS CANTIDAD,\n"
                        + "    c.precio AS PRECIO,\n"
                        + "    c.iva AS IVA,\n"
                        + "    c.descuento AS DESCUENTO,\n"
                        + "    c.diascredito AS CREDITO,\n"
                        + "    c.tiempoentrega AS ENTREGA,\n"
                        + "    c.anticipo AS ANTICIPO,\n"
                        + "    c.id_status_cotizacion AS STATUS\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    productos p,\n"
                        + "    cotizacion c,\n"
                        + "    req_prod rp,\n"
                        + "    requisiciones r,\n"
                        + "    departamentos d,\n"
                        + "    sucursales s\n"
                        + "WHERE\n"
                        + "	rp.id_req_coti = c.id_req_coti\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND r.id_usuario = u.id_usuario\n"
                        + "    AND u.id_departamento = d.id_departamentos\n"
                        + "    AND u.id_sucursal = s.id_sucursales\n"
                        + "    AND p.id_productos = c.id_producto\n"
                        + "    AND c.id_req_coti = " + idReqCoti + " AND c.id_status_cotizacion >= 1\n"
                        + "    group by c.id_cotizacion";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    CotizacionRequisicion obj = new CotizacionRequisicion();
                    obj.setIdC(rs.getInt("COTIZACION"));
                    obj.setProveedor(rs.getString("SOLICITANTE"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setDepto(rs.getString("DEPTO"));
                    obj.setSucursal(rs.getString("SUCURSAL"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setIdP(rs.getInt("IDP"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setPrecio(rs.getInt("PRECIO"));
                    obj.setIva(rs.getInt("IVA"));
                    obj.setDescuento(rs.getInt("DESCUENTO"));
                    obj.setCredito(rs.getInt("CREDITO"));
                    obj.setEntrega(rs.getInt("ENTREGA"));
                    obj.setAnticipo(rs.getInt("ANTICIPO"));
                    obj.setStatus(rs.getInt("STATUS"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public int contarSolicitantesCoti(int idReqCoti) {
        int suma = 0;
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    COUNT(r.id_usuario) as SUMA\n"
                        + "FROM\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    cotizacion c,\n"
                        + "    proveedores pr\n"
                        + "WHERE\n"
                        + "    r.id_requisicion = rp.id_requisicion\n"
                        + "        AND rp.id_req_coti = c.id_req_coti\n"
                        + "        AND pr.idproveedor = c.id_proveedor\n"
                        + "        AND p.id_productos = c.id_producto\n"
                        + "        AND c.id_req_coti = " + idReqCoti + "";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    suma = rs.getInt("SUMA");
                }

            } catch (SQLException e) {
                System.out.println("ERROR 2 AL CONSULTAR ITEMS SQL: " + e.getMessage());
            }
        }
        return suma;
    }
}
