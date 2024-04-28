package Java.control;

import domain.Customer;
import da.CustomerDA;
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

    public boolean updateCustomer(Customer customer) {
        return customerDA.updateCustomer(customer);
    }

    public boolean deleteCustomer(int id) {
        return customerDA.deleteCustomer(id);
    }

    public Customer verifySession(String session) {
        return customerDA.verifySession(session);
    }

    public Customer verifyLogin(String username, String password) {
        return customerDA.verifyLogin(username, password);
    }
}
