/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ServletControl;

import control.CustomerControl;
import control.AddressControl;
import domain.Address;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author superme
 */
@WebServlet(name = "AddressRetrieveSpecific", urlPatterns = {"/AddressRetrieveSpecific"})
public class AddressRetrieveSpecific extends HttpServlet {

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
            Cookie ck[] = request.getCookies();
            String password = request.getParameter("password");
            int id = 0;
            for (Cookie cookie : ck) {
                if (cookie.getName().equals("id")) {
                    id = Integer.parseInt(cookie.getValue());
                }
            }
            CustomerControl cc = new CustomerControl();
            if (!cc.confirmPassword(id, password)) {
                out.print("{\"success\": false, \"cause\": \"password\"}");
                return;
            }
            AddressControl addressControl = new AddressControl();
            Address addr = addressControl.retrieveAddress(Integer.parseInt(request.getParameter("address_id")));
            if (addr != null) {
                out.print("{\"success\": true, \"address\": " + new Gson().toJson(addr) + "}");
            } else {
                out.print("{\"success\": false, \"cause\": \"address\"}");
            }
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
