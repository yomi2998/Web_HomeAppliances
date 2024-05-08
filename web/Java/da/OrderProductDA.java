/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.OrderProduct;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import domain.Product;
import control.ProductControl;


/**
 *
 * @author superme
 */
public class OrderProductDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "order_product";
    private Connection conn;
    private PreparedStatement stmt;

    public OrderProductDA() {
        createConnection();
    }

    public boolean insertProduct(OrderProduct op) {
        String queryStr = "INSERT INTO " + tableName + " (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, op.getId());
            stmt.setInt(2, op.getProduct_id());
            stmt.setInt(3, op.getQuantity());
            stmt.setDouble(4, op.getPrice());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }
    
    public List<OrderProduct> getOrderProduct(int order_id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE order_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, order_id);
            ResultSet rs = stmt.executeQuery();
            List<OrderProduct> opList = new ArrayList<>();
            while (rs.next()) {
                ProductControl pc = new ProductControl();
                Product product = pc.retrieveProduct(rs.getInt("product_id"));
                OrderProduct op = new OrderProduct(rs.getInt("id"), order_id, rs.getInt("product_id"), rs.getInt("quantity"), rs.getDouble("price"));
                op.setProduct(product);
                opList.add(op);
            }
            return opList;
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
