/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Authentication;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import domain.*;
import control.*;

/**
 *
 * @author superme
 */
@WebServlet(name = "ForceDelete", urlPatterns = {"/ForceDelete"})
public class ForceDelete extends HttpServlet {

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
            Cookie[] cookies = request.getCookies();
            String type = "";
            String session = "";
            int id = 0;
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("type")) {
                    type = cookie.getValue();
                }
                if (cookie.getName().equals("session")) {
                    session = cookie.getValue();
                }
                if (cookie.getName().equals("id")) {
                    id = Integer.parseInt(cookie.getValue());
                }
            }
            AdminControl ac = new AdminControl();
            if (!type.equals("admin") || ac.verifySession(id, session) == null) {
                out.print("{\"success\":false}");
                return;
            }
            id = Integer.parseInt(request.getParameter("id"));
            type = request.getParameter("type");
            switch (type) {
                case "customer":
                    CustomerControl cc = new CustomerControl();
                    out.print("{\"success\":" + cc.deleteCustomer(id) + "}");
                    break;
                case "staff":
                    StaffControl sc = new StaffControl();
                    out.print("{\"success\":" + sc.deleteStaff(id) + "}");
                    break;
                default:
                    break;
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
