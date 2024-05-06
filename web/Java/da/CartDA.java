/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import java.sql.*;
import domain.Cart;
import java.util.*;

/**
 *
 * @author superme
 */
public class CartDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "cart";
    private Connection conn;
    private PreparedStatement stmt;

    public CartDA() {
        createConnection();
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

    public boolean insertCart(Cart cart) {
        String queryStr = "INSERT INTO " + tableName + " (user_id, product_id, quantity) VALUES (?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, cart.getUser_id());
            stmt.setInt(2, cart.getProduct_id());
            stmt.setInt(3, cart.getQuantity());
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }

    public List<Cart> retrieveCartALL(int user_id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE user_id = ? ORDER BY create_date DESC";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, user_id);
            ResultSet rs = stmt.executeQuery();
            List<Cart> carts = new ArrayList<>();
            while (rs.next()) {
                carts.add(new Cart(user_id, rs.getInt("product_id"), rs.getInt("quantity"), rs.getDate("create_date")));
            }
            return carts;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public Cart retrieveCart(int user_id, int product_id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE user_id = ? AND product_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, user_id);
            stmt.setInt(2, product_id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Cart(user_id, rs.getInt("product_id"), rs.getInt("quantity"), rs.getDate("create_date"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public boolean deleteCart(int user_id, int product_id) {
        String queryStr = "DELETE FROM " + tableName + " WHERE user_id = ? AND product_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, user_id);
            stmt.setInt(2, product_id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }

    public boolean updateCart(Cart cart) {
        String queryStr = "UPDATE " + tableName + " SET quantity = ? WHERE user_id = ? AND product_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, cart.getQuantity());
            stmt.setInt(2, cart.getUser_id());
            stmt.setInt(3, cart.getProduct_id());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }

}
