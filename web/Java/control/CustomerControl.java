package control;

import domain.Customer;
import da.CustomerDA;
import java.util.List;

public class CustomerControl {

    private CustomerDA customerDA;

    public CustomerControl() {
        customerDA = new CustomerDA();
    }

    public boolean insertCustomer(Customer customer) {
        return customerDA.insertCustomer(customer);
    }

    public Customer retrieveCustomer(int id) {
        return customerDA.retrieveCustomer(id);
    }

    public List<Customer> retrieveCustomerALL() {
        return customerDA.retrieveCustomerALL();
    }

    public boolean updateCustomer(Customer customer) {
        return customerDA.updateCustomer(customer);
    }

    public boolean updateCustomerPrivileged(Customer customer) {
        return customerDA.updateCustomerPrivileged(customer);
    }
    
    public boolean updateCustomerPassword(int id, String old, String newPass) {
        return customerDA.updateCustomerPassword(id, old, newPass);
    }

    public boolean deleteCustomer(int id) {
        return customerDA.deleteCustomer(id);
    }

    public Customer verifySession(int id, String session) {
        return customerDA.verifySession(id, session);
    }

    public Customer verifyLogin(String username, String password) {
        return customerDA.verifyLogin(username, password);
    }

    public boolean deleteSession(int id, String session) {
        return customerDA.deleteSession(id, session);
    }
    
    public boolean validateUsername(String username, int id) {
        return customerDA.validateUsername(username, id);
    }

    public boolean validateUsername(String username) {
        return customerDA.validateUsername(username);
    }
    
    public boolean confirmPassword(int id, String password) {
        return customerDA.confirmPassword(id, password);
    }
    
    public boolean topUp(int id, int card_id, String password, double amt) {
        return customerDA.topUp(id, card_id, password, amt);
    }

    public int countTotalCustomer() {
        return customerDA.countTotalCustomer();
    }

    public void destroy() {
        customerDA.destroy();
    }
}
