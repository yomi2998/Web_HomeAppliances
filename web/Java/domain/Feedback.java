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
public class Feedback {

    private int id;
    private int user_id;
    private String title;
    private String description;
    private boolean is_resolved;
    private String comment;
    private Date create_date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean getIs_resolved() {
        return is_resolved;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public void setIs_resolved(boolean is_resolved) {
        this.is_resolved = is_resolved;
    }

    public Feedback(int id, int user_id, String title, String description, boolean is_resolved, String comment, Date create_date) {
        this.id = id;
        this.user_id = user_id;
        this.title = title;
        this.description = description;
        this.is_resolved = is_resolved;
        this.comment = comment;
        this.create_date = create_date;
    }

    public Feedback(int user_id, String title, String description) {
        this.user_id = user_id;
        this.title = title;
        this.description = description;
    }

    
}
