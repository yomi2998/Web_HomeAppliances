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
import java.util.Date;
import control.CustomerControl;
import domain.Customer;
import jakarta.servlet.http.Cookie;
import java.text.SimpleDateFormat;

/**
 *
 * @author superme
 */
@WebServlet(name = "Register", urlPatterns = { "/Register" })
public class Register extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String birthdateStr = request.getParameter("birthdate");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date dob = new Date();
            try {
                dob = dateFormat.parse(birthdateStr);
            } catch (Exception e) {
                
            }
            Customer customer = new Customer(-1, name, username, password, email, 0, dob, null, null);
            CustomerControl cc = new CustomerControl();
            if (cc.insertCustomer(customer)) {
                customer = cc.verifyLogin(username, password);
                if (customer != null) {
                    Cookie userIdCookie = new Cookie("id", String.valueOf(customer.getId()));
                    Cookie sessionCookie = new Cookie("session", customer.getSession());
                    Cookie userTypeCookie = new Cookie("type", "customer");
                    userIdCookie.setMaxAge(31536000);
                    sessionCookie.setMaxAge(31536000);
                    userTypeCookie.setMaxAge(31536000);
                    response.addCookie(userIdCookie);
                    response.addCookie(sessionCookie);
                    response.addCookie(userTypeCookie);
                    out.print("{\"success\": true}");
                }
            } else {
                out.print("{\"success\": false}");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
