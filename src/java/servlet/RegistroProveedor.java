/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import controller.Mail;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Proveedor;
import model.UserCompras;

/**
 *
 * @author LuisMtz
 */
public class RegistroProveedor extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Registro Proveedor</title>"); 
            out.println("</head>");
            out.println("<body>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       Proveedor obProveedor = new Proveedor();
       Mail obMail = new Mail();
            
            obProveedor.setUsuario(request.getParameter("usuario"));
            obProveedor.setPassword(request.getParameter("pass"));
            obProveedor.setNombre(request.getParameter("nombre"));
            obProveedor.setApellido(request.getParameter("apellido"));
            obProveedor.setApellidoM(request.getParameter("apellidoM"));
            obProveedor.setCorreo(request.getParameter("email"));
            obProveedor.setDireccion(request.getParameter("direccion"));
            obProveedor.setTelefono(request.getParameter("telefono"));
            obProveedor.setRazonSocial(request.getParameter("razon"));
            obProveedor.setRFC(request.getParameter("rfc"));
            obProveedor.setCedulaFiscal(request.getParameter("cedula"));
            obProveedor.setDireccionFiscal(request.getParameter("dirfiscal"));
            obProveedor.setCuentaReferencia(request.getParameter("cuentaref"));
            obProveedor.setSucursalBancaria(request.getParameter("sucursalbanca"));
            obProveedor.setCLABE(request.getParameter("clabe"));
            boolean status = obProveedor.registraProveedor(obProveedor);
            if (status) {
                System.out.println("Proveedor Registrado");
                obMail.enviarCorreo(obProveedor.getCorreo(), obProveedor.getNombre(), obProveedor.getApellidoM(), "Su usuario ha sido creado satisfactoriamente.");
            } else {
                System.out.println("Proveedor NO registrado");
            }
            
        response.sendRedirect("logProveedor.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
