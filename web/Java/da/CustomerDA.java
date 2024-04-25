/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Java.da;
import java.sql.*;

/**
 *
 * @author superme
 */
public class CustomerDA {
    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Customer";
    private Connection conn;
    private PreparedStatement stmt;

        
    public CustomerDA() {
        createConnection();
    }
    
    public Programme verifySession(String code) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE Code = ?";
        Programme programme = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                programme = new Programme(code, rs.getString("Name"), rs.getString("Faculty"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return programme;
    }
    
        
    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
