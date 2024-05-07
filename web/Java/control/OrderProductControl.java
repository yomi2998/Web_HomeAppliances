/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import domain.OrderProduct;
import da.OrderProductDA;
import java.util.List;
/**
 *
 * @author superme
 */
public class OrderProductControl {
    OrderProductDA orderProductDA;
    
    public OrderProductControl() {
        orderProductDA = new OrderProductDA();
    }
    
    public boolean insertProduct(OrderProduct op) {
        return orderProductDA.insertProduct(op);
    }
    
    public List<OrderProduct> getOrderProduct(int order_id) {
        return orderProductDA.getOrderProduct(order_id);
    }
}
