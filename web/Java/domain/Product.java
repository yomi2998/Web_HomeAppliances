/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import domain.*;
import java.util.Objects;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Nelson
 */
public class Product implements Serializable {

    private int id;
    private String name;
    private String display_image_url;
    private String description;
    private double price;
    private int stock;
    private int sold;
    private int category_id;
    private Date create_date;

    public Product() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDisplay_image_url() {
        return display_image_url;
    }

    public void setDisplay_image_url(String display_image_url) {
        this.display_image_url = display_image_url;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public Product(int id, String name, String display_image_url, String description, double price, int stock, int sold, int category_id, Date create_date) {
        this.id = id;
        this.name = name;
        this.display_image_url = display_image_url;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.sold = sold;
        this.category_id = category_id;
        this.create_date = create_date;
    }
}
