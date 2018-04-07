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
   private int cantidad;
   private int precio;
   private int iva;
   private int descuento;
   private int credito;
   private int entrega;
   private int anticipo;
   private int garantia;
   private int idP;
   private int idC;
   private int status;
   private int activo;

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
    public int getPrecio() {
        return precio;
    }

    /**
     * @param precio the precio to set
     */
    public void setPrecio(int precio) {
        this.precio = precio;
    }

    /**
     * @return the iva
     */
    public int getIva() {
        return iva;
    }

    /**
     * @param iva the iva to set
     */
    public void setIva(int iva) {
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
}
