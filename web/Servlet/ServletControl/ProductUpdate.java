/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ServletControl;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import control.StaffControl;
import control.AdminControl;
import java.util.*;

/**
 *
 * @author superme
 */
@WebServlet(name = "ProductUpdate", urlPatterns = {"/ProductUpdate"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 16, // 16 MB
        maxRequestSize = 1024 * 1024 * 200 // 200MB
)
public class ProductUpdate extends HttpServlet {

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
            int id = -1;
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
            switch (type) {
                case "admin":
                    AdminControl adminControl = new AdminControl();
                    if (adminControl.verifySession(id, session) == null) {
                        out.print("{\"success\": false}");
                        return;
                    }
                    break;
                case "staff":
                    StaffControl staffControl = new StaffControl();
                    if (staffControl.verifySession(id, session) == null) {
                        out.print("{\"success\": false}");
                        return;
                    }
                    break;
                default:
                    out.print("{\"success\": false}");
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
