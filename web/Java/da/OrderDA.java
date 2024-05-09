/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.*;
import control.*;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author Nelson
 */
public class OrderDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "cust_order";
    private String addressTableName = "cust_order_address";
    private String orderProductTableName = "order_product";
    private String orderStatusTableName = "order_status";
    private String productTableName = "product";
    private String customerTableName = "customer";
    private Connection conn;
    private PreparedStatement stmt;

    public OrderDA() {
        createConnection();
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public boolean insertOrder(Order order) {
        String queryStr = "INSERT INTO " + tableName + " (user_id, payment_method, card_id, price, shipping_fee, tax, discount, final_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        String queryStr2 = "INSERT INTO " + addressTableName + " (order_id, address, address_2, city, state, zip_code, recipient_name, contact_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        String queryStr3 = "INSERT INTO " + orderProductTableName + " (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        String queryStr4 = "UPDATE " + productTableName + " SET stock = stock - ?, sold = sold + ? WHERE id = ?";
        String queryStr5 = "UPDATE " + customerTableName + " SET balance = balance - ? WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, order.getUser_id());
            stmt.setString(2, order.getPayment_method());
            stmt.setInt(3, order.getCard_id());
            stmt.setDouble(4, order.getPrice());
            stmt.setDouble(5, order.getShipping_fee());
            stmt.setDouble(6, order.getTax());
            stmt.setDouble(7, order.getDiscount());
            stmt.setDouble(8, order.getFinal_price());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            rs.next();
            int order_id = rs.getInt(1);
            stmt = conn.prepareStatement(queryStr2);
            stmt.setInt(1, order_id);
            stmt.setString(2, order.getCust_order_address().getAddress());
            stmt.setString(3, order.getCust_order_address().getAddress_2());
            stmt.setString(4, order.getCust_order_address().getCity());
            stmt.setString(5, order.getCust_order_address().getState());
            stmt.setString(6, order.getCust_order_address().getZip_code());
            stmt.setString(7, order.getCust_order_address().getRecipient_name());
            stmt.setString(8, order.getCust_order_address().getContact_number());
            stmt.executeUpdate();
            for (OrderProduct orderProduct : order.getOrder_product()) {
                stmt = conn.prepareStatement(queryStr3);
                stmt.setInt(1, order_id);
                stmt.setInt(2, orderProduct.getProduct_id());
                stmt.setInt(3, orderProduct.getQuantity());
                stmt.setDouble(4, orderProduct.getPrice());
                stmt.executeUpdate();
                stmt = conn.prepareStatement(queryStr4);
                stmt.setInt(1, orderProduct.getQuantity());
                stmt.setInt(2, orderProduct.getQuantity());
                stmt.setInt(3, orderProduct.getProduct_id());
                stmt.executeUpdate();
                CartControl cartControl = new CartControl();
                cartControl.deleteCart(order.getUser_id(), orderProduct.getProduct_id());
            }
            if (order.getPayment_method().equals("nelson-wallet")) {
                stmt = conn.prepareStatement(queryStr5);
                stmt.setDouble(1, order.getFinal_price());
                stmt.setInt(2, order.getUser_id());
                stmt.executeUpdate();
            }
            OrderStatus orderStatus = new OrderStatus(0, order_id, "Seller is preparing your order...", new Date(System.currentTimeMillis()));
            OrderStatusControl orderStatusControl = new OrderStatusControl();
            orderStatusControl.insertStatus(orderStatus);
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public List<Order> retrieveOrder(int user_id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE user_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, user_id);
            ResultSet rs = stmt.executeQuery();
            List<Order> order = new ArrayList<>();
            while (rs.next()) {
                Order orderObj = new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("payment_method"),
                        rs.getInt("card_id"),
                        rs.getDouble("price"),
                        rs.getDouble("shipping_fee"),
                        rs.getDouble("tax"),
                        rs.getDouble("discount"),
                        rs.getDouble("final_price"),
                        rs.getDate("create_date"));
                order.add(orderObj);
            }
            return order;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public Order retrieveOrderById(int order_id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, order_id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Order orderObj = new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("payment_method"),
                        rs.getInt("card_id"),
                        rs.getDouble("price"),
                        rs.getDouble("shipping_fee"),
                        rs.getDouble("tax"),
                        rs.getDouble("discount"),
                        rs.getDouble("final_price"),
                        rs.getDate("create_date"));
                return orderObj;
            }
            return null;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public List<Order> getPendingOrders() {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id IN (SELECT order_id FROM " + orderStatusTableName + " GROUP BY order_id HAVING COUNT(order_id) = 1)";
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            List<Order> order = new ArrayList<>();
            while (rs.next()) {
                Order orderObj = new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("payment_method"),
                        rs.getInt("card_id"),
                        rs.getDouble("price"),
                        rs.getDouble("shipping_fee"),
                        rs.getDouble("tax"),
                        rs.getDouble("discount"),
                        rs.getDouble("final_price"),
                        rs.getDate("create_date"));
                order.add(orderObj);
            }
            return order;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public List<Order> getShippedOrders() {
        // exclude "Your order has been delivered to your place."
        String queryStr = "SELECT * FROM " + tableName + " WHERE id NOT IN (SELECT order_id FROM " + orderStatusTableName + " WHERE CAST(status AS VARCHAR(256)) = 'Your order has been delivered to your place.' GROUP BY order_id HAVING COUNT(order_id) = 1)";
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            List<Order> order = new ArrayList<>();
            while (rs.next()) {
                Order orderObj = new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("payment_method"),
                        rs.getInt("card_id"),
                        rs.getDouble("price"),
                        rs.getDouble("shipping_fee"),
                        rs.getDouble("tax"),
                        rs.getDouble("discount"),
                        rs.getDouble("final_price"),
                        rs.getDate("create_date"));
                order.add(orderObj);
            }
            return order;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public List<Order> getCompletedOrders() {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id IN (SELECT order_id FROM " + orderStatusTableName + " WHERE CAST(status AS VARCHAR(256)) = 'Your order has been delivered to your place.' GROUP BY order_id HAVING COUNT(order_id) = 1)";
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            List<Order> order = new ArrayList<>();
            while (rs.next()) {
                Order orderObj = new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("payment_method"),
                        rs.getInt("card_id"),
                        rs.getDouble("price"),
                        rs.getDouble("shipping_fee"),
                        rs.getDouble("tax"),
                        rs.getDouble("discount"),
                        rs.getDouble("final_price"),
                        rs.getDate("create_date"));
                order.add(orderObj);
            }
            return order;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
}
