/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author superme
 */
public class Card {
    private int id;
    private int user_id;
    private String name; // cardholder
    private String card_number;
    private String expiry_date;
    private String cvv;

    public Card(int user_id, String name, String card_number, String expiry_date, String cvv) {
        this.user_id = user_id;
        this.name = name;
        this.card_number = card_number;
        this.expiry_date = expiry_date;
        this.cvv = cvv;
    }

    public Card(int id, int user_id, String name, String card_number, String expiry_date, String cvv) {
        this.id = id;
        this.user_id = user_id;
        this.name = name;
        this.card_number = card_number;
        this.expiry_date = expiry_date;
        this.cvv = cvv;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCard_number() {
        return card_number;
    }

    public void setCard_number(String card_number) {
        this.card_number = card_number;
    }

    public String getExpiry_date() {
        return expiry_date;
    }

    public void setExpiry_date(String expiry_date) {
        this.expiry_date = expiry_date;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }
}
