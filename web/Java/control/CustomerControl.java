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
    
    public boolean validateUsername(String username) {
        return customerDA.validateUsername(username);
    }

    public void destroy() {
        customerDA.destroy();
    }
}
