/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import da.AddressDA;
import domain.Address;
import java.util.List;

/**
 *
 * @author superme
 */
public class AddressControl {

    private AddressDA addressDA;

    public AddressControl() {
        addressDA = new AddressDA();
    }

    public boolean insertAddress(Address address) {
        return addressDA.insertAddress(address);
    }

    public List<Address> retrieveAddresses(int id) {
        return addressDA.retrieveAddresses(id);
    }

    public boolean updateAddress(Address address) {
        return addressDA.updateAddress(address);
    }

    public boolean deleteAddress(int id) {
        return addressDA.deleteAddress(id);
    }

    public void destroy() {
        addressDA.destroy();
    }
}
