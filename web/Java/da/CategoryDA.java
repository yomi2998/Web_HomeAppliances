/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Category;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author superme
 */
public class CategoryDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "category";
    private Connection conn;
    private PreparedStatement stmt;

    public CategoryDA() {
        createConnection();
    }

    public boolean deleteCategory(int id) {
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

    public boolean updateCategory(Category category) {
        String queryStr = "UPDATE " + tableName + " SET name = ? WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, category.getName());
            stmt.setInt(2, category.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public int insertCategory(Category category) {
        String queryStr = "INSERT INTO " + tableName + " (name) VALUES (?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, category.getName());
            stmt.executeUpdate();
            // Get the id of the inserted category
            queryStr = "SELECT * FROM " + tableName + " WHERE name = ?";
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, category.getName());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return -1;
        }
    }

    public List<Category> retrieveCategory() {
        String queryStr = "SELECT * FROM " + tableName + " ORDER BY name";
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            List<Category> categoryList = new ArrayList<>();
            while (rs.next()) {
                categoryList.add(new Category(rs.getInt("id"), rs.getString("name")));
            }
            return categoryList;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
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
