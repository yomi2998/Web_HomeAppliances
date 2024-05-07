package da;

import domain.Address;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Phuah
 */
public class AddressDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "shipping_details";
    private String addrOrderTableName = "cust_order_address";
    private Connection conn;
    private PreparedStatement stmt;

    public AddressDA() {
        createConnection();
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public boolean deleteAddress(int id) {
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

    public boolean updateAddress(Address address) {
        String queryStr = "UPDATE " + tableName + " SET address = ?, address_2 = ?, city = ?, state = ?, zip_code = ?, recipient_name = ?, contact_number = ? WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, address.getAddress());
            stmt.setString(2, address.getAddress_2());
            stmt.setString(3, address.getCity());
            stmt.setString(4, address.getState());
            stmt.setString(5, address.getZip_code());
            stmt.setString(6, address.getRecipient_name());
            stmt.setString(7, address.getContact_number());
            stmt.setInt(8, address.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean insertAddress(Address address) {
        String queryStr = "INSERT INTO " + tableName + " (user_id, address, address_2, city, state, zip_code, recipient_name, contact_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, address.getUser_id());
            stmt.setString(2, address.getAddress());
            stmt.setString(3, address.getAddress_2());
            stmt.setString(4, address.getCity());
            stmt.setString(5, address.getState());
            stmt.setString(6, address.getZip_code());
            stmt.setString(7, address.getRecipient_name());
            stmt.setString(8, address.getContact_number());
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public List<Address> retrieveAddresses(int user_id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE user_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, user_id);
            ResultSet rs = stmt.executeQuery();
            List<Address> addresses = new ArrayList<>();

            while (rs.next()) {
                addresses.add(new Address(rs.getInt("id"), rs.getInt("user_id"), rs.getString("address"), rs.getString("address_2"),
                        rs.getString("city"), rs.getString("state"), rs.getString("zip_code"), rs.getString("recipient_name"),
                        rs.getString("contact_number")));
            }
            return addresses;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public Address retrieveAddress(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Address(rs.getInt("id"), rs.getInt("user_id"), rs.getString("address"), rs.getString("address_2"),
                        rs.getString("city"), rs.getString("state"), rs.getString("zip_code"), rs.getString("recipient_name"),
                        rs.getString("contact_number"));
            }
            return null;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public Address retrieveLatestAddress(int user_id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE user_id = ? ORDER BY create_date DESC FETCH FIRST ROW ONLY";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, user_id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Address(rs.getInt("id"), rs.getInt("user_id"), rs.getString("address"), rs.getString("address_2"),
                        rs.getString("city"), rs.getString("state"), rs.getString("zip_code"), rs.getString("recipient_name"),
                        rs.getString("contact_number"));
            }
            return null;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
    
    public Address retrieveAddressFromOrder(int order_id) {
        String queryStr = "SELECT * FROM " + addrOrderTableName + " WHERE order_id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, order_id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Address(0, 0, rs.getString("address"), rs.getString("address_2"),
                        rs.getString("city"), rs.getString("state"), rs.getString("zip_code"), rs.getString("recipient_name"),
                        rs.getString("contact_number"));
            }
            return null;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
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
