/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Authentication;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import control.CustomerControl;
import domain.Customer;
import control.AdminControl;
import domain.Admin;
import com.google.gson.Gson;
import jakarta.servlet.http.Cookie;

/**
 *
 * @author superme
 */
public class Login extends HttpServlet {

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
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            CustomerControl cc = new CustomerControl();
            Customer customer = cc.verifyLogin(username, password);
            if (customer == null) {
                cc.destroy();
                AdminControl ac = new AdminControl();
                Admin admin = ac.verifyLogin(username, password);
                if (admin != null) {
                    Cookie sessionCookie = new Cookie("session", admin.getSession());
                    Cookie userIdCookie = new Cookie("id", String.valueOf(admin.getId()));
                    Cookie userTypeCookie = new Cookie("type", "admin");
                    sessionCookie.setMaxAge(31536000);
                    userIdCookie.setMaxAge(31536000);
                    userTypeCookie.setMaxAge(31536000);
                    response.addCookie(sessionCookie);
                    response.addCookie(userIdCookie);
                    response.addCookie(userTypeCookie);
                    out.print("{\"success\":true, \"data\":" + new Gson().toJson(admin) + "}");
                } else {
                    ac.destroy();
                    out.print("{\"success\":false}");
                    // todo
                }
            } else {
                Cookie sessionCookie = new Cookie("session", customer.getSession());
                Cookie userIdCookie = new Cookie("id", String.valueOf(customer.getId()));
                Cookie userTypeCookie = new Cookie("type", "customer");
                sessionCookie.setMaxAge(31536000);
                userIdCookie.setMaxAge(31536000);
                userTypeCookie.setMaxAge(31536000);
                response.addCookie(sessionCookie);
                response.addCookie(userIdCookie);
                response.addCookie(userTypeCookie);
                out.print("{\"success\":true, \"data\":" + new Gson().toJson(customer) + "}");
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
