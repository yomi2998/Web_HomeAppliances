package da;

import domain.Customer;
import java.sql.*;
import Java.TokenGenerator;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author superme
 */
public class CustomerDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "customer";
    private String sessionTableName = "customer_session";
    private Connection conn;
    private PreparedStatement stmt;

    public CustomerDA() {
        createConnection();
    }

    public boolean deleteCustomer(int id) {
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

    public boolean updateCustomer(Customer customer) {
        String queryStr = "UPDATE " + tableName + " SET name = ?, username = ?, password = ?, email = ?, balance = ?, birth_date = ? WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getUsername());
            stmt.setString(3, customer.getPassword());
            stmt.setString(4, customer.getEmail());
            stmt.setDouble(5, customer.getBalance());
            stmt.setDate(6, new java.sql.Date(customer.getBirthDate().getTime()));
            stmt.setInt(7, customer.getId());
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean insertCustomer(Customer customer) {
        String queryStr = "INSERT INTO " + tableName + " (name, username, password, email, balance, birth_date) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getUsername());
            stmt.setString(3, customer.getPassword());
            stmt.setString(4, customer.getEmail());
            stmt.setDouble(5, customer.getBalance());
            stmt.setDate(6, new java.sql.Date(customer.getBirthDate().getTime()));
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public Customer retrieveCustomer(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Customer(rs.getInt("id"), rs.getString("name"), rs.getString("username"),
                        rs.getString("password"), rs.getString("email"), rs.getDouble("balance"),
                        rs.getDate("birth_date"), rs.getDate("join_date"), null);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
        return null;
    }

    public List<Customer> retrieveCustomerALL() {
        String queryStr = "SELECT * FROM " + tableName;
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            List<Customer> customers = new ArrayList<>();
            while (rs.next()) {
                customers.add(new Customer(rs.getInt("id"), rs.getString("name"), rs.getString("username"),
                        rs.getString("password"), rs.getString("email"), rs.getDouble("balance"),
                        rs.getDate("birth_date"), rs.getDate("join_date"), null));
            }
            return customers;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public Customer verifySession(int id, String session) {
        String queryStr = "SELECT * FROM " + sessionTableName + " WHERE session_id = ? AND user_id = ?";
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
                    return new Customer(rs.getInt("id"), rs.getString("name"), rs.getString("username"),
                            rs.getString("password"), rs.getString("email"), rs.getDouble("balance"),
                            rs.getDate("birth_date"), rs.getDate("join_date"), session);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
        return null;
    }

    public Customer verifyLogin(String username, String password) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE username = ? AND password = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                System.out.println("Login successful for customer " + Integer.toString(rs.getInt("id")));
                return new Customer(rs.getInt("id"), rs.getString("name"), rs.getString("username"),
                        rs.getString("password"), rs.getString("email"), rs.getDouble("balance"),
                        rs.getDate("birth_date"), rs.getDate("join_date"), createSessionID(rs.getInt("id")));
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
        System.out.println("Creating Session ID for customer " + Integer.toString(id));
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
        String queryStr = "INSERT INTO " + sessionTableName + " (user_id, session_id) VALUES (?, ?)";
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
        String queryStr = "DELETE FROM " + sessionTableName + " WHERE user_id = ? AND session_id = ?";
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
