/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;
import da.OrderDA;
import domain.Order;
import java.util.List;
/**
 *
 * @author superme
 */
public class OrderControl {
    OrderDA orderDA;

    public OrderControl() {
        orderDA = new OrderDA();
    }

    public boolean insertOrder(Order order) {
        return orderDA.insertOrder(order);
    }

    public List<Order> retrieveOrder(int user_id) {
        return orderDA.retrieveOrder(user_id);
    }

    public List<Order> getPendingOrders() {
        return orderDA.getPendingOrders();
    }

    public List<Order> getShippedOrders() {
        return orderDA.getShippedOrders();
    }

    public List<Order> getCompletedOrders() {
        return orderDA.getCompletedOrders();
    }
    
    public Order retrieveOrderById(int order_id) {
        return orderDA.retrieveOrderById(order_id);
    }
}
