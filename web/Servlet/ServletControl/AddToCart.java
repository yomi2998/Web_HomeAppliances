/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ServletControl;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;

import domain.*;
import control.*;

/**
 *
 * @author superme
 */
@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends HttpServlet {

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
            int product_id = Integer.parseInt(request.getParameter("product_id"));
            int user_id =  0;
            String type = "";
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Cookie[] cookies = request.getCookies();
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("id")) {
                    user_id = Integer.parseInt(cookie.getValue());
                }
                if (cookie.getName().equals("type")) {
                    type = cookie.getValue();
                }
            }

            if (!type.equals("customer")) {
                out.print("{\"success\":false,\"cause\":\"You must be logged in as a customer to add items to cart.\"}");
                return;
            }
            
            if (quantity <= 0) {
                out.print("{\"success\":false,\"cause\":\"Quantity must be greater than 0\"}");
                return;
            }

            CartControl cartControl = new CartControl();
            Cart cart = cartControl.retrieveCart(user_id, product_id);
            boolean success = false;
            if (cart == null) {
                cart = new Cart(user_id, product_id, quantity);
                success = cartControl.insertCart(cart);
            } else {
                cart.setQuantity(quantity);
                success = cartControl.updateCart(cart);
            }
            out.print("{\"success\":" + success + ", \"cause\":\"Item is currently out of stock.\"}");
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
