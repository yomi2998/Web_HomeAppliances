/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import domain.*;
import java.util.Objects;
import java.io.Serializable;

/**
 *
 * @author Phuah
 */
public class Payment implements Serializable{
    private String ID;
    private String User_ID;
    private String ADDRESS;
    private String RECEIPIENT_NAME;
    private String CONTACT_NUMBER;

    public Payment(String ID, String User_ID, String ADDRESS, String RECEIPIENT_NAME, String CONTACT_NUMBER) {
        this.ID = ID;
        this.User_ID = User_ID;
        this.ADDRESS = ADDRESS;
        this.RECEIPIENT_NAME = RECEIPIENT_NAME;
        this.CONTACT_NUMBER = CONTACT_NUMBER;
        
    }

    public String getID() {
        return ID;
    }

    public String getUser_ID() {
        return User_ID;
    }

    public String getADDRESS() {
        return ADDRESS;
    }

    public String getRECEIPIENT_NAME() {
        return RECEIPIENT_NAME;
    }

    public String getCONTACT_NUMBER() {
        return CONTACT_NUMBER;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public void setUser_ID(String User_ID) {
        this.User_ID = User_ID;
    }

    public void setADDRESS(String ADDRESS) {
        this.ADDRESS = ADDRESS;
    }

    public void setRECEIPIENT_NAME(String RECEIPIENT_NAME) {
        this.RECEIPIENT_NAME = RECEIPIENT_NAME;
    }

    public void setCONTACT_NUMBER(String CONTACT_NUMBER) {
        this.CONTACT_NUMBER = CONTACT_NUMBER;
    }

}
