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
public class Address {
    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "SHIPPING_DETAILS";
    private Connection conn;
    private PreparedStatement stmt;
    
    public Address(){
    createConnection();
}
        private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
