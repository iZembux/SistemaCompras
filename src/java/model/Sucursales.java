/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author aBIMAEL
 */
public class Sucursales {

    /**
     * @return the id_sucursales
     */
    public int getId_sucursales() {
        return id_sucursales;
    }

    /**
     * @param id_sucursales the id_sucursales to set
     */
    public void setId_sucursales(int id_sucursales) {
        this.id_sucursales = id_sucursales;
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
    private int id_sucursales = 0;
    private String sucursal = "";
    
    
}
