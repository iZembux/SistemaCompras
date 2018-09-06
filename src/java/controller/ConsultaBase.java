/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.Categorias;
import model.Departamentos;
import model.Sucursales;

/**
 *
 * @author LuisMtz
 */
public class ConsultaBase {
    
    
    public ArrayList<Categorias> obtieneCategorias(){
        
        ArrayList<Categorias> ktgorias = new ArrayList<Categorias>();
        String sql = "";
        Connection con = null;
        ConexionMySQL coneccion = new ConexionMySQL();
        con = coneccion.conectar();
        Statement s;
        ResultSet rs;
        PreparedStatement ps;
        if (con != null) {
            try {
                sql = "SELECT * FROM scompras.categorias;";

                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                   Categorias categorias = new Categorias();
                   categorias.setId_categoria(rs.getInt("id_categoria"));
                   categorias.setDescripcion(rs.getString("descripcion"));
                   categorias.setStatus(rs.getInt("status"));
                   
                   ktgorias.add(categorias);
                   categorias = null;
                }
                con.close();
            } catch (Exception e) {
                System.out.println("QUERY NO EJECUTADO: " + e.getMessage());
            }
        }
        return ktgorias;
    }
    
    public ArrayList<Departamentos> obtieneDepartamentos(){
        
        
        ArrayList<Departamentos> dptos = new ArrayList<Departamentos>();
        String sql = "";
        Connection con = null;
        ConexionMySQL coneccion = new ConexionMySQL();
        con = coneccion.conectar();
        Statement s;
        ResultSet rs;
        PreparedStatement ps;
        if (con != null) {
            try {
                sql = "SELECT id_departamentos, upper(departamento) as departamento FROM scompras.departamentos;";

                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    Departamentos departamentos = new Departamentos();
                    departamentos.setId_departamentos(rs.getInt("id_departamentos"));
                    departamentos.setDepartamento(rs.getString("departamento"));
                    
                    dptos.add(departamentos);
                    departamentos = null;
                }
                con.close();
            } catch (Exception e) {
                System.out.println("QUERY NO EJECUTADO: " + e.getMessage());
            }
        }
        return dptos;
    }
    
    public ArrayList<Sucursales> obtieneSucursales(){
        ArrayList<Sucursales> sucursales = new ArrayList<Sucursales>();
        String sql = "";
        Connection con = null;
        ConexionMySQL coneccion = new ConexionMySQL();
        con = coneccion.conectar();
        Statement s;
        ResultSet rs;
        PreparedStatement ps;
        if (con != null) {
            try {
                sql = "SELECT id_sucursales, upper(sucursal) as sucursal FROM scompras.sucursales;";

                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    Sucursales sucursal = new Sucursales();
                    sucursal.setId_sucursales(rs.getInt("id_sucursales"));
                    sucursal.setSucursal(rs.getString("sucursal"));
                    
                    sucursales.add(sucursal);
                    sucursal = null;
                }
                con.close();
            } catch (Exception e) {
                System.out.println("QUERY NO EJECUTADO: " + e.getMessage());
            }
        }
        return sucursales;
    }
    
    public String obtieneDepartamento(int idDpto){
        
        String departamento = "";
        String sql = "";
        Connection con = null;
        ConexionMySQL coneccion = new ConexionMySQL();
        con = coneccion.conectar();
        Statement s;
        ResultSet rs;
        PreparedStatement ps;
        if (con != null) {
            try {
                sql = "SELECT upper(departamento) as departamento FROM scompras.departamentos WHERE id_departamentos = "+idDpto+";";

                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    departamento = rs.getString("departamento");
                }
                con.close();
            } catch (Exception e) {
                System.out.println("QUERY NO EJECUTADO: " + e.getMessage());
            }
        }
        return departamento;
    }
    
    public String convierteJson(ArrayList a){
        Gson gson = new Gson();
        String json = gson.toJson(a);
        return json;
    }
    
}
