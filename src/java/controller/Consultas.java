package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.CotizacionRequisicion;
import model.Item;
import model.OrdenFormato;
import model.Proveedor;
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
    public ArrayList<RequisicionProducto> consultarRequiGerente(String departamento, String sucursal) {
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
                        + "    AND u.id_sucursal = " + sucursal + "\n"
                        + "    AND u.id_departamento in (" + departamento + ")\n"
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
                        + "    r.id_usuario as IDSOLICITANTE,\n"
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
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdSolicita(rs.getInt("IDSOLICITANTE"));
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
     * @return menuComprasOrdenes, menuComprasRequisiciones
     */
    public ArrayList<RequisicionProducto> consultarCompras(int id_categoria, int status, String sucursal) {
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
                        + "    rp.id_producto AS IDPRODUCTO,    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    u.id_sucursal as ID_SUC,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    s.sucursal AS SUC\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    sucursales s\n"
                        + "WHERE\n"
                        + "	u.id_sucursal = s.id_sucursales\n"
                        + "    And u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND u.id_sucursal in (" + sucursal + ")\n"
                        + "    AND p.id_categoria = " + id_categoria + "\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    GROUP BY rp.id_producto, s.id_sucursales\n"
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
                    obj.setSucursal(rs.getString("SUC"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarCompras3(int id_categoria, int status, String suc) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_req_prod as IDREQPROD,\n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    rp.id_producto AS IDPRODUCTO,    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    u.id_sucursal as ID_SUC,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    s.sucursal AS SUC\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    sucursales s\n"
                        + "WHERE\n"
                        + "	u.id_sucursal = s.id_sucursales\n"
                        + "    And u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND p.id_categoria = " + id_categoria + "\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    AND u.id_sucursal in (" + suc + ")\n"
                        + "    GROUP BY rp.id_producto\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdReqProd(rs.getInt("IDREQPROD"));
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setIdProducto(rs.getInt("IDPRODUCTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setIdReqCoti(rs.getInt("COTI"));
                    obj.setSucursal(rs.getString("SUC"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarComprasCotizaciones(int id_categoria, int status, String usuario) {
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
                        + "    rp.id_producto AS IDPRODUCTO,    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    s.sucursal AS SUC\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    sucursales s\n"
                        + "WHERE\n"
                        + "	u.id_sucursal = s.id_sucursales\n"
                        + "    And u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND p.id_categoria = " + id_categoria + "\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    AND rp.usu_compras = " + usuario + "\n"
                        + "    GROUP BY rp.id_producto, s.id_sucursales\n"
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
                    obj.setSucursal(rs.getString("SUC"));
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
                        + "    p.marca AS MARCA,\n"
                        + "    u.id_usuario as IDUSU,\n"
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
                    obj.setIdSolicita(rs.getInt("IDUSU"));
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
                        + "    p.marca AS MARCA,\n"
                        + "    u.id_usuario AS IDUSU,\n"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    rp.cantidad AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    s.sucursal\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    sucursales s\n"
                        + "WHERE\n"
                        + "    s.id_sucursales = id_sucursal\n"
                        + "    AND u.id_usuario = r.id_usuario\n"
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
                    obj.setIdSolicita(rs.getInt("IDUSU"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setSucursal(rs.getString("sucursal"));
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
                        + "    c.anticipo AS ANTICIPO,\n"
                        + "    c.garantia AS GARANTIA\n"
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
                    obj.setPrecio(rs.getDouble("PRECIO"));
                    obj.setIva(rs.getDouble("IVA"));
                    obj.setDescuento(rs.getInt("DESCUENTO"));
                    obj.setCredito(rs.getInt("CREDITO"));
                    obj.setEntrega(rs.getInt("ENTREGA"));
                    obj.setAnticipo(rs.getInt("ANTICIPO"));
                    obj.setGarantia(rs.getInt("GARANTIA"));
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
                        + "		p.id_productos = c.id_producto\n"
                        + "        AND pr.idproveedor = c.id_proveedor\n"
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
                    obj.setPrecio(rs.getDouble("PRECIO"));
                    obj.setIva(rs.getDouble("IVA"));
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

    public ArrayList<RequisicionProducto> consultarComprasProv(int departamento, String status, String idProv) {
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
                        + "    rp.id_producto AS IDPRODUCTO,    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,    u.nombre AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    rp.id_status AS STATUS\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    proveedores_selec ps\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND rp.id_req_prod = ps.id_req_prod\n"
                        + "    AND ps.id_proveedor = "+idProv+"\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status in ("+status+")\n"
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

    public ArrayList<RequisicionProducto> consultarDetalleComprasProv(int idReqCoti) {
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
                        + "    u.id_departamento as DEPTO,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    rp.id_status AS STATUS,\n"
                        + "    s.sucursal AS SUC\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    sucursales s\n"
                        + "WHERE\n"
                        + "    u.id_sucursal = s.id_sucursales\n"
                        + "    AND u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_req_coti = " + idReqCoti + "\n"
                        + "    GROUP BY rp.id_producto, s.id_sucursales\n"
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
                    obj.setSucursal(rs.getString("SUC"));
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
                String sql = "select id_productos, nombre, id_categoria, serie, marca, modelo, id_unidadmedida from productos order by nombre";
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

    public ArrayList<Proveedor> consultarProveedor(int giro) {
        ArrayList<Proveedor> proveedor = new ArrayList<>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT idproveedor, razonsocial, direccion, telefono FROM scompras.proveedores where giro = " + giro + ";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Proveedor objProveedor = new Proveedor();
                    objProveedor.setIdProveedor(rs.getInt("idproveedor"));
                    objProveedor.setRazonSocial(rs.getString("razonsocial"));
                    objProveedor.setDireccion(rs.getString("direccion"));
                    objProveedor.setTelefono(rs.getString("telefono"));
                    proveedor.add(objProveedor);
                }
            } catch (SQLException e) {
                System.out.println("ERROR 2 AL CONSULTAR PROVEEDORES SQL: " + e.getMessage());
            }
        }
        return proveedor;
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
                        + "    c.garantia,\n"
                        + "    c.id_status_cotizacion AS STATUS,\n"
                        + "    c.observaciones,\n"
                        + "    c.aut_compras,\n"
                        + "    c.aut_nivel1,\n"
                        + "    c.aut_nivel2,\n"
                        + "    rp.activo_fijo as ACTIVO\n"
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
                    obj.setPrecio(rs.getDouble("PRECIO"));
                    obj.setIva(rs.getDouble("IVA"));
                    obj.setDescuento(rs.getInt("DESCUENTO"));
                    obj.setCredito(rs.getInt("CREDITO"));
                    obj.setEntrega(rs.getInt("ENTREGA"));
                    obj.setAnticipo(rs.getInt("ANTICIPO"));
                    obj.setGarantia(rs.getInt("garantia"));
                    obj.setStatus(rs.getInt("STATUS"));
                    obj.setActivo(rs.getInt("ACTIVO"));
                    obj.setObservaciones(rs.getString("observaciones"));
                    obj.setIdGerenteC(rs.getInt("aut_compras"));
                    obj.setIdGerenteA(rs.getInt("aut_nivel1"));
                    obj.setIdDirectorA(rs.getInt("aut_nivel2"));
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
                        + "    s.empresa,\n"
                        + "    u.nombre as solicitante,\n"
                        + "    u.apellido,\n"
                        + "    u.apellidoM,\n"
                        + "    d.departamento,\n"
                        + "    rp.justificacion,\n"
                        + "    r.fecha,\n"
                        + "    p.nombre as producto,\n"
                        + "    rp.cantidad,\n"
                        + "    rp.descripcion,\n"
                        + "    rp.activo_fijo,\n"
                        + "    rp.usu_gerente,\n"
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
                    obj.setEmpresa(rs.getString("empresa"));
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
                    obj.setActivo(rs.getInt("activo_fijo"));
                    obj.setGerente(rs.getInt("usu_gerente"));
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
    public ArrayList<OrdenFormato> consultarFormatoOrden(int idReqCoti, String suc) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    s.sucursal AS sucursal,\n"
                        + "    s.direccion AS direccion,\n"
                        + "    pr.idproveedor AS idP,\n"
                        + "    pr.razonsocial AS nombreP,\n"
                        + "    pr.direccion AS direccionP,\n"
                        + "    pr.telefono AS telefono,\n"
                        + "    pr.rfc AS rfc,\n"
                        + "    r.fecha AS fecha,\n"
                        + "    rp.cantidad AS cantidad,\n"
                        + "    p.nombre AS producto,\n"
                        + "    um.descripcion AS unidadM,\n"
                        + "    rp.descripcion AS descripcion,\n"
                        + "    c.id_cotizacion,\n"
                        + "    c.descuento AS descuento,\n"
                        + "    c.precio AS precio,\n"
                        + "    c.tiempoentrega,\n"
                        + "    c.diascredito,\n"
                        + "    rp.usu_compras\n"
                        + "FROM\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    cotizacion c,\n"
                        + "    productos p,\n"
                        + "    proveedores pr,\n"
                        + "    sucursales s,\n"
                        + "    usuario u,\n"
                        + "    unidadmedida um\n"
                        + "WHERE\n"
                        + "    c.id_proveedor = pr.idproveedor\n"
                        + "        AND u.id_sucursal = s.id_sucursales\n"
                        + "        and u.id_usuario = r.id_usuario\n"
                        + "        AND rp.id_req_coti = c.id_req_coti\n"
                        + "        AND r.id_requisicion = rp.id_requisicion\n"
                        + "        AND rp.id_producto = p.id_productos\n"
                        + "        AND um.id_unidadmedida = p.id_unidadmedida\n"
                        + "        AND c.id_req_coti = " + idReqCoti + "\n"
                        + "        AND s.sucursal = '" + suc + "'";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrdenFormato obj = new OrdenFormato();
                    obj.setIdCotizacion(rs.getInt("id_cotizacion"));
                    obj.setIdP(rs.getInt("idP"));
                    obj.setSucursal(rs.getString("sucursal"));
                    obj.setRfc(rs.getString("rfc"));
                    obj.setDireccion(rs.getString("direccion"));
                    obj.setNombreP(rs.getString("nombreP"));
                    obj.setDireccionP(rs.getString("direccionP"));
                    obj.setFecha(rs.getString("fecha"));
                    obj.setUnidadMedida(rs.getString("unidadM"));
                    obj.setProducto(rs.getString("producto"));
                    obj.setCantidad(rs.getInt("cantidad"));
                    obj.setDescripcion(rs.getString("descripcion"));
                    obj.setTelefonoP(rs.getString("telefono"));
                    obj.setDescuento(rs.getInt("descuento"));
                    obj.setPrecio(rs.getDouble("precio"));
                    obj.setDiasCredito(rs.getInt("diascredito"));
                    obj.setUsuCompras(rs.getInt("usu_compras"));
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
                    obj.setPrecio(rs.getDouble("PRECIO"));
                    obj.setIva(rs.getDouble("IVA"));
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

    public ArrayList<RequisicionFormato> consultarUsuario(int idUsuario) {
        ArrayList<RequisicionFormato> listaRequi = new ArrayList<RequisicionFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT nombre, apellido, apellidoM FROM scompras.usuario where id_usuario = " + idUsuario + ";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    RequisicionFormato obj = new RequisicionFormato();
                    obj.setNombre(rs.getString("nombre"));
                    obj.setApellidoP(rs.getString("apellido"));
                    obj.setApellidoM(rs.getString("apellidoM"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    /**
     * Obtiene el nombre y apellidos en una cadena 
     * @param idUsuario
     * @return nombre completo
     */
    public String consultarUsuarios(int idUsuario) {
        String usuario = " ";
        String nombre;
        String apellido1;
        String apellido2;
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT nombre, apellido, apellidoM FROM scompras.usuario where id_usuario = " + idUsuario + ";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    nombre = rs.getString("nombre");
                    apellido1 = rs.getString("apellido");
                    apellido2 = rs.getString("apellidoM");
                    usuario = nombre + " " + apellido1 + " " + apellido2;
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return usuario;
    }
    
    /**
     * Obtiene correo electronico de un usuario
     * @param idUsuario
     * @return correo
     */
    public String consultarCorreos(int idUsuario) { 
        String correo = null;
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT correo FROM scompras.usuario where id_usuario = " + idUsuario + ";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    correo = rs.getString("correo");
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return correo;
    }
    
    public String consultaArchivo(int idReeCoti, int idProv) {
        String ruta = "";
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                //String sql = "SELECT RUTA from scompras.multimedia where id_coti = '"+idReeCoti+"' and id_proveedor = '"+idProv+"';";
                String sql = "SELECT RUTAPDF from scompras.cotizacion where id_req_coti = '"+idReeCoti+"' and id_proveedor = '"+idProv+"';";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    ruta = rs.getString("RUTAPDF");
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return ruta;
    }
    
    public String consultaArchivoComp(int idReeCoti, int idCotizacion) {
        String ruta = "";
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT RUTAPDF from scompras.cotizacion where id_req_coti = '"+idReeCoti+"' and id_cotizacion = '"+idCotizacion+"';";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    ruta = rs.getString("RUTAPDF");
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return ruta;
    }

}
