package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Item;
import model.RequisicionProducto;

public class Consultas {

    public ArrayList<RequisicionProducto> consultarRequiGerente(int departamento) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
                        + "    rp.id_reqprod,\n"
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
                        + "    AND r.id_requisicion = rp.id_reqprod\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND u.id_departamento = " + departamento + "\n"
                        + "    AND rp.id_status = 3\n"
                        + "    GROUP BY rp.id_reqprod\n"
                        + "    ORDER BY rp.id_reqprod;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setIdRequisicion(rs.getInt("id_reqprod"));
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
                        + "    AND r.id_requisicion = rp.id_reqprod\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    and r.id_requisicion = " + id_requisicion + "\n"
                        + "    AND rp.id_status = 3\n"
                        + "    group by rp.id_producto;";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
                    obj.setProducto(rs.getString("PRODUCTO"));
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

    public ArrayList<RequisicionProducto> consultarHistorialGerente(int departamento) {
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
                        + "    AND r.id_requisicion = rp.id_reqprod\n"
                        + "    AND p.id_productos = rp.id_producto\n"
                        + "    AND rp.id_status = s.id_status\n"
                        + "    AND u.id_departamento = "+departamento+"\n"
                        + "    AND rp.id_status IN (12 , 13)\n"
                        + "ORDER BY rp.id_reqprod;";
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

    public ArrayList<RequisicionProducto> consultarStatusProducto(int id_usuario) {
        int cont = 0;
        ArrayList<RequisicionProducto> listaRequi = new ArrayList<RequisicionProducto>();
        PreparedStatement ps;
        ResultSet rs;
        Connection con;
        con = ConexionMySQL.conectar();
        if (con != null) {
            try {
                String sql = "SELECT \n"
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
                        + "        AND r.id_requisicion = rp.id_reqprod\n"
                        + "        AND p.id_productos = rp.id_producto\n"
                        + "        AND rp.id_status =  s.id_status\n"
                        + "        AND u.id_usuario = " + id_usuario + ";";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    cont++;
                    RequisicionProducto obj = new RequisicionProducto();
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
}
