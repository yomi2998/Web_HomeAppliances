/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import domain.Admin;
import da.AdminDA;

/**
 *
 * @author superme
 */
public class AdminControl {

    private AdminDA adminDA;

    public AdminControl() {
        adminDA = new AdminDA();
    }

    public Admin verifySession(int id, String session) {
        return adminDA.verifySession(id, session);
    }

    public Admin verifyLogin(String username, String password) {
        return adminDA.verifyLogin(username, password);
    }

    public boolean deleteSession(int id, String session) {
        return adminDA.deleteSession(id, session);
    }
}
