/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Feedback;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author superme
 */
public class FeedbackDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "feedback";
    private Connection conn;
    private PreparedStatement stmt;

    public void destroy() {
        try {
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public FeedbackDA() {
        createConnection();
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public boolean insertFeedback(Feedback feedback) {
        String queryStr = "INSERT INTO FEEDBACK (user_id, title, description) VALUES (?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, feedback.getUser_id());
            stmt.setString(2, feedback.getTitle());
            stmt.setString(3, feedback.getDescription());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }
    
    public List<Feedback> retrieveFeedback(int user_id) {
        String queryStr = "SELECT * FROM FEEDBACK WHERE USER_ID = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, user_id);
            ResultSet rs = stmt.executeQuery();
            List feedbackList = new ArrayList<>();
            while (rs.next()) {
                feedbackList.add(new Feedback(rs.getInt("id"), user_id, rs.getString("title"), rs.getString("description"), rs.getBoolean("is_resolved"), rs.getString("comment"), rs.getDate("create_date")));
            }
            return feedbackList;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
    
    public boolean updateFeedback(Feedback feedback) {
        String queryStr = "UPDATE FEEDBACK SET is_resolved = ?, comment = ? WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setBoolean(1, feedback.getIs_resolved());
            stmt.setString(2, feedback.getComment());
            stmt.setInt(3, feedback.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }
}
