/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author LuisMtz
 */
public class Precios extends Item{
    
    private int diasCredito;
    private int tiempoEntrega;
    private int garantia;
    private int descuento;
    private int anticipo;

    /**
     * @return the diasCredito
     */
    public int getDiasCredito() {
        return diasCredito;
    }

    /**
     * @param diasCredito the diasCredito to set
     */
    public void setDiasCredito(int diasCredito) {
        this.diasCredito = diasCredito;
    }

    /**
     * @return the tiempoEntrega
     */
    public int getTiempoEntrega() {
        return tiempoEntrega;
    }

    /**
     * @param tiempoEntrega the tiempoEntrega to set
     */
    public void setTiempoEntrega(int tiempoEntrega) {
        this.tiempoEntrega = tiempoEntrega;
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
    
    
}
