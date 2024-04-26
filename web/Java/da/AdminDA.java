/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Admin;
import java.sql.*;
import Java.TokenGenerator;

/**
 *
 * @author superme
 */
public class AdminDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "admin";
    private String sessionTableName = "admin_session";
    private Connection conn;
    private PreparedStatement stmt;

    public AdminDA() {
        createConnection();
    }

    public Admin verifySession(int id, String session) {
        String queryStr = "SELECT * FROM " + sessionTableName + " WHERE session_id = ? AND admin_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, session);
            stmt.setInt(2, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
                stmt = conn.prepareStatement(queryStr);
                stmt.setInt(1, id);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    return new Admin(rs.getInt("id"), rs.getString("username"), rs.getString("password"), session);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
        return null;
    }

    public Admin verifyLogin(String username, String password) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE username = ? AND password = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Admin(rs.getInt("id"), rs.getString("username"),
                        rs.getString("password"), createSessionID(rs.getInt("id")));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
        return null;
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private String createSessionID(int id) {
        while (true) {
            String session = TokenGenerator.generateToken(512);
            String queryStr = "SELECT * FROM " + sessionTableName + " WHERE session_id = ?";
            try {
                stmt = conn.prepareStatement(queryStr);
                stmt.setString(1, session);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()
                        && assignSession(id, session)) {
                    return session;
                }
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
                return null;
            }
        }
    }

    private boolean assignSession(int id, String session) {
        String queryStr = "INSERT INTO " + sessionTableName + " (admin_id, session_id) VALUES (?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            stmt.setString(2, session);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean deleteSession(int id, String session) {
        String queryStr = "DELETE FROM " + sessionTableName + " WHERE admin_id = ? AND session_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            stmt.setString(2, session);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
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
