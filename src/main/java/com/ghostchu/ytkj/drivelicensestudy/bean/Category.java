package com.ghostchu.ytkj.drivelicensestudy.bean;

public class Category {
    private long id;
    private String categoryName;
    private int examQuestions;
    private double scorePerQuestion;

    public Category(long id, String categoryName, int examQuestions, double scorePerQuestion) {
        this.id = id;
        this.examQuestions = examQuestions;
        this.categoryName = categoryName;
        this.scorePerQuestion = scorePerQuestion;
    }

    public Category() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public int getExamQuestions() {
        return examQuestions;
    }

    public void setExamQuestions(int examQuestions) {
        this.examQuestions = examQuestions;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public double getScorePerQuestion() {
        return scorePerQuestion;
    }

    public void setScorePerQuestion(double scorePerQuestion) {
        this.scorePerQuestion = scorePerQuestion;
    }
}
