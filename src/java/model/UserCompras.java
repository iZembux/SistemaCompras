/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import controller.ConexionMySQL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author LuisMtz
 */
public class UserCompras {

    /**
     * @return the correo
     */
    public String getCorreo() {
        return correo;
    }

    /**
     * @param correo the correo to set
     */
    public void setCorreo(String correo) {
        this.correo = correo;
    }

    /**
     * @return the usuario
     */
    public String getUsuario() {
        return usuario;
    }

    /**
     * @param usuario the usuario to set
     */
    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    /**
     * @return the apellido
     */
    public String getApellido() {
        return apellido;
    }

    /**
     * @param apellido the apellido to set
     */
    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    /**
     * @return the apellidoM
     */
    public String getApellidoM() {
        return apellidoM;
    }

    /**
     * @param apellidoM the apellidoM to set
     */
    public void setApellidoM(String apellidoM) {
        this.apellidoM = apellidoM;
    }

    /**
     * @return the idUsrCompras
     */
    public Integer getIdUsrCompras() {
        return idUsrCompras;
    }

    /**
     * @param idUsrCompras the idUsrCompras to set
     */
    public void setIdUsrCompras(Integer idUsrCompras) {
        this.idUsrCompras = idUsrCompras;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the id_departamento
     */
    public String getId_departamento() {
        return id_departamento;
    }

    /**
     * @param id_departamento the id_departamento to set
     */
    public void setId_departamento(String id_departamento) {
        this.id_departamento = id_departamento;
    }

    /**
     * @return the id_rol
     */
    public String getId_rol() {
        return id_rol;
    }

    /**
     * @param id_rol the id_rol to set
     */
    public void setId_rol(String id_rol) {
        this.id_rol = id_rol;
    }

    /**
     * @return the id_sucursal
     */
    public String getId_sucursal() {
        return id_sucursal;
    }

    /**
     * @param id_sucursal the id_sucursal to set
     */
    public void setId_sucursal(String id_sucursal) {
        this.id_sucursal = id_sucursal;
    }

    /**
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_usuario")
    private Integer idUsrCompras;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "password")
    private String password;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "id_departamento")
    private String id_departamento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "id_rol")
    private String id_rol;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_sucursal")
    private String id_sucursal;
    @Basic(optional = false)
    @NotNull
    @Column(name = "status")
    private int status;
    private String usuario;
    private String apellido;
    private String apellidoM;
    private String correo;
    
    public ArrayList<UserCompras> validarUsuario(String usuario) {
        ArrayList<UserCompras> Lista = new ArrayList<>();
        String sql = "";
        ResultSet rs = null;
        PreparedStatement ps = null;
        int Error = 0;
        Connection con = null;
        ConexionMySQL coneccion = new ConexionMySQL();
        con = coneccion.conectar();
        if (con != null) {
            sql = "SELECT id_usuario, usuario, nombre, apellido, apellidoM, correo, id_departamento, id_rol, id_sucursal, CAST(aes_decrypt(password,'stmsc0nt')AS CHAR(50)) AS password FROM scompras.usuario where usuario = ? and status = '1';";
            try {

                ps = con.prepareStatement(sql);
                ps.setString(1, usuario);
                rs = ps.executeQuery();

                while (rs.next()) {
                    UserCompras objUsuario = new UserCompras();
                    objUsuario.setIdUsrCompras(rs.getInt("id_usuario"));
                    objUsuario.setUsuario(rs.getString("usuario"));
                    objUsuario.setNombre(rs.getString("nombre"));
                    objUsuario.setApellido(rs.getString("apellido"));
                    objUsuario.setApellidoM(rs.getString("apellidoM"));
                    objUsuario.setCorreo(rs.getString("correo"));
                    objUsuario.setPassword(rs.getString("password"));
                    objUsuario.setId_sucursal(rs.getString("id_sucursal"));
                    objUsuario.setId_departamento(rs.getString("id_departamento"));
                    Lista.add(objUsuario);
                    objUsuario = null;
                }
                con.close();
            } catch (SQLException e) {
                System.out.println("ERROR SQL-1 " + e.getSQLState() + ": " + e.getMessage());
                Error++;
            } finally {
                try {
                    if (ps != null) {
                        ps.close();
                    }
                    if (rs != null) {
                        rs.close();
                    }
                    ps = null;
                    rs = null;
                    con.close();
                } catch (SQLException ee) {
                    System.out.println("SQL ERROR-2 " + ee.getSQLState() + ee.getMessage());
                    Error++;
                }
            }
        } else {
            System.out.println("CONECCION FAIL");
            return Lista;
        }
        return Lista;
    }
    
    public boolean registraUsuario(UserCompras usRegistro) {
        String sql = "";
        ResultSet rs = null;
        PreparedStatement ps = null;
        boolean status = false;
        Connection con = null;
        ConexionMySQL coneccion = new ConexionMySQL();
        con = coneccion.conectar();
        if (con != null) {
            sql = "INSERT INTO scompras.usuario(usuario,nombre,apellido,apellidoM,correo,id_departamento,id_sucursal,password) VALUES (?,?,?,?,?,?,?,aes_encrypt(?,'stmsc0nt'));";
            try {
                ps = con.prepareStatement(sql);
                ps.setString(1, usRegistro.getUsuario().toString());
                ps.setString(2, usRegistro.getNombre());
                ps.setString(3, usRegistro.getApellido());
                ps.setString(4, usRegistro.getApellidoM());
                ps.setString(5, usRegistro.getCorreo());
                ps.setString(6, usRegistro.getId_departamento());
                ps.setString(7, usRegistro.getId_sucursal());
                ps.setString(8, usRegistro.getPassword());
                ps.executeUpdate();
                con.close();
                status = true;
            } catch (SQLException e) {
                System.out.println("ERROR SQL-1 " + e.getSQLState() + ": " + e.getMessage());
            }
        } else {
            System.out.println("CONECCION FAIL");
            status = false;
        }
        return status;
    }
}