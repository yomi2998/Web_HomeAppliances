/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Card;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author superme
 */
public class CardDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "card";
    private Connection conn;
    private PreparedStatement stmt;

    public CardDA() {
        createConnection();
    }

    public boolean deleteCard(int id) {
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

    public boolean updateCard(Card card) {
        String queryStr = "UPDATE " + tableName + " SET name = ?, card_number = ?, expiry_date = ?, cvv = ? WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, card.getName());
            stmt.setString(2, card.getCard_number());
            stmt.setString(3, card.getExpiry_date());
            stmt.setString(4, card.getCvv());
            stmt.setInt(5, card.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean insertCard(Card card, int user_id) {
        String queryStr = "INSERT INTO " + tableName + " (user_id, name, card_number, expiry_date, cvv) VALUES (?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, user_id);
            stmt.setString(2, card.getName());
            stmt.setString(3, card.getCard_number());
            stmt.setString(4, card.getExpiry_date());
            stmt.setString(5, card.getCvv());
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public List<Card> retrieveCards(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE user_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            List<Card> cards = new ArrayList<>();
            while (rs.next()) {
                cards.add(new Card(rs.getInt("id"), rs.getInt("user_id"), rs.getString("name"), rs.getString("card_number"), rs.getString("expiry_date"), rs.getString("cvv")));
            }
            return cards;
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
