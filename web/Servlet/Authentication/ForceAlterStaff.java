/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Authentication;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import domain.*;
import control.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import jakarta.servlet.http.Cookie;

/**
 *
 * @author superme
 */
@WebServlet(name = "ForceAlterStaff", urlPatterns = {"/ForceAlterStaff"})
public class ForceAlterStaff extends HttpServlet {

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
        String birthdateStr = request.getParameter("birthdate");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date dob = new Date();
        try {
            dob = dateFormat.parse(birthdateStr);
        } catch (Exception e) {

        }
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
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact_number = request.getParameter("contact_number");
        StaffControl sc = new StaffControl();
        boolean success = sc.updateStaffPrivileged(new Staff(id, name, username, email, dob, contact_number));
        out.print("{\"success\":" + success + "}");
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
