package com.ghostchu.ytkj.drivelicensestudy.bean;

public class User {
    private long id;
    private String email;
    private String username;
    private String passwordHash;
    private int admin;

    public User() {
    }

    public User(long id, String email, String username, String passwordHash, int admin) {
        this.id = id;
        this.email = email;
        this.username = username;
        this.passwordHash = passwordHash;
        this.admin = admin;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public boolean isAdmin(){
        return this.admin == 1;
    }

    public void setAdmin(boolean is){
        this.admin = is ? 1 : 0;
    }
}
