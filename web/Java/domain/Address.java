/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import java.io.Serializable;

/**
 *
 * @author Phuah
 */
public class Address {

    private int id;
    private int user_id;
    private String address;
    private String address_2;
    private String city;
    private String state;
    private String zip_code;
    private String recipient_name;
    private String contact_number;

    @Override
    public String toString() {
        return recipient_name + " " + contact_number + " " + address + " " + address_2 + " " + city + " " + state + " " + zip_code;
    }

    public Address() {
    }

    public Address(int user_id, String address, String address_2, String city, String state, String zip_code, String recipient_name, String contact_number) {
        this.user_id = user_id;
        this.address = address;
        this.address_2 = address_2;
        this.city = city;
        this.state = state;
        this.zip_code = zip_code;
        this.recipient_name = recipient_name;
        this.contact_number = contact_number;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress_2() {
        return address_2;
    }

    public void setAddress_2(String address_2) {
        this.address_2 = address_2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZip_code() {
        return zip_code;
    }

    public void setZip_code(String zip_code) {
        this.zip_code = zip_code;
    }

    public String getRecipient_name() {
        return recipient_name;
    }

    public void setRecipient_name(String recipient_name) {
        this.recipient_name = recipient_name;
    }

    public String getContact_number() {
        return contact_number;
    }

    public void setContact_number(String contact_number) {
        this.contact_number = contact_number;
    }

    public Address(int id, int user_id, String address, String address_2, String city, String state, String zip_code, String recipient_name, String contact_number) {
        this.id = id;
        this.user_id = user_id;
        this.address = address;
        this.address_2 = address_2;
        this.city = city;
        this.state = state;
        this.zip_code = zip_code;
        this.recipient_name = recipient_name;
        this.contact_number = contact_number;
    }
}
