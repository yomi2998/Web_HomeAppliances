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

    private class ImagePair {

        public Blob image;
        public String extension;

        ImagePair(Blob image, String extension) {
            this.image = image;
            this.extension = extension;
        }
    }

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
        String queryStr = "UPDATE " + tableName + " SET name = ?, display_image = ?, extension = ?, description = ?, price = ?, stock = ?, category_id = ? WHERE id = ?";
        String queryStrAlt = "UPDATE " + tableName + " SET name = ?, description = ?, price = ?, stock = ?, category_id = ? WHERE id = ?";
        String queryStr2 = "DELETE FROM " + imageTableName + " WHERE product_id = ?";
        String queryStr3 = "INSERT INTO " + imageTableName + " (product_id, extension, image) VALUES (?, ?, ?)";
        try {
            if (product.getDisplay_image().equals("")) {
                stmt = conn.prepareStatement(queryStrAlt);
                stmt.setString(1, product.getName());
                stmt.setString(2, product.getDescription());
                stmt.setDouble(3, product.getPrice());
                stmt.setInt(4, product.getStock());
                stmt.setInt(5, product.getCategory_id());
                stmt.setInt(6, product.getId());
                if (stmt.executeUpdate() == 0) {
                    return false;
                }
            } else {
                ImagePair display_image = convertBase64ToBlob(product.getDisplay_image());
                stmt = conn.prepareStatement(queryStr);
                stmt.setString(1, product.getName());
                stmt.setBlob(2, display_image.image);
                stmt.setString(3, display_image.extension);
                stmt.setString(4, product.getDescription());
                stmt.setDouble(5, product.getPrice());
                stmt.setInt(6, product.getStock());
                stmt.setInt(7, product.getCategory_id());
                stmt.setInt(8, product.getId());
                if (stmt.executeUpdate() == 0) {
                    return false;
                }
            }

            if (product.getSub_images().isEmpty()) {
                return true;
            }

            stmt = conn.prepareStatement(queryStr2);
            stmt.setInt(1, product.getId());

            if (stmt.executeUpdate() == 0) {
                return false;
            }

            for (String img : product.getSub_images()) {
                ImagePair image = convertBase64ToBlob(img);
                stmt = conn.prepareStatement(queryStr3);
                stmt.setInt(1, product.getId());
                stmt.setString(2, image.extension);
                stmt.setBlob(3, image.image);
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
        String queryStr = "INSERT INTO " + tableName + " (name, display_image, extension, description, price, stock, category_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String queryStr2 = "INSERT INTO " + imageTableName + " (product_id, extension, image) VALUES (?, ?, ?)";
        try {
            ImagePair display_image = convertBase64ToBlob(product.getDisplay_image());
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, product.getName());
            stmt.setBlob(2, display_image.image);
            stmt.setString(3, display_image.extension);
            stmt.setString(4, product.getDescription());
            stmt.setDouble(5, product.getPrice());
            stmt.setInt(6, product.getStock());
            stmt.setInt(7, product.getCategory_id());

            if (stmt.executeUpdate() == 0) {
                return false;
            }

            int id = 0;
            String queryStr3 = "SELECT MAX(id) FROM " + tableName;
            stmt = conn.prepareStatement(queryStr3);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                id = rs.getInt(1);
            }

            if (id == 0) {
                return false;
            }

            for (String img : product.getSub_images()) {
                stmt = conn.prepareStatement(queryStr2);
                stmt.setInt(1, id);
                ImagePair image = convertBase64ToBlob(img);
                stmt.setString(2, image.extension);
                stmt.setBlob(3, image.image);
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
                String image = convertBlobToBase64(rs.getBlob("display_image"), rs.getString("extension"));
                String queryStr2 = "SELECT * FROM " + imageTableName + " WHERE product_id = ?";
                stmt = conn.prepareStatement(queryStr2);
                stmt.setInt(1, id);
                ResultSet rs2 = stmt.executeQuery();
                while (rs2.next()) {
                    sub_images.add(convertBlobToBase64(rs2.getBlob("image"), rs2.getString("extension")));
                }
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        image,
                        sub_images,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("sold"),
                        rs.getInt("category_id"),
                        rs.getDouble("rating"),
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
                String image = convertBlobToBase64(rs.getBlob("display_image"), rs.getString("extension"));
                stmt = conn.prepareStatement(queryStr2);
                stmt.setInt(1, rs.getInt("id"));
                ResultSet rs2 = stmt.executeQuery();
                while (rs2.next()) {
                    sub_images.add(convertBlobToBase64(rs2.getBlob("image"), rs2.getString("extension")));
                }

                product.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        image,
                        sub_images,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("sold"),
                        rs.getInt("category_id"),
                        rs.getDouble("rating"),
                        rs.getDate("create_date")));
            }
            return product;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public List<Product> searchProducts(String keyword, int cateogry_id) {
        // match partial key
        String queryStr = "SELECT * FROM " + tableName + " WHERE UPPER(name) LIKE UPPER(?)";
        String categoryStr = " AND category_id = ?";
        try {
            if (cateogry_id != 0) {
                queryStr += categoryStr;
            }
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, "%" + keyword + "%");
            if (cateogry_id != 0) {
                stmt.setInt(2, cateogry_id);
            }
            ResultSet rs = stmt.executeQuery();
            List<Product> product = new ArrayList<>();

            while (rs.next()) {
                List<String> sub_images = new ArrayList<>();
                String queryStr2 = "SELECT * FROM " + imageTableName + " WHERE product_id = ?";
                String image = convertBlobToBase64(rs.getBlob("display_image"), rs.getString("extension"));
                stmt = conn.prepareStatement(queryStr2);
                stmt.setInt(1, rs.getInt("id"));
                ResultSet rs2 = stmt.executeQuery();
                while (rs2.next()) {
                    sub_images.add(convertBlobToBase64(rs2.getBlob("image"), rs2.getString("extension")));
                }
                product.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        image,
                        sub_images,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("sold"),
                        rs.getInt("category_id"),
                        rs.getDouble("rating"),
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

    private String convertBlobToBase64(Blob blob, String extension) {
        try {
            byte[] bytes = blob.getBinaryStream().readAllBytes();
            String base64String = Base64.getEncoder().encodeToString(bytes);
            return extension + "," + base64String;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    private ImagePair convertBase64ToBlob(String base64String) {
        String[] split = base64String.split(",");
        String rmStr = split[1];
        try {
            byte[] decodedBytes = Base64.getMimeDecoder().decode(rmStr);
            Blob blob = new javax.sql.rowset.serial.SerialBlob(decodedBytes);
            return new ImagePair(blob, split[0]);
        } catch (SQLException ex) {
            System.out.println("Error converting Base64 to BLOB: " + ex.getMessage());
            return null;
        }
    }
}
