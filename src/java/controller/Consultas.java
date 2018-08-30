package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import model.Comparativo;
import model.CotizacionRequisicion;
import model.Item;
import model.OrdenFormato;
import model.Precios;
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
                        + "    AND u.id_sucursal in (" + sucursal + ")\n"
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

    public ArrayList<RequisicionProducto> consultarRequiGeneral(String departamento, String sucursal) {
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
                        + "    AND u.id_sucursal in (" + sucursal + ")\n"
                        + "    AND rp.id_status = 17\n"
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

    public ArrayList<RequisicionProducto> consultarRequiGerenteAdmin(String departamento, String sucursal) {
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
                        + "    AND u.id_sucursal in (" + sucursal + ")\n"
                        + "    AND u.id_departamento in (" + departamento + ")\n"
                        + "    AND rp.id_status = 8\n"
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

    public ArrayList<RequisicionProducto> consultarDictamen(String sucursal) {
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
                        + "    AND u.id_sucursal in (" + sucursal + ")\n"
                        + "    AND rp.id_status = 2\n"
                        + "    GROUP BY rp.id_requisicion\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
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

    public ArrayList<RequisicionProducto> consultarDictamenGerente() {
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
                        + "    AND rp.id_status = 16\n"
                        + "    GROUP BY rp.id_requisicion\n"
                        + "    ORDER BY rp.id_requisicion;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
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
                        + "    p.id_productos,\n"
                        + "    p.id_categoria AS CATE,\n"
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
                    obj.setIdCategoria(rs.getInt("CATE"));
                    obj.setIdProducto(rs.getInt("id_productos"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarDetalleRequiGeneral(int id_requisicion) {
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
                        + "    p.id_categoria AS CATE,\n"
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
                        + "    AND rp.id_status = 17\n"
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
                    obj.setIdCategoria(rs.getInt("CATE"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarDetalleRequiGerenteAdmin(int id_requisicion) {
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
                        + "    p.id_categoria AS CATE,\n"
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
                        + "    AND rp.id_status = 8\n"
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
                    obj.setIdCategoria(rs.getInt("CATE"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarDetalleDictamen(int id_requisicion) {
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
                        + "    p.id_categoria AS CATE,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    rp.justificacion AS JUSTIFICACION,\n"
                        + "    rp.descripcion AS DESCRIPCION,\n"
                        + "    rp.rutaCaratula AS CARATULA,\n"
                        + "    rp.rutaDictamen AS DICTAMEN\n"
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
                        + "    AND rp.id_status = 2\n"
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
                    obj.setIdCategoria(rs.getInt("CATE"));
                    obj.setRutaCaratula(rs.getString("CARATULA"));
                    obj.setRutaDictamen(rs.getString("DICTAMEN"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarDetalleAutorizaDictamen(int id_requisicion) {
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
                        + "    p.id_productos,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,\n"
                        + "    p.id_categoria AS CATE,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    rp.justificacion AS JUSTIFICACION,\n"
                        + "    rp.descripcion AS DESCRIPCION,\n"
                        + "    rp.rutaCaratula AS CARATULA,\n"
                        + "    rp.rutaDictamen AS DICTAMEN\n"
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
                        + "    AND rp.id_status = 16\n"
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
                    obj.setIdCategoria(rs.getInt("CATE"));
                    obj.setRutaCaratula(rs.getString("CARATULA"));
                    obj.setRutaDictamen(rs.getString("DICTAMEN"));
                    obj.setIdProducto(rs.getInt("id_productos"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarHistorialGerente(String departamento, String sucursal) {
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_req_prod AS REQUISICION,\n"
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
                        + "    AND u.id_departamento in (" + departamento + ")\n"
                        + "    AND u.id_sucursal in (" + sucursal + ")\n"
                        + "    AND rp.id_status > 3\n"
                        + "ORDER BY r.fecha;";
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
                        + "    s.sucursal AS SUC,\n"
                        + "    pr.razonsocial as RZ\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    sucursales s,\n"
                        + "    proveedores pr,\n"
                        + "    cotizacion c\n"
                        + "WHERE\n"
                        + "	u.id_sucursal = s.id_sucursales\n"
                        + "    AND rp.id_req_coti = c.id_req_coti\n"
                        + "    AND c.id_proveedor = pr.idproveedor\n"
                        + "    AND c.aut_compras > 0\n"
                        + "    And u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND u.id_sucursal in (" + sucursal + ")\n"
                        + "    AND p.id_categoria = (" + id_categoria + ")\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    GROUP BY rp.id_producto, s.id_sucursales, pr.idproveedor\n"
                        + "    ORDER BY rp.id_producto;";
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
                    obj.setProveedor(rs.getString("RZ"));
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
                        + "    ORDER BY rp.id_producto;";
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

    public ArrayList<RequisicionProducto> consultarComprasCotizaciones(int id_categoria, String status, String usuario) {
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
                        + "    rp.id_status as status,\n"
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
                        + "    AND rp.id_status in (" + status + ")\n"
                        + "    AND rp.usu_compras in (" + usuario + ")\n"
                        + "    GROUP BY rp.id_producto, rp.id_status\n"
                        + "    ORDER BY rp.id_producto;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
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
                    obj.setIdStatus(rs.getInt("status"));
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
    public ArrayList<RequisicionProducto> consultarComprasRecibido(int status, int categoria, String suc) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_orden as orden,\n"
                        + "    rp.id_requisicion AS IDREQUISICION,\n"
                        + "    rp.id_producto AS IDPRODUCTO,\n"
                        + "    rp.id_req_prod AS IDREQPROD,\n"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,\n"
                        + "    u.id_usuario as IDUSU,\n"
                        + "    u.nombre as nom,\n"
                        + "    u.apellido as ape,\n"
                        + "    pr.razonsocial AS SOLICITANTE,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    rp.cantidad AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    s.sucursal as suc,\n"
                        + "    d.departamento as departamento\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    proveedores pr,\n"
                        + "    cotizacion c,\n"
                        + "    productos p,\n"
                        + "    sucursales s,\n"
                        + "    departamentos d\n"
                        + "WHERE\n"
                        + "    u.id_sucursal = s.id_sucursales\n"
                        + "    AND u.id_departamento = d.id_departamentos\n"
                        + "    AND u.id_usuario = r.id_usuario\n"
                        + "    and rp.id_cot_ganadora = c.id_cotizacion\n"
                        + "    and c.aut_compras > 0\n"
                        + "    and c.id_proveedor = pr.idproveedor\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND p.id_categoria = " + categoria + "\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    AND u.id_sucursal in (" + suc + ")\n"
                        + "    GROUP BY u.id_sucursal, rp.id_producto, pr.idproveedor, rp.id_req_prod \n"
                        + "    ORDER BY rp.id_orden;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setDescripcion(rs.getString("nom") + " " + rs.getString("ape"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setIdReqProd(rs.getInt("IDREQPROD"));
                    obj.setIdProducto(rs.getInt("IDPRODUCTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setIdSolicita(rs.getInt("IDUSU"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setIdReqCoti(rs.getInt("COTI"));
                    obj.setSucursal(rs.getString("suc"));
                    obj.setIdOrden(rs.getInt("orden"));
                    obj.setDepartamento(rs.getString("departamento"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarComprasEntregado(int status, int categoria, String suc) {
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
                        + "    rp.id_req_prod AS IDREQPROD,\n"
                        + "    rp.id_producto AS IDPRODUCTO,"
                        + "    p.nombre AS PRODUCTO,\n"
                        + "    p.marca AS MARCA,\n"
                        + "    u.id_usuario as IDUSU,\n"
                        + "    u.nombre AS SOLICITANTE,\n"
                        + "    u.apellido as AP,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    s.sucursal as SUC,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    rp.id_orden AS ORDEN\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    sucursales s,\n"
                        + "    productos p\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND u.id_sucursal = s.id_sucursales\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND p.id_categoria = " + categoria + "\n"
                        + "    AND rp.id_status = " + status + "\n"
                        + "    AND u.id_sucursal in (" + suc + ")\n"
                        + "    GROUP BY rp.id_req_prod\n"
                        + "    ORDER BY rp.id_orden, rp.id_req_prod;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setIdReqProd(rs.getInt("IDREQPROD"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setIdProducto(rs.getInt("IDPRODUCTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setIdSolicita(rs.getInt("IDUSU"));
                    obj.setSolicitante(rs.getString("SOLICITANTE") + " " + rs.getString("AP"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setIdReqCoti(rs.getInt("COTI"));
                    obj.setSucursal(rs.getString("SUC"));
                    obj.setIdOrden(rs.getInt("ORDEN"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<CotizacionRequisicion> consultarComprasAdmin(String sucursal, String categoria) {
        ArrayList<CotizacionRequisicion> listaRequi = new ArrayList<CotizacionRequisicion>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "Select\n"
                        + "pr.nombre as PROD,\n"
                        + "sum(c.cantidad) as CANT,\n"
                        + "p.razonsocial as PROV,\n"
                        + "u.nombre as NOM,\n"
                        + "u.apellido as AP,\n"
                        + "s.descripcion as STATUS\n"
                        + "from \n"
                        + "productos pr,\n"
                        + "cotizacion c,\n"
                        + "proveedores p,\n"
                        + "usuario u,\n"
                        + "req_prod rp,\n"
                        + "status s\n"
                        + "where\n"
                        + "pr.id_productos = c.id_producto\n"
                        + "and p.idproveedor = c.id_proveedor\n"
                        + "and c.id_req_coti = rp.id_req_coti\n"
                        + "and rp.id_status = s.id_status\n"
                        + "and u.id_usuario = c.aut_compras\n"
                        + "and rp.id_status in (5,6,7,8,9,10,11,12)\n"
                        + "AND u.id_sucursal in (" + sucursal + ")\n"
                        + "AND pr.id_categoria in (" + categoria + ")\n"
                        + "group by pr.nombre, p.razonsocial, u.nombre\n"
                        + "order by pr.nombre";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    CotizacionRequisicion obj = new CotizacionRequisicion();
                    obj.setProducto(rs.getString("PROD"));
                    obj.setCantidad(rs.getInt("CANT"));
                    obj.setProveedor(rs.getString("PROV"));
                    obj.setSolicitante(rs.getString("NOM") + " " + rs.getString("AP"));
                    obj.setObservaciones(rs.getString("STATUS"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarComprasDetalle(int categoria, int idProducto, String suc) {
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
                        + "    u.apellido as AP,\n"
                        + "    rp.cantidad AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    s.sucursal,\n"
                        + "    rp.rutaCaratula AS CARATULA,\n"
                        + "    rp.rutaDictamen AS DICTAMEN\n"
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
                        + "    AND u.id_sucursal in (" + suc + ")\n"
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
                    obj.setSolicitante(rs.getString("SOLICITANTE") + " " + rs.getString("AP"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setSucursal(rs.getString("sucursal"));
                    obj.setRutaCaratula(rs.getString("CARATULA"));
                    obj.setRutaDictamen(rs.getString("DICTAMEN"));
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

    public ArrayList<CotizacionRequisicion> consultarProveedorCoti2(int idReqCoti, String idProveedor) {
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
                        + "        and c.aut_compras > 0"
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

    public ArrayList<RequisicionProducto> consultarComprasProv(String categoria, String status, String idProv) {
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
                        + "    p.sku as SKU,\n"
                        + "    u.id_departamento as DEPTO,\n"
                        + "    SUM(rp.cantidad) AS CANTIDAD,\n"
                        + "    r.fecha AS FECHA,\n"
                        + "    rp.id_req_coti AS COTI,\n"
                        + "    rp.id_status AS STATUS,\n"
                        + "    rp.rutaDictamen AS DICTAMEN,\n"
                        + "    rp.fecha_coti\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    proveedores_selec ps\n"
                        + "WHERE\n"
                        + "    u.id_usuario = r.id_usuario\n"
                        + "    AND rp.id_req_prod = ps.id_req_prod\n"
                        + "    AND ps.id_proveedor = " + idProv + "\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status in (" + status + ")\n"
                        + "    AND p.id_categoria in (" + categoria + ")\n"
                        + "    GROUP BY rp.id_producto, rp.id_status\n"
                        + "    ORDER BY rp.id_producto;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("IDREQUISICION"));
                    obj.setSku(rs.getInt("SKU"));
                    obj.setIdDepto(rs.getInt("DEPTO"));
                    obj.setIdProducto(rs.getInt("IDPRODUCTO"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setMarca(rs.getString("MARCA"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setCantidad(rs.getInt("CANTIDAD"));
                    obj.setFecha(rs.getString("FECHA"));
                    obj.setIdReqCoti(rs.getInt("COTI"));
                    obj.setIdStatus(rs.getInt("STATUS"));
                    obj.setRutaDictamen(rs.getString("DICTAMEN"));
                    obj.setFecha_coti(rs.getString("fecha_coti"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarAdministracionRequisiciones(String sucursal, String categoria) {
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "r.id_req_prod as REQUISICION,\n"
                        + "concat(upper(u.nombre),' ',upper(u.apellido)) AS SOLICITANTE,\n"
                        + "d.departamento AS DEPARTAMENTO,\n"
                        + "w.sucursal AS SUCURSAL,\n"
                        + "p.nombre AS PRODUCTO,\n"
                        + "upper(r.justificacion) AS JUSTIFICACION,\n"
                        + "s.descripcion AS ESTATUS\n"
                        + "FROM scompras.req_prod r, scompras.productos p, scompras.status s, \n"
                        + "scompras.requisiciones q, scompras.usuario u, scompras.sucursales w,\n"
                        + "scompras.departamentos d\n"
                        + "WHERE \n"
                        + "s.id_status = r.id_status\n"
                        + "AND r.id_requisicion = q.id_requisicion\n"
                        + "AND p.id_productos = r.id_producto\n"
                        + "AND q.id_usuario = u.id_usuario\n"
                        + "AND w.id_sucursales = u.id_sucursal\n"
                        + "AND u.id_departamento = d.id_departamentos\n"
                        + "AND u.id_sucursal in (" + sucursal + ")\n"
                        + "AND p.id_categoria in (" + categoria + ")\n"
                        + "ORDER BY r.id_req_prod, s.descripcion, SOLICITANTE;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("REQUISICION"));
                    obj.setSolicitante(rs.getString("SOLICITANTE"));
                    obj.setDepartamento(rs.getString("DEPARTAMENTO"));
                    obj.setSucursal(rs.getString("SUCURSAL"));
                    obj.setProducto(rs.getString("PRODUCTO"));
                    obj.setJustificacion(rs.getString("JUSTIFICACION"));
                    obj.setStatus(rs.getString("ESTATUS"));

                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    /**
     * Consulta las ordenes de compra que el proveedor tiene disponible
     * agrupadas por sucursales
     *
     * @param idProv proveedor que consulta
     * @return
     */
    public ArrayList<OrdenFormato> consultarOrdenesProv(String idProv, String categoria) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    pr.razonsocial as razon,\n"
                        + "    SUM(rp.cantidad) AS cant,\n"
                        + "    s.sucursal AS suc,\n"
                        + "    s.id_sucursales as idsuc\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    cotizacion c,\n"
                        + "    sucursales s,\n"
                        + "    proveedores pr\n"
                        + "WHERE\n"
                        + "	u.id_sucursal = s.id_sucursales\n"
                        + "    and pr.idproveedor = c.id_proveedor\n"
                        + "    and c.id_req_coti = rp.id_req_coti\n"
                        + "    And u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND p.id_categoria = " + categoria + "\n"
                        + "    AND pr.idproveedor = " + idProv + "\n"
                        + "    AND rp.id_status = 10\n"
                        + "    and aut_compras > 0\n"
                        + "    GROUP BY c.id_proveedor, s.id_sucursales;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrdenFormato obj = new OrdenFormato();
                    obj.setIdP(rs.getInt("idsuc"));
                    obj.setNombreP(rs.getString("razon"));
                    obj.setCantidad(rs.getInt("cant"));
                    obj.setSucursal(rs.getString("suc"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<OrdenFormato> consultarOrdenesProvCompras(String sucursal, int cat) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_req_prod,\n"
                        + "    c.id_cotizacion as idcoti,\n"
                        + "    pr.idproveedor as prov,\n"
                        + "    pr.razonsocial as razon,\n"
                        + "    SUM(rp.cantidad) AS cant,\n"
                        + "    s.sucursal AS suc,\n"
                        + "    s.id_sucursales as idsuc,\n"
                        + "    d.departamento,\n"
                        + "    d.id_departamentos\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    cotizacion c,\n"
                        + "    sucursales s,\n"
                        + "    proveedores pr,\n"
                        + "    departamentos d\n"
                        + "WHERE\n"
                        + "	u.id_sucursal = s.id_sucursales\n"
                        + "    and pr.idproveedor = c.id_proveedor\n"
                        + "    and c.id_cotizacion = rp.id_cot_ganadora\n"
                        + "    And u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND u.id_departamento = d.id_departamentos\n"
                        + "    AND u.id_sucursal in (" + sucursal + ")\n"
                        + "    AND p.id_categoria = " + cat + "\n"
                        + "    AND rp.id_status = 10\n"
                        + "    and aut_compras > 0\n"
                        + "    and rp.id_orden = 0    \n"
                        + "    GROUP BY c.id_proveedor, s.id_sucursales, d.id_departamentos\n"
                        + "    ORDER BY c.id_proveedor, s.id_sucursales, d.id_departamentos;";
                
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrdenFormato obj = new OrdenFormato();
                    obj.setIdCotizacion(rs.getInt("idcoti"));
                    obj.setUsuCompras(rs.getInt("prov"));
                    obj.setIdP(rs.getInt("idsuc"));
                    obj.setNombreP(rs.getString("razon"));
                    obj.setCantidad(rs.getInt("cant"));
                    obj.setSucursal(rs.getString("suc"));
                    obj.setDescripcion(rs.getString("departamento"));
                    obj.setIdDepto(rs.getInt("id_departamentos"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<Comparativo> consultarCuadrosComparativos(int status) {
        ArrayList<Comparativo> listaRequi = new ArrayList<Comparativo>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select rp.id_req_prod, rp.id_cuadro, d.departamento, rp.cantidad, c.observaciones \n"
                        + "from req_prod rp, departamentos d, usuario u , requisiciones r, cotizacion c\n"
                        + "where u.id_usuario = r.id_usuario\n"
                        + "and r.id_requisicion = rp.id_requisicion\n"
                        + "and u.id_departamento = d.id_departamentos\n"
                        + "and c.id_cotizacion = rp.id_cot_ganadora \n"
                        + "and rp.id_status = "+status+";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Comparativo obj = new Comparativo();
                    obj.setIdReqProd(rs.getInt("rp.id_req_prod"));
                    obj.setIdCuadro(rs.getInt("rp.id_cuadro"));
                    obj.setDepartamento(rs.getString("d.departamento"));
                    obj.setCantidad(rs.getInt("rp.cantidad"));
                    obj.setObservaciones(rs.getString("c.observaciones"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }
    
    public ArrayList<Integer> consultarRequisCuadrosComparativos(int idCuadro) {
        ArrayList<Integer> requis = new ArrayList<Integer>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select id_req_prod from req_prod where id_cuadro = "+idCuadro+"";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    requis.add(rs.getInt("id_req_prod"));
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return requis;
    }

    public ArrayList<OrdenFormato> consultarOrdenesProvComprasHist(String suc, int cat) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    o.razonSocialProveedor,\n"
                        + "    SUM(o.cantidadProducto) AS cant,\n"
                        + "    o.razonSocialSucursal,\n"
                        + "    o.departamento,\n"
                        + "    o.idCotizacionOrden,\n"
                        + "    o.fechaOrden\n"
                        + " FROM\n"
                        + "    scompras.ordenes_compra o,\n"
                        + "    scompras.productos p\n"
                        + " WHERE\n"
                        + "  idSucursal IN ('"+ suc +"')\n"
                        + "    AND idCotizacionOrden > 0\n"
                        + "    AND idCotizacionOrden NOT IN ('2' , '3', '4', '5')\n"
                        + "    AND o.nombreProducto = p.nombre\n"
                        + "    AND p.id_categoria = "+ cat +"\n"
                        + " GROUP BY idCotizacionOrden\n"
                        + " ORDER BY idCotizacionOrden DESC;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrdenFormato obj = new OrdenFormato();
                    obj.setNombreP(rs.getString("razonSocialProveedor"));
                    obj.setCantidad(rs.getInt("cant"));
                    obj.setSucursal(rs.getString("razonSocialSucursal"));
                    obj.setDepto(rs.getString("departamento"));
                    obj.setIdOrden(rs.getInt("idCotizacionOrden"));
                    obj.setFecha(rs.getString("fechaOrden"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<OrdenFormato> consultarOrdenesProvContabilidad(String razon) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT id_sucursales, razonSocialProveedor, sum(cantidadProducto) as cant, razonSocialSucursal, departamento,\n"
                        + "idCotizacionOrden, fechaOrden FROM scompras.ordenes_compra, sucursales where sucursal = razonSocialSucursal\n"
                        + "and id_sucursales in (" + razon + ")\n"
                        + "group by idCotizacionOrden order by fechaOrden desc;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrdenFormato obj = new OrdenFormato();
                    obj.setNombreP(rs.getString("razonSocialProveedor"));
                    obj.setCantidad(rs.getInt("cant"));
                    obj.setSucursal(rs.getString("razonSocialSucursal"));
                    obj.setDepto(rs.getString("departamento"));
                    obj.setIdOrden(rs.getInt("idCotizacionOrden"));
                    obj.setFecha(rs.getString("fechaOrden"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<OrdenFormato> consultarOrdenesProvHist(String proveedor) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT razonSocialProveedor, sum(cantidadProducto) as cant, razonSocialSucursal, departamento,"
                        + " idCotizacionOrden, fechaOrden FROM scompras.ordenes_compra where idProveedor = " + proveedor + " "
                        + "and idCotizacionOrden > 0 and idCotizacionOrden not in ('2','3','4','5') "
                        + "group by idCotizacionOrden order by idCotizacionOrden desc;";
                
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrdenFormato obj = new OrdenFormato();
                    obj.setNombreP(rs.getString("razonSocialProveedor"));
                    obj.setCantidad(rs.getInt("cant"));
                    obj.setSucursal(rs.getString("razonSocialSucursal"));
                    obj.setDepto(rs.getString("departamento"));
                    obj.setIdP(rs.getInt("idCotizacionOrden"));
                    obj.setFecha(rs.getString("fechaOrden"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarProdEnvio(int orden) {
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select rp.id_req_prod as req, rp.id_status as status, o.rutaFactura from req_prod rp, cotizacion c, ordenes_compra o\n"
                        + "where rp.id_cot_ganadora = c.id_cotizacion\n"
                        + "and rp.id_orden = o.idCotizacionOrden\n"
                        + "and o.idCotizacionOrden = " + orden + " and o.idCotizacionOrden > 0\n"
                        + "and o.idCotizacionOrden not in ('2','3','4','5')";

                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdStatus(rs.getInt("status"));
                    obj.setIdReqProd(rs.getInt("req"));
                    obj.setRutaFactura(rs.getString("rutaFactura"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<OrdenFormato> consultarOrdenesProvAcum(int idProv, int idSuc, int cat, int idDep) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "s.sucursal AS sucursal,\n"
                        + "    s.direccion AS direccion,\n"
                        + "    pr.idproveedor AS idP,\n"
                        + "    pr.razonsocial AS nombreP,\n"
                        + "    pr.direccion AS direccionP,\n"
                        + "    pr.telefono AS telefono,\n"
                        + "    s.rfc AS rfc,\n"
                        + "    c.fecha_aut_compras AS fecha,\n"
                        + "    sum(rp.cantidad) AS cantidad,\n"
                        + "    p.nombre AS producto,\n"
                        + "    p.sku AS sku,\n"
                        + "    um.descripcion AS unidadM,\n"
                        + "    rp.descripcion AS descripcion,\n"
                        + "    c.id_cotizacion,\n"
                        + "    c.descuento AS descuento,\n"
                        + "    c.precio AS precio,\n"
                        + "    c.tiempoentrega,\n"
                        + "    c.diascredito,\n"
                        + "    rp.usu_compras,\n"
                        + "    u.id_departamento,\n"
                        + "    s.id_sucursales,\n"
                        + "    d.departamento\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    cotizacion c,\n"
                        + "    sucursales s,\n"
                        + "    proveedores pr,\n"
                        + "    unidadmedida um,\n"
                        + "    departamentos d\n"
                        + "WHERE\n"
                        + "u.id_sucursal = s.id_sucursales\n"
                        + "    AND um.id_unidadmedida = p.id_unidadmedida\n"
                        + "    and pr.idproveedor = c.id_proveedor\n"
                        + "    and c.id_req_coti = rp.id_req_coti\n"
                        + "    And u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND u.id_departamento = d.id_departamentos"
                        + "    AND p.id_categoria = " + cat + "\n"
                        + "    AND pr.idproveedor = " + idProv + "\n"
                        + "    AND u.id_sucursal = " + idSuc + "\n"
                        + "    AND u.id_departamento = " + idDep + "\n"
                        + "    AND rp.id_status = 10\n"
                        + "    and rp.id_orden = 0\n"
                        + "    and aut_compras > 0\n"
                        + "    group by p.nombre";

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
                    obj.setDepto(rs.getString("departamento"));
                    obj.setIdSucursal(rs.getInt("id_sucursales"));
                    obj.setSku(rs.getString("sku"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public ArrayList<RequisicionProducto> consultarOrdenesProvAcumDetalle(int idProv, int idSuc, int cat, int idDep) {
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "	rp.id_req_prod,\n"
                        + "    (rp.cantidad*(c.precio + c.iva)) as precio,\n"
                        + "    rp.id_cuadro,\n"
                        + "    c.id_cotizacion as idcoti,\n"
                        + "    c.id_req_coti as idreqcoti,\n"
                        + "    u.nombre as nombre,\n"
                        + "    rp.cantidad AS cant,\n"
                        + "    p.nombre as prod\n"
                        + "FROM\n"
                        + "    usuario u,\n"
                        + "    requisiciones r,\n"
                        + "    req_prod rp,\n"
                        + "    productos p,\n"
                        + "    cotizacion c,\n"
                        + "    sucursales s,\n"
                        + "    proveedores pr,\n"
                        + "    departamentos d\n"
                        + "WHERE\n"
                        + "	u.id_sucursal = s.id_sucursales\n"
                        + "    and pr.idproveedor = c.id_proveedor\n"
                        + "    and c.id_cotizacion = rp.id_cot_ganadora\n"
                        + "    And u.id_usuario = r.id_usuario\n"
                        + "    AND r.id_requisicion = rp.id_requisicion\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND u.id_departamento = d.id_departamentos\n"
                        + "    AND u.id_sucursal in (" + idSuc + ")\n"
                        + "    and d.id_departamentos = " + idDep + "\n"
                        + "    AND p.id_categoria = " + cat + "\n"
                        + "    AND pr.idproveedor = " + idProv + "\n"
                        + "    AND rp.id_status = 10\n"
                        + "    and rp.id_orden = 0    \n"
                        + "    group by rp.id_req_prod, c.id_proveedor, s.id_sucursales, d.id_departamentos    \n"
                        + "    ORDER BY c.id_proveedor, s.id_sucursales, d.id_departamentos;";
                
                
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setPrecio(rs.getDouble("precio"));
                    obj.setIdReqProd(rs.getInt("id_req_prod"));
                    obj.setIdReqCoti(rs.getInt("idreqcoti"));
                    obj.setSolicitante(rs.getString("nombre"));
                    obj.setCantidad(rs.getInt("cant"));
                    obj.setProducto(rs.getString("prod"));
                    obj.setIdCuadro(rs.getInt("id_cuadro"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public int consultarCantidadCot(int reqProd) {
        int total = 0;
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select count(c.id_req_coti) as total from cotizacion c, req_prod r where r.id_req_coti = c.id_req_coti "
                        + "and r.id_req_prod = " + reqProd + "";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    total = rs.getInt("total");
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return total;
    }

    public ArrayList<Integer> consultarProvSelec(int reqProd) {
        ArrayList<Integer> res = new ArrayList<Integer>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select id_proveedor from proveedores_selec where id_req_prod = " + reqProd + "";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    res.add(rs.getInt("id_proveedor"));
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return res;
    }

    public ArrayList<OrdenFormato> consultarOrdenesFinal(int idOrden) {
        ArrayList<OrdenFormato> listaRequi = new ArrayList<OrdenFormato>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select * from scompras.ordenes_compra where idCotizacionOrden = " + idOrden + "";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrdenFormato obj = new OrdenFormato();
                    obj.setIdCotizacion(rs.getInt("idCotizacionOrden"));
                    obj.setIdP(rs.getInt("idProveedor"));
                    obj.setSucursal(rs.getString("razonSocialSucursal"));
                    obj.setRfc(rs.getString("rfcSucursal"));
                    obj.setDireccion(rs.getString("direccionSucursal"));
                    obj.setNombreP(rs.getString("razonSocialProveedor"));
                    obj.setDireccionP(rs.getString("direccionProveedor"));
                    obj.setFecha(rs.getString("fechaOrden"));
                    obj.setUnidadMedida(rs.getString("unidadMedidaProducto"));
                    obj.setProducto(rs.getString("nombreProducto"));
                    obj.setCantidad(rs.getInt("cantidadProducto"));
                    obj.setTelefonoP(rs.getString("telefonoProveedor"));
                    obj.setDescuento(rs.getInt("descuentoCotizacion"));
                    obj.setPrecio(rs.getDouble("costoUnitarioCotizacion"));
                    obj.setCompras(rs.getString("nombreCompras"));
                    obj.setDepto(rs.getString("departamento"));
                    obj.setSku(rs.getString("sku"));
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

    public ArrayList<Item> consultarItems(int categoria) {
        ArrayList<Item> items = new ArrayList<>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select id_productos, nombre, id_categoria, serie, marca, modelo, id_unidadmedida from productos where id_categoria = " + categoria + " order by nombre";
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
    
    public Precios consultaItemsCotizacion(int idProducto, int idProveedor) {
        Precios Precio = new Precios();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT * FROM scompras.precios where idProducto = "+idProducto+" and idProveedor = "+idProveedor+";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Precio.setPrecio(rs.getDouble("precioUnitario"));
                    Precio.setDiasCredito(rs.getInt("diasCredito"));
                    Precio.setTiempoEntrega(rs.getInt("tiempoEntrega"));
                    Precio.setGarantia(rs.getInt("tiempoEntrega"));
                    Precio.setDescuento(rs.getInt("descuento"));
                    Precio.setAnticipo(rs.getInt("anticipo"));
                }

            } catch (SQLException e) {
                System.out.println("ERROR 2 AL CONSULTAR PRECIOS - ITEMS SQL: " + e.getMessage());
            }
        }
        return Precio;
    }

    public ArrayList<CotizacionRequisicion> consultarCotizacionesCuadro(int idReqProd) {
        ArrayList<CotizacionRequisicion> listaRequi = new ArrayList<CotizacionRequisicion>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT\n"
                        + "c.id_cotizacion AS COTIZACION,\n"
                        + "pr.razonsocial AS PROVEEDOR,\n"
                        + "d.departamento AS DEPTO,\n"
                        + "s.sucursal AS SUCURSAL,\n"
                        + "r.fecha AS FECHA,\n"
                        + "p.nombre AS PRODUCTO,\n"
                        + "c.id_proveedor AS IDP,\n"
                        + "c.cantidad AS CANTIDAD,\n"
                        + "c.precio AS PRECIO,\n"
                        + "c.iva AS IVA,\n"
                        + "c.descuento AS DESCUENTO,\n"
                        + "c.diascredito AS CREDITO,\n"
                        + "c.tiempoentrega AS ENTREGA,\n"
                        + "c.anticipo AS ANTICIPO,\n"
                        + "c.garantia,\n"
                        + "c.id_status_cotizacion AS STATUS,\n"
                        + "c.observaciones,\n"
                        + "c.aut_compras,\n"
                        + "c.aut_nivel1,\n"
                        + "c.aut_nivel2,\n"
                        + "rp.activo_fijo as ACTIVO\n"
                        + "FROM\n"
                        + "usuario u,\n"
                        + "productos p,\n"
                        + "cotizacion c,\n"
                        + "req_prod rp,\n"
                        + "requisiciones r,\n"
                        + "departamentos d,\n"
                        + "sucursales s,\n"
                        + "proveedores pr\n"
                        + "WHERE\n"
                        + "pr.idproveedor = c.id_proveedor\n"
                        + "AND rp.id_req_coti = c.id_req_coti\n"
                        + "AND r.id_requisicion = rp.id_requisicion\n"
                        + "AND r.id_usuario = u.id_usuario\n"
                        + "AND u.id_departamento = d.id_departamentos\n"
                        + "AND u.id_sucursal = s.id_sucursales\n"
                        + "AND p.id_productos = c.id_producto\n"
                        + "AND id_req_prod = " + idReqProd + "\n"
                        + "group by c.id_cotizacion";
                
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    CotizacionRequisicion obj = new CotizacionRequisicion();
                    obj.setIdC(rs.getInt("COTIZACION"));
                    obj.setProveedor(rs.getString("PROVEEDOR"));
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

    public ArrayList<CotizacionRequisicion> consultarCotizacionesCuadroAdmin(int status, int cuadro) {
        ArrayList<CotizacionRequisicion> listaRequi = new ArrayList<CotizacionRequisicion>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT\n"
                        + "c.id_cotizacion AS COTIZACION,\n"
                        + "pr.razonsocial AS PROVEEDOR,\n"
                        + "d.departamento AS DEPTO,\n"
                        + "s.sucursal AS SUCURSAL,\n"
                        + "r.fecha AS FECHA,\n"
                        + "p.nombre AS PRODUCTO,\n"
                        + "c.id_proveedor AS IDP,\n"
                        + "c.cantidad AS CANTIDAD,\n"
                        + "c.precio AS PRECIO,\n"
                        + "c.iva AS IVA,\n"
                        + "c.descuento AS DESCUENTO,\n"
                        + "c.diascredito AS CREDITO,\n"
                        + "c.tiempoentrega AS ENTREGA,\n"
                        + "c.anticipo AS ANTICIPO,\n"
                        + "c.garantia,\n"
                        + "c.id_status_cotizacion AS STATUS,\n"
                        + "c.observaciones,\n"
                        + "c.aut_compras,\n"
                        + "c.aut_nivel1,\n"
                        + "c.aut_nivel2,\n"
                        + "rp.activo_fijo as ACTIVO,\n"
                        + "rp.id_cot_ganadora,\n"
                        + "rp.id_cuadro,\n"
                        + "rp.id_cot_ganadora\n"
                        + "FROM\n"
                        + "usuario u,\n"
                        + "productos p,\n"
                        + "cotizacion c,\n"
                        + "req_prod rp,\n"
                        + "requisiciones r,\n"
                        + "departamentos d,\n"
                        + "sucursales s,\n"
                        + "proveedores pr,\n"
                        + "comparativos co\n"
                        + "WHERE\n"
                        + "pr.idproveedor = c.id_proveedor\n"
                        + "AND rp.id_req_coti = c.id_req_coti\n"
                        + "AND r.id_requisicion = rp.id_requisicion\n"
                        + "AND r.id_usuario = u.id_usuario\n"
                        + "AND u.id_departamento = d.id_departamentos\n"
                        + "AND u.id_sucursal = s.id_sucursales\n"
                        + "AND p.id_productos = c.id_producto\n"
                        + "and c.id_cotizacion = co.idcotizacion\n"
                        + "and co.idcuadro = rp.id_cuadro\n"
                        + "AND rp.id_status = "+status+"\n"
                        + "and rp.id_cuadro = "+cuadro+"\n"
                        + "group by c.id_cotizacion";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    CotizacionRequisicion obj = new CotizacionRequisicion();
                    obj.setIdC(rs.getInt("COTIZACION"));
                    obj.setProveedor(rs.getString("PROVEEDOR"));
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
                    obj.setIdGanadora(rs.getInt("id_cot_ganadora"));
                    listaRequi.add(obj);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return listaRequi;
    }

    public int consultarProveedorGanador(int IdCotizacion) {
        int prov = 0;
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select id_proveedor from cotizacion where id_cotizacion = "+IdCotizacion+";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    prov = rs.getInt("id_proveedor");
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return prov;
    }
    
    public String consultarNombreProveedor(int IdProveedor) {
        String prov = " ";
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select razonsocial from proveedores where idproveedor = "+IdProveedor+";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    prov = rs.getString("razonsocial");
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return prov;
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
                        + "    rp.fecha_usu_gerente,\n"
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
                    obj.setFechaAut(rs.getString("fecha_usu_gerente"));
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
                        + "    s.rfc AS rfc,\n"
                        + "    r.fecha AS fecha,\n"
                        + "    sum(rp.cantidad) AS cantidad,\n"
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
                        + "        and aut_compras > 0\n"
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
     *
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
     *
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
                String sql = "SELECT RUTAPDF from scompras.cotizacion where id_req_coti = '" + idReeCoti + "' and id_proveedor = '" + idProv + "';";
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
                String sql = "SELECT RUTAPDF from scompras.cotizacion where id_req_coti = '" + idReeCoti + "' and id_cotizacion = '" + idCotizacion + "';";
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

    /**
     * Obvio, consulta la jodida ruta de la factura
     *
     * @param idOrden
     * 
     */
    public String consultaRutaFactura(int idOrden) {
        String ruta = "";
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "select rutaFactura from scompras.ordenes_compra WHERE idCotizacionOrden = '" + idOrden + "'";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    ruta = rs.getString("rutaFactura");
                }
            } catch (SQLException ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
        }
        return ruta;
    }
    
    /**
     * Regitra el historial de entregas
     *
     * @param idReqProd
     * @param idCompras
     * @param idUsuario
     * @param fehaEntregaCompras
     * 
     */
    public void insertaEntregaCompras(int idReqProd, int idCompras, int idUsuario, Timestamp fechaEntregaCompras){
        String ruta = "";
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        String sql = "";
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                sql = "INSERT INTO scompras.entregas (id_req_prod,idCompras,idUsuario,fechaEntregaCompras) VALUES (?,?,?,?);";
                ps = con.prepareStatement(sql);
                ps.setInt(1, idReqProd);
                ps.setInt(2, idCompras);
                ps.setInt(3, idUsuario);
                ps.setTimestamp(4, fechaEntregaCompras);
                ps.executeUpdate();
                con.close();
            } catch (SQLException e) {
                System.out.println("ERROR SQL-1 " + e.getSQLState() + ": " + e.getMessage());
            } 
        }
    }
}
