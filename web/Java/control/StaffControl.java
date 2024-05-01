package control;

import domain.Staff;
import da.StaffDA;
import java.util.List;

public class StaffControl {

    private StaffDA staffDA;

    public StaffControl() {
        staffDA = new StaffDA();
    }

    public boolean insertStaff(Staff staff) {
        return staffDA.insertStaff(staff);
    }

    public Staff retrieveStaff(int id) {
        return staffDA.retrieveStaff(id);
    }

    public List<Staff> retrieveStaffALL() {
        return staffDA.retrieveStaffALL();
    }

    public boolean updateStaff(Staff staff) {
        return staffDA.updateStaff(staff);
    }
    
    public boolean updateStaffPassword(int id, String old, String newPass) {
        return staffDA.updateStaffPassword(id, old, newPass);
    }

    public boolean deleteStaff(int id) {
        return staffDA.deleteStaff(id);
    }

    public Staff verifySession(int id, String session) {
        return staffDA.verifySession(id, session);
    }

    public Staff verifyLogin(String username, String password) {
        return staffDA.verifyLogin(username, password);
    }

    public boolean deleteSession(int id, String session) {
        return staffDA.deleteSession(id, session);
    }
    
    public boolean validateUsername(String username) {
        return staffDA.validateUsername(username);
    }
    
    public boolean confirmPassword(int id, String password) {
        return staffDA.confirmPassword(id, password);
    }

    public int countTotalStaff() {
        return staffDA.countTotalStaff();
    }

    public void destroy() {
        staffDA.destroy();
    }
}
