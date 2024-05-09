// /*
//  * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
//  * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
//  */
// package da;

// import domain.OrderStatus;
// import java.sql.Connection;
// import java.sql.DriverManager;
// import java.sql.PreparedStatement;
// import java.sql.ResultSet;
// import java.sql.SQLException;
// import java.util.ArrayList;
// import java.util.List;


// /**
//  *
//  * @author superme
//  */
// public class OrderStatusDA {

//     private String host = "jdbc:derby://localhost:1527/HomeAppliances";
//     private String user = "nbuser";
//     private String password = "nbuser";
//     private String tableName = "order_status";
//     private Connection conn;
//     private PreparedStatement stmt;

//     public OrderStatusDA() {
//         createConnection();
//     }

//     public boolean insertStatus(OrderStatus op) {
//         String queryStr = "INSERT INTO " + tableName + " (order_id, status) VALUES (?, ?)";
//         try {
//             stmt = conn.prepareStatement(queryStr);
//             stmt.setInt(1, op.getOrder_id());
//             stmt.setString(2, op.getStatus());
//             return stmt.executeUpdate() > 0;
//         } catch (SQLException ex) {
//             System.out.println(ex.getMessage());
//         }
//         return false;
//     }
    
//     public List<OrderStatus> getOrderStatus(int order_id) {
//         String queryStr = "SELECT * FROM " + tableName + " WHERE order_id = ? ORDER BY create_date DESC";
//         try {
//             stmt = conn.prepareStatement(queryStr);
//             stmt.setInt(1, order_id);
//             ResultSet rs = stmt.executeQuery();
//             List<OrderStatus> osList = new ArrayList<>();
//             while (rs.next()) {
//                 osList.add(new OrderStatus(rs.getInt("id"), rs.getInt("order_id"), rs.getString("status"), rs.getDate("create_date")));
//             }
//             return osList;
//         } catch (SQLException ex) {
//             System.out.println(ex.getMessage());
//             return null;
//         }
//     }

//     private void createConnection() {
//         try {
//             conn = DriverManager.getConnection(host, user, password);
//         } catch (SQLException ex) {
//             System.out.println(ex.getMessage());
//         }
//     }

//     public void destroy() {
//         try {
//             conn.close();
//         } catch (SQLException ex) {
//             System.out.println(ex.getMessage());
//         }
//     }

// }
