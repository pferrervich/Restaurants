package com.iesemilidarder.restaurants.web;

/**
 * Atributs, getters i setters
 */

public class Users {
    private String name;
    private String password;
    private String email;
    private String code;


    public Users() {
        this.name = name;
        this.password = password;
        this.email = email;
        this.code = code;
    }

    public String getUser() {
        return name;
    }

    public void setUsers(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
