/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Product;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
/**
 *
 * @author Nelson
 */
public class ProductDA {
    
    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "product";
    private Connection conn;
    private PreparedStatement stmt;
    
    public ProductDA() {
        createConnection();
    }
    
    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public boolean deleteProduct(int prodId) {
        String queryStr = "DELETE FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1,  prodId);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }
    
    public boolean updateProduct(Product product){
        String queryStr = "UPDATE " + tableName + " SET prodName = ?, display_image_url = ?, description = ?, price = ?, stock = ?, category_id = ?, create_date = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, product.getProdName());
            stmt.setString(2,  product.getImgUrl());
            stmt.setString(3,  product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getStock());
            stmt.setInt(6, product.getCategoryId());
            stmt.setDate(7, (Date) product.getCreateDate());
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }
    
    public boolean insertProduct(Product product) {
        String queryStr = "INSERT INTO " + tableName + " (id, name, display_image_url, description, price, stock, category_id, create_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, product.getProdId());
            stmt.setString(2, product.getProdName());
            stmt.setString(3,  product.getImgUrl());
            stmt.setString(4,  product.getDescription());
            stmt.setDouble(5, product.getPrice());
            stmt.setInt(6, product.getStock());
            stmt.setInt(7, product.getCategoryId());
            stmt.setDate(8, (Date) product.getCreateDate());
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }
    
    public List<Product> retrieveProduct (int prodId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, prodId);
            ResultSet rs = stmt.executeQuery();
            List<Product> product = new ArrayList<>();
            
            while (rs.next()) {
                product.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("display_image_url"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("category_id"),
                        rs.getDate("create_date")));
            } return product;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
    
    public void destroy() {
        try {
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
