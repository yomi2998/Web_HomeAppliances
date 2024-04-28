package Java.da;

import domain.Customer;
import java.sql.*;
import Java.TokenGenerator;
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
    private Connection conn;
    private PreparedStatement stmt;
    
    public AddressDA(){
    createConnection();
}

        public AddressDA(int iD, String address, String name, int contact) {
        //TODO Auto-generated constructor stub
    }

        private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private boolean assignAddress(int ID, String address , String name , int contact){
    String queryStr = "INSERT INTO " + tableName + "(ID,address,recipient_name,contact_number) VALUES(?,?,?,?)";
    try{
        stmt = conn.prepareStatement(queryStr);
        stmt.setInt(1, ID);
        stmt.setString(2, address);
        stmt.setString(3, name);
        stmt.setInt(4, contact);
        stmt.executeUpdate();
        return true;
    }catch(SQLException ex){
        System.out.println(ex.getMessage());
        return false;
    }
    }
    

    public List<Address> getAddresses() {
        List<Address> addressList = new ArrayList<>();
        String queryStr = "SELECT * FROM " + tableName;
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int ID = rs.getInt("ID");
                String address = rs.getString("address");
                String name = rs.getString("recipient_name");
                int contact = rs.getInt("contact_number");
                addressList.add(new Address(ID, address, name, contact));
            }
            return addressList;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
}
