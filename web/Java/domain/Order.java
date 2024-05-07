/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;
import control.*;
import java.util.*;
/**
 *
 * @author superme
 */
public class Order {
    private int id;
    private int user_id;
    private String payment_method;
    private int card_id;
    private double price;
    private double shipping_fee;
    private double tax;
    private double discount;
    private double final_price;
    private Date create_date;
    
    private Address cust_order_address;
    private List<OrderProduct> order_product;
    private List<OrderStatus> order_status;

    public Order(int id, int user_id, String payment_method, int card_id, double price, double shipping_fee, double tax, double discount, double final_price, Date create_date) {
        this.id = id;
        this.user_id = id;
        this.payment_method = payment_method;
        this.card_id = card_id;
        this.price = price;
        this.shipping_fee = shipping_fee;
        this.tax = tax;
        this.discount = discount;
        this.final_price = final_price;
        this.create_date = create_date;
        AddressControl ac = new AddressControl();
        cust_order_address = ac.retrieveAddressFromOrder(id);
        OrderProductControl oc = new OrderProductControl();
        order_product = oc.getOrderProduct(id);
        OrderStatusControl os = new OrderStatusControl();
        order_status = os.getOrderStatus(id);
    }

    public List<OrderStatus> getOrder_status() {
        return order_status;
    }

    public void setOrder_status(List<OrderStatus> order_status) {
        this.order_status = order_status;
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

    public String getPayment_method() {
        return payment_method;
    }

    public void setPayment_method(String payment_method) {
        this.payment_method = payment_method;
    }

    public int getCard_id() {
        return card_id;
    }

    public void setCard_id(int card_id) {
        this.card_id = card_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getShipping_fee() {
        return shipping_fee;
    }

    public void setShipping_fee(double shipping_fee) {
        this.shipping_fee = shipping_fee;
    }

    public double getTax() {
        return tax;
    }

    public void setTax(double tax) {
        this.tax = tax;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getFinal_price() {
        return final_price;
    }

    public void setFinal_price(double final_price) {
        this.final_price = final_price;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public Address getCust_order_address() {
        return cust_order_address;
    }

    public void setCust_order_address(Address cust_order_address) {
        this.cust_order_address = cust_order_address;
    }

    public List<OrderProduct> getOrder_product() {
        return order_product;
    }

    public void setOrder_product(List<OrderProduct> order_product) {
        this.order_product = order_product;
    }
    
    
}
