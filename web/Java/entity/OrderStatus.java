/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;
import java.util.*;
import jakarta.persistence.*;
import jakarta.xml.bind.annotation.*;
/**
 *
 * @author superme
 */
@Entity
@Table(name = "order_status")
@XmlRootElement

@NamedQueries({
    @NamedQuery(name = "OrderStatus.findAll", query = "SELECT o FROM OrderStatus o ORDER BY o.create_date DESC"),
    @NamedQuery(name = "OrderStatus.findById", query = "SELECT o FROM OrderStatus o WHERE o.id = :id")})
public class OrderStatus {
    @Id
    @Basic(optional = false)
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "ORDER_ID")
    private int order_id;
    @Column(name = "STATUS")
    private String status;
    @Column(name = "CREATE_DATE")
    private Date create_date;

    public OrderStatus(int id, int order_id, String status, Date create_date) {
        this.id = id;
        this.order_id = order_id;
        this.status = status;
        this.create_date = create_date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }
}
