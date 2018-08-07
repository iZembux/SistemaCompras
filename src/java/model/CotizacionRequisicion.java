/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

public class CotizacionRequisicion {

    private String proveedor;
    private String solicitante;
    private String producto;
    private String depto;
    private String sucursal;
    private String fecha;
    private String observaciones;
    private int cantidad;
    private double precio;
    private double iva;
    private int descuento;
    private int credito;
    private int entrega;
    private int anticipo;
    private int garantia;
    private int idP;
    private int idC;
    private int status;
    private int activo;
    private int idGerenteC = 0;
    private int idGerenteA = 0;
    private int idDirectorA = 0;
    private int idDirectorG = 0;
    private int idGanadora;

    /**
     * @return the proveedor
     */
    public String getProveedor() {
        return proveedor;
    }

    /**
     * @param proveedor the proveedor to set
     */
    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    /**
     * @return the producto
     */
    public String getProducto() {
        return producto;
    }

    /**
     * @param producto the producto to set
     */
    public void setProducto(String producto) {
        this.producto = producto;
    }

    /**
     * @return the canidad
     */
    public int getCantidad() {
        return cantidad;
    }

    /**
     * @param cantidad the canidad to set
     */
    public void setCantidad(int canidad) {
        this.cantidad = canidad;
    }

    /**
     * @return the precio
     */
    public double getPrecio() {
        return precio;
    }

    /**
     * @param precio the precio to set
     */
    public void setPrecio(double precio) {
        this.precio = precio;
    }

    /**
     * @return the iva
     */
    public double getIva() {
        return iva;
    }

    /**
     * @param iva the iva to set
     */
    public void setIva(double iva) {
        this.iva = iva;
    }

    /**
     * @return the descuento
     */
    public int getDescuento() {
        return descuento;
    }

    /**
     * @param descuento the descuento to set
     */
    public void setDescuento(int descuento) {
        this.descuento = descuento;
    }

    /**
     * @return the credito
     */
    public int getCredito() {
        return credito;
    }

    /**
     * @param credito the credito to set
     */
    public void setCredito(int credito) {
        this.credito = credito;
    }

    /**
     * @return the entrega
     */
    public int getEntrega() {
        return entrega;
    }

    /**
     * @param entrega the entrega to set
     */
    public void setEntrega(int entrega) {
        this.entrega = entrega;
    }

    /**
     * @return the anticipo
     */
    public int getAnticipo() {
        return anticipo;
    }

    /**
     * @param anticipo the anticipo to set
     */
    public void setAnticipo(int anticipo) {
        this.anticipo = anticipo;
    }

    /**
     * @return the idP
     */
    public int getIdP() {
        return idP;
    }

    /**
     * @param idP the idP to set
     */
    public void setIdP(int idP) {
        this.idP = idP;
    }

    /**
     * @return the idC
     */
    public int getIdC() {
        return idC;
    }

    /**
     * @param idC the idC to set
     */
    public void setIdC(int idC) {
        this.idC = idC;
    }

    /**
     * @return the depto
     */
    public String getDepto() {
        return depto;
    }

    /**
     * @param depto the depto to set
     */
    public void setDepto(String depto) {
        this.depto = depto;
    }

    /**
     * @return the sucursal
     */
    public String getSucursal() {
        return sucursal;
    }

    /**
     * @param sucursal the sucursal to set
     */
    public void setSucursal(String sucursal) {
        this.sucursal = sucursal;
    }

    /**
     * @return the fecha
     */
    public String getFecha() {
        return fecha;
    }

    /**
     * @param fecha the fecha to set
     */
    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    /**
     * @return the solicitante
     */
    public String getSolicitante() {
        return solicitante;
    }

    /**
     * @param solicitante the solicitante to set
     */
    public void setSolicitante(String solicitante) {
        this.solicitante = solicitante;
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

    /**
     * @return the activo
     */
    public int getActivo() {
        return activo;
    }

    /**
     * @param activo the activo to set
     */
    public void setActivo(int activo) {
        this.activo = activo;
    }

    /**
     * @return the garantia
     */
    public int getGarantia() {
        return garantia;
    }

    /**
     * @param garantia the garantia to set
     */
    public void setGarantia(int garantia) {
        this.garantia = garantia;
    }

    /**
     * @return the observaciones
     */
    public String getObservaciones() {
        return observaciones;
    }

    /**
     * @param observaciones the observaciones to set
     */
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    /**
     * @return the idGerenteC
     */
    public int getIdGerenteC() {
        return idGerenteC;
    }

    /**
     * @param idGerenteC the idGerenteC to set
     */
    public void setIdGerenteC(int idGerenteC) {
        this.idGerenteC = idGerenteC;
    }

    /**
     * @return the idGerenteA
     */
    public int getIdGerenteA() {
        return idGerenteA;
    }

    /**
     * @param idGerenteA the idGerenteA to set
     */
    public void setIdGerenteA(int idGerenteA) {
        this.idGerenteA = idGerenteA;
    }

    /**
     * @return the idDirectorA
     */
    public int getIdDirectorA() {
        return idDirectorA;
    }

    /**
     * @param idDirectorA the idDirectorA to set
     */
    public void setIdDirectorA(int idDirectorA) {
        this.idDirectorA = idDirectorA;
    }

    /**
     * @return the idDirectorG
     */
    public int getIdDirectorG() {
        return idDirectorG;
    }

    /**
     * @param idDirectorG the idDirectorG to set
     */
    public void setIdDirectorG(int idDirectorG) {
        this.idDirectorG = idDirectorG;
    }

    /**
     * @return the idGanadora
     */
    public int getIdGanadora() {
        return idGanadora;
    }

    /**
     * @param idGanadora the idGanadora to set
     */
    public void setIdGanadora(int idGanadora) {
        this.idGanadora = idGanadora;
    }
}
