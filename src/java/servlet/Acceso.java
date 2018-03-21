/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import model.UserCompras;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author LuisMtz
 */
public class Acceso extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String nombre = request.getParameter("usuario");
            String pass = request.getParameter("pass");
            String mensaje = "", retorno;
            UserCompras objUsuario = new UserCompras();
            RequestDispatcher dispatcher;
            ArrayList<UserCompras> ListaUsu = objUsuario.validarUsuario(nombre);
            HttpSession sesion = request.getSession(true);
            if (ListaUsu.size() > 0) {
                int statusQuery;
                String usuario = ListaUsu.get(0).getNombre();
                int idUsuario = ListaUsu.get(0).getIdUsrCompras();
                String password = ListaUsu.get(0).getPassword();
                String depto = ListaUsu.get(0).getId_departamento();
                String rol = ListaUsu.get(0).getId_rol();
                /**/
                System.out.println("idusuario" + idUsuario);
                System.out.println("USUARIO: " + usuario);
                System.out.println("PASSWORD: " + password);
                
                String retorno1 = "";
                if (password.equals(pass)) {
                    retorno1 = "/menuSolicita.jsp";

                    sesion.setAttribute("idUsuario", "" + idUsuario);
                    sesion.setAttribute("Bienvenido", "1");
                    mensaje += "BIENVENIDO usuario " + usuario + "";
                    retorno = retorno1;

                    sesion.setAttribute("usuarioIngresado", usuario);
                    sesion.setAttribute("passwordIngresado", password);
                    sesion.setAttribute("idUsuario", "" + idUsuario);
                    sesion.setAttribute("departamento", depto);
                    sesion.setAttribute("rol", rol);

                    dispatcher = getServletContext().getRequestDispatcher(retorno);
                    dispatcher.forward(request, response);

                } else {
                    mensaje += "Password Incorrecto, favor de rectificar";
                    retorno = "/index.jsp";
                    sesion.setAttribute("mensaje", mensaje);
                    dispatcher = getServletContext().getRequestDispatcher(retorno);
                    dispatcher.forward(request, response);
                }

                
                //
                //response.sendRedirect("acceso.jsp");
                //-------------------------------------------------------------------------------------------------------------------------
            } else {
                mensaje += "Usuario Incorrecto favor de verificar";
                retorno = "/index.jsp";
                sesion.setAttribute("mensaje", mensaje);
                dispatcher = getServletContext().getRequestDispatcher(retorno);
                dispatcher.forward(request, response);
                //response.sendRedirect("acceso.jsp");
            }
        } finally {
            out.close();
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
        processRequest(request, response);
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
