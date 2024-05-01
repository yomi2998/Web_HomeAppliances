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
import java.io.*;
import java.sql.*;
import com.google.gson.Gson;
import java.util.Base64;

/**
 *
 * @author superme
 */
@WebServlet(name = "TestDownload", urlPatterns = {"/TestDownload"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class TestDownload extends HttpServlet {

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
        String fileName = "DoorLock.png";
        // Retrieve file from database
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/HomeAppliances", "nbuser", "nbuser")) {
            String query = "SELECT img FROM testtable WHERE name = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, fileName);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        Blob retrievedBlob = resultSet.getBlob("img");
                        InputStream retrievedFile = retrievedBlob.getBinaryStream();

                        // Convert file to byte array
                        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                        byte[] buffer = new byte[4096];
                        int bytesRead;
                        while ((bytesRead = retrievedFile.read(buffer)) != -1) {
                            byteArrayOutputStream.write(buffer, 0, bytesRead);
                        }
                        byte[] fileBytes = byteArrayOutputStream.toByteArray();

                        // Convert byte array to Base64 string
                        String fileBase64 = Base64.getEncoder().encodeToString(fileBytes);

                        // Output as JSON
                        try (PrintWriter out = response.getWriter()) {
                            out.print("{\"success\":true, \"file\": \"" + fileBase64 + "\"}");
                        }
                    } else {
                        // File not found in database
                        try (PrintWriter out = response.getWriter()) {
                            out.print("{\"success\":false, \"message\": \"File not found\"}");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            // Handle exception
        }
    }
    private String getFileName(Part part) {
        for (String contentDisposition : part.getHeader("content-disposition").split(";")) {
            if (contentDisposition.trim().startsWith("filename")) {
                return contentDisposition.substring(contentDisposition.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
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
