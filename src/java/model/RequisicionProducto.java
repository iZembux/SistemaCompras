
package model;

public class RequisicionProducto {

    

    

    private int idSolicita;
    private int idReqProd;
    private int idRequisicion;
    private int idProducto;
    private int idReqCoti;
    private int idStatus;
    private int idDepto;
    private int cantidad;
    private int idOrden;
    private int idCategoria;
    private int idCuadro;
    private int idFormato;
    private int sku;
    private double precio;
    private String producto;
    private String marca;
    private String status;
    private String solicitante;
    private String departamento;
    private String descripcion;
    private String justificacion;
    private String porcentaje;
    private String fecha;
    private String sucursal;
    private String proveedor;
    private String rutaFactura;
    private String rutaCaratula;
    private String rutaDictamen;
    private String fecha_coti;

    /**
     * @return the idRequisicion
     */
    public int getIdRequisicion() {
        return idRequisicion;
    }

    /**
     * @param idRequisicion the idRequisicion to set
     */
    public void setIdRequisicion(int idRequisicion) {
        this.idRequisicion = idRequisicion;
    }

    /**
     * @return the idReqCoti
     */
    public int getIdReqCoti() {
        return idReqCoti;
    }

    /**
     * @param idReqCoti the idCotizacion to set
     */
    public void setIdReqCoti(int idReqCoti) {
        this.idReqCoti = idReqCoti;
    }

    /**
     * @return the idStatus
     */
    public int getIdStatus() {
        return idStatus;
    }

    /**
     * @param idStatus the idStatus to set
     */
    public void setIdStatus(int idStatus) {
        this.idStatus = idStatus;
    }

    /**
     * @return the cantidad
     */
    public int getCantidad() {
        return cantidad;
    }

    /**
     * @param cantidad the cantidad to set
     */
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
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
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the justificacion
     */
    public String getJustificacion() {
        return justificacion;
    }

    /**
     * @param justificacion the justificacion to set
     */
    public void setJustificacion(String justificacion) {
        this.justificacion = justificacion;
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
     * @return the porcentaje
     */
    public String getPorcentaje() {
        return porcentaje;
    }

    /**
     * @param porcentaje the porcentaje to set
     */
    public void setPorcentaje(String porcentaje) {
        this.porcentaje = porcentaje;
    }

    /**
     * @return the marca
     */
    public String getMarca() {
        return marca;
    }

    /**
     * @param marca the marca to set
     */
    public void setMarca(String marca) {
        this.marca = marca;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the idReqProd
     */
    public int getIdReqProd() {
        return idReqProd;
    }

    /**
     * @param idReqProd the idReqProd to set
     */
    public void setIdReqProd(int idReqProd) {
        this.idReqProd = idReqProd;
    }

    /**
     * @return the idDepto
     */
    public int getIdDepto() {
        return idDepto;
    }

    /**
     * @param idDepto the idDepto to set
     */
    public void setIdDepto(int idDepto) {
        this.idDepto = idDepto;
    }

    /**
     * @return the idProducto
     */
    public int getIdProducto() {
        return idProducto;
    }

    /**
     * @param idProducto the idProducto to set
     */
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    /**
     * @return the idSoliita
     */
    public int getIdSolicita() {
        return idSolicita;
    }

    /**
     * @param idSolicita the idSoliita to set
     */
    public void setIdSolicita(int idSolicita) {
        this.idSolicita = idSolicita;
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
     * @return the idOrden
     */
    public int getIdOrden() {
        return idOrden;
    }

    /**
     * @param idOrden the idOrden to set
     */
    public void setIdOrden(int idOrden) {
        this.idOrden = idOrden;
    }

    /**
     * @return the sku
     */
    public int getSku() {
        return sku;
    }

    /**
     * @param sku the sku to set
     */
    public void setSku(int sku) {
        this.sku = sku;
    }
    
    
    /**
     * @return the rutaFactura
     */
    public String getRutaFactura() {
        return rutaFactura;
    }

    /**
     * @param rutaFactura the rutaFactura to set
     */
    public void setRutaFactura(String rutaFactura) {
        this.rutaFactura = rutaFactura;
    }

    /**
     * @return the departamento
     */
    public String getDepartamento() {
        return departamento;
    }

    /**
     * @param departamento the departamento to set
     */
    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    /**
     * @return the idCategoria
     */
    public int getIdCategoria() {
        return idCategoria;
    }

    /**
     * @param idCategoria the idCategoria to set
     */
    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    /**
     * @return the rutaCaratula
     */
    public String getRutaCaratula() {
        return rutaCaratula;
    }

    /**
     * @param rutaCaratula the rutaCaratula to set
     */
    public void setRutaCaratula(String rutaCaratula) {
        this.rutaCaratula = rutaCaratula;
    }
    
    /**
     * @return the rutaDictamen
     */
    public String getRutaDictamen() {
        return rutaDictamen;
    }

    /**
     * @param rutaDictamen the rutaDictamen to set
     */
    public void setRutaDictamen(String rutaDictamen) {
        this.rutaDictamen = rutaDictamen;
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
     * @return the fecha_coti
     */
    public String getFecha_coti() {
        return fecha_coti;
    }

    /**
     * @param fecha_coti the fecha_coti to set
     */
    public void setFecha_coti(String fecha_coti) {
        this.fecha_coti = fecha_coti;
    }

    /**
     * @return the idCuadro
     */
    public int getIdCuadro() {
        return idCuadro;
    }

    /**
     * @param idCuadro the idCuadro to set
     */
    public void setIdCuadro(int idCuadro) {
        this.idCuadro = idCuadro;
    }

    /**
     * @return the idFormato
     */
    public int getIdFormato() {
        return idFormato;
    }

    /**
     * @param idFormato the idFormato to set
     */
    public void setIdFormato(int idFormato) {
        this.idFormato = idFormato;
    }
}
