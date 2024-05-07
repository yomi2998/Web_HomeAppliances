/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ServletControl;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.*;

import control.*;
import domain.*;
import domain.Address;

/**
 *
 * @author superme
 */
@WebServlet(name = "Checkout", urlPatterns = {"/Checkout"})
public class Checkout extends HttpServlet {

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
            int id = 0;
            String type = "";
            String paymentMethod = request.getParameter("payment_method");
            int cardId = 0;
            try {
                cardId = Integer.parseInt(request.getParameter("card_id"));
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
            String[] productIdStr = request.getParameter("product_id").split(",");
            String[] quantityStr = request.getParameter("product_quantity").split(",");
            int shippingId = Integer.parseInt(request.getParameter("shipping_id"));
            double estimated_price = Double.parseDouble(request.getParameter("estimated_price"));
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("id")) {
                    id = Integer.parseInt(cookie.getValue());
                }
                if (cookie.getName().equals("type")) {
                    type = cookie.getValue();
                }
            }
            if (!type.equals("customer")) {
                out.print("{\"success\":false,\"cause\":\"Please register as a customer to checkout\"}");
                return;
            }
            ProductControl productControl = new ProductControl();
            double product_price = 0;
            double actual_price = 0;
            double shipping_price = 0;
            double tax_price = 0;
            for (int i = 0; i < productIdStr.length; i++) {
                int productId = Integer.parseInt(productIdStr[i]);
                int quantity = Integer.parseInt(quantityStr[i]);
                Product product = productControl.retrieveProduct(productId);
                if (product == null) {
                    out.print("{\"success\":false,\"cause\":\"Product id " + productId + " not found\"}");
                    return;
                }
                if (product.getStock() < quantity) {
                    out.print("{\"success\":false,\"cause\":\"Insufficient stock for product " + product.getName() + "\"}");
                    return;
                }
                actual_price += product.getPrice() * quantity;
            }
            product_price = actual_price;
            if (product_price < 1000) {
                actual_price += shipping_price = 25;
            }
            actual_price += tax_price = product_price * 0.08;
            if (actual_price != estimated_price) {
                out.print("{\"success\":false,\"cause\":\"Estimated price does not match actual price (Possible promotion has expired?)\"}");
                return;
            }
            switch(paymentMethod) {
                case "card":
                    CardControl cardControl = new CardControl();
                    Card card = cardControl.retrieveCard(cardId);
                    if (card == null) {
                        out.print("{\"success\":false,\"cause\":\"Card not found\"}");
                        return;
                    }
                    break;
                case "nelson-wallet":
                    CustomerControl customerControl = new CustomerControl();
                    Customer customer = customerControl.retrieveCustomer(id);
                    if (customer.getBalance() < estimated_price) {
                        out.print("{\"success\":false,\"cause\":\"Insufficient balance\"}");
                        return;
                    }
                    break;
                default:
                    out.print("{\"success\":false,\"cause\":\"Invalid payment method\"}");
                    return;
            }
            AddressControl addressControl = new AddressControl();
            Address address = addressControl.retrieveAddress(shippingId);
            if (address == null) {
                out.print("{\"success\":false,\"cause\":\"Address not found\"}");
                return;
            }
            List<OrderProduct> orderProductList = new ArrayList<>();
            for (int i = 0; i < productIdStr.length; i++) {
                int productId = Integer.parseInt(productIdStr[i]);
                int quantity = Integer.parseInt(quantityStr[i]);
                Product product = productControl.retrieveProduct(productId);
                OrderProduct orderProduct = new OrderProduct(0, 0, productId, quantity, product.getPrice());
                orderProductList.add(orderProduct);
            }
            Order order = new Order();
            order.init(id, paymentMethod, cardId, shippingId, product_price, shipping_price, tax_price, 0, actual_price, orderProductList);
            OrderControl orderControl = new OrderControl();
            out.print("{\"success\":" + orderControl.insertOrder(order) + ",\"cause\":\"There is an issue with the server\"}");
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
