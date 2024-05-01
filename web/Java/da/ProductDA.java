/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Product;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Base64;
import java.io.*;

/**
 *
 * @author Nelson
 */
public class ProductDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "product";
    private String imageTableName = "product_image";
    private String salesTableName = "order_product";
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

    public boolean deleteProduct(int id) {
        String queryStr = "DELETE FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean updateProduct(Product product) {
        String queryStr = "UPDATE " + tableName + " SET name = ?, display_image = ?, description = ?, price = ?, stock = ?, category_id = ?, create_date = ?";
        String queryStr2 = "DELETE FROM " + imageTableName + " WHERE product_id = ?";
        String queryStr3 = "INSERT INTO " + imageTableName + " (product_id, image) VALUES (?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, product.getName());
            stmt.setBlob(2, convertBase64ToBlob(product.getDisplay_image()));
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getStock());
            stmt.setInt(6, product.getCategory_id());
            stmt.setDate(7, (Date) product.getCreate_date());
            if (stmt.executeUpdate() == 0) {
                return false;
            }

            stmt = conn.prepareStatement(queryStr2);
            stmt.setInt(1, product.getId());
            
            if (stmt.executeUpdate() == 0) {
                return false;
            }

            for (String img : product.getSub_images()) {
                stmt = conn.prepareStatement(queryStr3);
                stmt.setInt(1, product.getId());
                stmt.setBlob(2, convertBase64ToBlob(img));
                if (stmt.executeUpdate() == 0) {
                    return false;
                }
            }

            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean insertProduct(Product product) {
        String queryStr = "INSERT INTO " + tableName + " (id, name, display_image, description, price, stock, category_id, create_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        String queryStr2 = "INSERT INTO " + imageTableName + " (product_id, image) VALUES (?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, product.getId());
            stmt.setString(2, product.getName());
            stmt.setBlob(3, convertBase64ToBlob(product.getDisplay_image()));
            stmt.setString(4, product.getDescription());
            stmt.setDouble(5, product.getPrice());
            stmt.setInt(6, product.getStock());
            stmt.setInt(7, product.getCategory_id());
            stmt.setDate(8, (Date) product.getCreate_date());
            
            if (stmt.executeUpdate() == 0) {
                return false;
            }

            for (String img : product.getSub_images()) {
                stmt = conn.prepareStatement(queryStr2);
                stmt.setInt(1, product.getId());
                stmt.setBlob(2, convertBase64ToBlob(img));
                if (stmt.executeUpdate() == 0) {
                    return false;
                }
            }

            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public Product retrieveProduct(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                List<String> sub_images = new ArrayList<>();
                String queryStr2 = "SELECT * FROM " + imageTableName + " WHERE product_id = ?";
                stmt = conn.prepareStatement(queryStr2);
                stmt.setInt(1, id);
                ResultSet rs2 = stmt.executeQuery();
                while (rs2.next()) {
                    sub_images.add(convertBlobToBase64(rs2.getBlob("image")));
                }

                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        convertBlobToBase64(rs.getBlob("display_image")),
                        sub_images,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("sold"),
                        rs.getInt("category_id"),
                        rs.getDate("create_date"));
            }
            return null;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public List<Product> retrieveProductALL() {
        String queryStr = "SELECT * FROM " + tableName;
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            List<Product> product = new ArrayList<>();

            while (rs.next()) {
                List<String> sub_images = new ArrayList<>();
                String queryStr2 = "SELECT * FROM " + imageTableName + " WHERE product_id = ?";
                stmt = conn.prepareStatement(queryStr2);
                stmt.setInt(1, rs.getInt("id"));
                ResultSet rs2 = stmt.executeQuery();
                while (rs2.next()) {
                    sub_images.add(convertBlobToBase64(rs2.getBlob("image")));
                }

                product.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        convertBlobToBase64(rs.getBlob("display_image")),
                        sub_images,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("sold"),
                        rs.getInt("category_id"),
                        rs.getDate("create_date")));
            }
            return product;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public int countTotalSales() {
        String queryStr = "SELECT SUM(quantity) FROM " + salesTableName;
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return 0;
        }
    }

    public double countTotalEarned() {
        String queryStr = "SELECT SUM(price) FROM " + salesTableName;
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getDouble(1);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return 0;
        }
    }

    public void destroy() {
        try {
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private String convertBlobToBase64(Blob data) {
        try {
            // Convert the BLOB data to byte array
            byte[] bytes = data.getBytes(1, (int) data.length());

            // Encode the byte array to Base64
            return Base64.getEncoder().encodeToString(bytes);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    private Blob convertBase64ToBlob(String base64String) {
        try {
            byte[] decodedBytes = Base64.getDecoder().decode(base64String);
            return new javax.sql.rowset.serial.SerialBlob(decodedBytes);
        } catch (SQLException ex) {
            System.out.println("Error converting Base64 to BLOB: " + ex.getMessage());
            return null;
        }
    }
}
