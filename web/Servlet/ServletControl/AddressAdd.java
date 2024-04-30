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

import domain.Address;
import control.AddressControl;
import control.CustomerControl;
import com.google.gson.Gson;

/**
 *
 * @author superme
 */
@WebServlet(name = "AddressAdd", urlPatterns = {"/AddressAdd"})
public class AddressAdd extends HttpServlet {

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
            Cookie cookies[] = request.getCookies();
            int user_id = 0;
            for (Cookie c : cookies) {
                if (c.getName().equals("id")) {
                    user_id = Integer.parseInt(c.getValue());
                }
            }
            String password = request.getParameter("password");
            CustomerControl customerControl = new CustomerControl();
            if (!customerControl.confirmPassword(user_id, password)) {
                out.print("{\"success\":false, \"cause\":\"password\"}");
                return;
            }
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String address_2 = request.getParameter("address_2");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zip_code = request.getParameter("zip_code");
            String contact_num = request.getParameter("contact_num");
            Address addr = new Address(-1, user_id, address, address_2, city, state, zip_code, name, contact_num);
            AddressControl addrControl = new AddressControl();
            out.print("{\"success\":" + addrControl.insertAddress(addr) + ", \"cause\":\"address\", \"address\":" + new Gson().toJson(addrControl.retrieveLatestAddress(user_id)) + "}");
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
