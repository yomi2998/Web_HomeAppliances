/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import java.util.Date;

/**
 *
 * @author superme
 */
public class Staff {
    private int id;
    private String name;
    private String username;
    private String email;
    private String password;
    private Date birth_date;
    private String contact_number;
    private Date dateJoined;
    private String session;
    
    public Staff() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getBirth_date() {
        return birth_date;
    }

    public void setBirth_date(Date birth_date) {
        this.birth_date = birth_date;
    }

    public String getContact_number() {
        return contact_number;
    }

    public void setContact_number(String contact_number) {
        this.contact_number = contact_number;
    }

    public Staff(String name, String username, String email, String password, Date birth_date, String contact_number) {
        this.name = name;
        this.username = username;
        this.email = email;
        this.password = password;
        this.birth_date = birth_date;
        this.contact_number = contact_number;
    }

    public Date getDateJoined() {
        return dateJoined;
    }

    public void setDateJoined(Date dateJoined) {
        this.dateJoined = dateJoined;
    }

    public String getSession() {
        return session;
    }

    public void setSession(String session) {
        this.session = session;
    }

    public Staff(int id, String name, String username, String email, String password, Date birth_date, String contact_number, Date dateJoined, String session) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.email = email;
        this.password = password;
        this.birth_date = birth_date;
        this.contact_number = contact_number;
        this.dateJoined = dateJoined;
        this.session = session;
    }
}
