package com.ghostchu.ytkj.drivelicensestudy.bean;

public class Study {
    private long id;
    private String category;
    private String title;
    private String description;
    private String bvnumber;

    public Study() {
    }

    public Study(long id, String category, String title, String description, String bvnumber) {
        this.id = id;
        this.category = category;
        this.title = title;
        this.description = description;
        this.bvnumber = bvnumber;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBvnumber() {
        return bvnumber;
    }

    public void setBvnumber(String bvnumber) {
        this.bvnumber = bvnumber;
    }
}
