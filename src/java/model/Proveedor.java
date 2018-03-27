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

/**
 *
 * @author LuisMtz
 */
public class Proveedor {

    /**
     * @return the Correo
     */
    public String getCorreo() {
        return Correo;
    }

    /**
     * @param Correo the Correo to set
     */
    public void setCorreo(String Correo) {
        this.Correo = Correo;
    }

    /**
     * @return the idProveedor
     */
    public int getIdProveedor() {
        return idProveedor;
    }

    /**
     * @param idProveedor the idProveedor to set
     */
    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    /**
     * @return the Nombre
     */
    public String getNombre() {
        return Nombre;
    }

    /**
     * @param Nombre the Nombre to set
     */
    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    /**
     * @return the Apellido
     */
    public String getApellido() {
        return Apellido;
    }

    /**
     * @param Apellido the Apellido to set
     */
    public void setApellido(String Apellido) {
        this.Apellido = Apellido;
    }

    /**
     * @return the ApellidoM
     */
    public String getApellidoM() {
        return ApellidoM;
    }

    /**
     * @param ApellidoM the ApellidoM to set
     */
    public void setApellidoM(String ApellidoM) {
        this.ApellidoM = ApellidoM;
    }

    /**
     * @return the Telefono
     */
    public String getTelefono() {
        return Telefono;
    }

    /**
     * @param Telefono the Telefono to set
     */
    public void setTelefono(String Telefono) {
        this.Telefono = Telefono;
    }

    /**
     * @return the Direccion
     */
    public String getDireccion() {
        return Direccion;
    }

    /**
     * @param Direccion the Direccion to set
     */
    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    /**
     * @return the RFC
     */
    public String getRFC() {
        return RFC;
    }

    /**
     * @param RFC the RFC to set
     */
    public void setRFC(String RFC) {
        this.RFC = RFC;
    }

    /**
     * @return the Giro
     */
    public String getGiro() {
        return Giro;
    }

    /**
     * @param Giro the Giro to set
     */
    public void setGiro(String Giro) {
        this.Giro = Giro;
    }

    /**
     * @return the RazonSocial
     */
    public String getRazonSocial() {
        return RazonSocial;
    }

    /**
     * @param RazonSocial the RazonSocial to set
     */
    public void setRazonSocial(String RazonSocial) {
        this.RazonSocial = RazonSocial;
    }

    /**
     * @return the CedulaFiscal
     */
    public String getCedulaFiscal() {
        return CedulaFiscal;
    }

    /**
     * @param CedulaFiscal the CedulaFiscal to set
     */
    public void setCedulaFiscal(String CedulaFiscal) {
        this.CedulaFiscal = CedulaFiscal;
    }

    /**
     * @return the DireccionFiscal
     */
    public String getDireccionFiscal() {
        return DireccionFiscal;
    }

    /**
     * @param DireccionFiscal the DireccionFiscal to set
     */
    public void setDireccionFiscal(String DireccionFiscal) {
        this.DireccionFiscal = DireccionFiscal;
    }

    /**
     * @return the CuentaReferencia
     */
    public String getCuentaReferencia() {
        return CuentaReferencia;
    }

    /**
     * @param CuentaReferencia the CuentaReferencia to set
     */
    public void setCuentaReferencia(String CuentaReferencia) {
        this.CuentaReferencia = CuentaReferencia;
    }

    /**
     * @return the SucursalBancaria
     */
    public String getSucursalBancaria() {
        return SucursalBancaria;
    }

    /**
     * @param SucursalBancaria the SucursalBancaria to set
     */
    public void setSucursalBancaria(String SucursalBancaria) {
        this.SucursalBancaria = SucursalBancaria;
    }

    /**
     * @return the CLABE
     */
    public String getCLABE() {
        return CLABE;
    }

    /**
     * @param CLABE the CLABE to set
     */
    public void setCLABE(String CLABE) {
        this.CLABE = CLABE;
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
     * @return the Password
     */
    public String getPassword() {
        return Password;
    }

    /**
     * @param Password the Password to set
     */
    public void setPassword(String Password) {
        this.Password = Password;
    }
    private int idProveedor = 0;
    private String Nombre = "";
    private String Apellido = "";
    private String ApellidoM = "";
    private String Telefono = "";
    private String Direccion = "";
    private String RFC = "";
    private String Giro = "";
    private String RazonSocial = "";
    private String CedulaFiscal = "";
    private String DireccionFiscal = "";
    private String CuentaReferencia = "";
    private String SucursalBancaria = "";
    private String CLABE = "";
    private String usuario = "";
    private String Password = "";
    private String Correo = "";
    
    public ArrayList<Proveedor> validarProveedor(String proveedor) {
        ArrayList<Proveedor> Lista = new ArrayList<>();
        String sql = "";
        ResultSet rs = null;
        PreparedStatement ps = null;
        int Error = 0;
        Connection con = null;
        ConexionMySQL coneccion = new ConexionMySQL();
        con = coneccion.conectar();
        if (con != null) {
            sql = "SELECT idproveedor,nombre,apellido,apellidoM,telefono,direccion,rfc,giro,razonsocial,cedulaFiscal,direccionFiscal,cuentaReferencia,sucursal,clabeInterbancaria,usuario, CAST(aes_decrypt(password,'stmsc0nt')AS CHAR(50)) AS password,email FROM scompras.proveedores where usuario = ? and status = '1';";
            try {

                ps = con.prepareStatement(sql);
                ps.setString(1, proveedor);
                rs = ps.executeQuery();

                while (rs.next()) {
                    Proveedor obProveedor = new Proveedor();
                    
                    obProveedor.setIdProveedor(rs.getInt("idproveedor"));
                    obProveedor.setUsuario(rs.getString("usuario"));
                    obProveedor.setPassword(rs.getString("password"));
                    obProveedor.setNombre(rs.getString("nombre"));
                    obProveedor.setApellido(rs.getString("apellido"));
                    obProveedor.setApellidoM(rs.getString("apellidoM"));
                    obProveedor.setCorreo(rs.getString("email"));
                    obProveedor.setDireccion(rs.getString("direccion"));
                    obProveedor.setTelefono(rs.getString("telefono"));
                    obProveedor.setRazonSocial(rs.getString("razonsocial"));
                    obProveedor.setRFC(rs.getString("rfc"));
                    obProveedor.setCedulaFiscal(rs.getString("cedulaFiscal"));
                    obProveedor.setDireccionFiscal(rs.getString("direccionFiscal"));
                    obProveedor.setCuentaReferencia(rs.getString("cuentaReferencia"));
                    obProveedor.setSucursalBancaria(rs.getString("sucursal"));
                    obProveedor.setCLABE(rs.getString("clabeInterbancaria"));
                    obProveedor.setGiro(rs.getString("giro"));
                    
                    Lista.add(obProveedor);
                    obProveedor = null;
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
    
    public boolean registraProveedor(Proveedor usRegistro) {
        String sql = "";
        ResultSet rs = null;
        PreparedStatement ps = null;
        boolean status = false;
        Connection con = null;
        ConexionMySQL coneccion = new ConexionMySQL();
        con = coneccion.conectar();
        if (con != null) {
            sql = "INSERT INTO scompras.proveedores(nombre,apellido,apellidoM,telefono,direccion,rfc,razonsocial,cedulaFiscal,direccionFiscal,cuentaReferencia,sucursal,clabeInterbancaria,usuario,password,email ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,aes_encrypt(?,'stmsc0nt'),?);";
            try {
                ps = con.prepareStatement(sql);
                ps.setString(1, usRegistro.getNombre());
                ps.setString(2, usRegistro.getApellido());
                ps.setString(3, usRegistro.getApellidoM());
                ps.setString(4, usRegistro.getTelefono());
                ps.setString(5, usRegistro.getDireccion());
                ps.setString(6, usRegistro.getRFC());
                ps.setString(7, usRegistro.getRazonSocial());
                ps.setString(8, usRegistro.getCedulaFiscal());
                ps.setString(9, usRegistro.getDireccionFiscal());
                ps.setString(10, usRegistro.getCuentaReferencia());
                ps.setString(11, usRegistro.getSucursalBancaria());
                ps.setString(12, usRegistro.getCLABE());
                ps.setString(13, usRegistro.getUsuario());
                ps.setString(14, usRegistro.getPassword());
                ps.setString(15, usRegistro.getCorreo());
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
