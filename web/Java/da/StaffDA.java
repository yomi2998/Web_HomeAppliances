package da;

import domain.Staff;
import java.sql.*;
import Java.TokenGenerator;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author superme
 */
public class StaffDA {

    private String host = "jdbc:derby://localhost:1527/HomeAppliances";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "staff";
    private String sessionTableName = "staff_session";
    private Connection conn;
    private PreparedStatement stmt;

    public StaffDA() {
        createConnection();
    }

    public boolean deleteStaff(int id) {
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

    public boolean updateStaff(Staff staff) {
        String queryStr = "UPDATE " + tableName + " SET name = ?, email = ?, birth_date = ?, contact_number = ? WHERE id = ? AND password = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, staff.getName());
            stmt.setString(2, staff.getEmail());
            stmt.setDate(3, new java.sql.Date(staff.getBirth_date().getTime()));
            stmt.setString(4, staff.getContact_number());
            stmt.setInt(5, staff.getId());
            stmt.setString(6, staff.getPassword());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean updateStaffPassword(int id, String oldPass, String newPass) {
        String queryStr = "UPDATE " + tableName + " SET password = ? WHERE id = ? AND password = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, newPass);
            stmt.setInt(2, id);
            stmt.setString(3, oldPass);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean updateStaffPrivileged(Staff staff) {
        String queryStr = "UPDATE " + tableName + " SET name = ?, username = ?, email = ?, birth_date = ?, contact_number = ? WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, staff.getName());
            stmt.setString(2, staff.getUsername());
            stmt.setString(3, staff.getEmail());
            stmt.setDate(4, new java.sql.Date(staff.getBirth_date().getTime()));
            stmt.setString(5, staff.getContact_number());
            stmt.setInt(6, staff.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public boolean insertStaff(Staff staff) {
        String queryStr = "INSERT INTO " + tableName + " (name, username, password, email, birth_date, contact_number) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, staff.getName());
            stmt.setString(2, staff.getUsername());
            stmt.setString(3, staff.getPassword());
            stmt.setString(4, staff.getEmail());
            stmt.setDate(5, new java.sql.Date(staff.getBirth_date().getTime()));
            stmt.setString(6, staff.getContact_number());
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public Staff retrieveStaff(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Staff(rs.getInt("id"), rs.getString("name"), rs.getString("username"), rs.getString("email"),
                        rs.getString("password"),
                        rs.getDate("birth_date"), rs.getString("contact_number"), rs.getDate("join_date"), null);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
        return null;
    }

    public List<Staff> retrieveStaffALL() {
        String queryStr = "SELECT * FROM " + tableName;
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            List<Staff> staffs = new ArrayList<>();
            while (rs.next()) {
                staffs.add(new Staff(rs.getInt("id"), rs.getString("name"), rs.getString("username"), rs.getString("email"),
                        rs.getString("password"),
                        rs.getDate("birth_date"), rs.getString("contact_number"), rs.getDate("join_date"), null));
            }
            return staffs;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public Staff verifySession(int id, String session) {
        String queryStr = "SELECT * FROM " + sessionTableName + " WHERE session_id = ? AND staff_id = ?";
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
                    return new Staff(rs.getInt("id"), rs.getString("name"), rs.getString("username"), rs.getString("email"),
                        rs.getString("password"),
                        rs.getDate("birth_date"), rs.getString("contact_number"), rs.getDate("join_date"), session);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
        return null;
    }

    public Staff verifyLogin(String username, String password) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE username = ? AND password = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                System.out.println("Login successful for staff " + Integer.toString(rs.getInt("id")));
                return new Staff(rs.getInt("id"), rs.getString("name"), rs.getString("username"), rs.getString("email"),
                        rs.getString("password"),
                        rs.getDate("birth_date"), rs.getString("contact_number"), rs.getDate("join_date"), createSessionID(rs.getInt("id")));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return null;
        }
        return null;
    }

    public boolean confirmPassword(int id, String password) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ? AND password = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private String createSessionID(int id) {
        System.out.println("Creating Session ID for staff " + Integer.toString(id));
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
        String queryStr = "INSERT INTO " + sessionTableName + " (staff_id, session_id) VALUES (?, ?)";
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
        String queryStr = "DELETE FROM " + sessionTableName + " WHERE staff_id = ? AND session_id = ?";
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

    public boolean validateUsername(String username) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE username = ?";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, username);
            return stmt.executeQuery().next();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public int countTotalStaff() {
        String queryStr = "SELECT COUNT(*) FROM " + tableName;
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return 0;
    }

    public void destroy() {
        try {
            conn.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
