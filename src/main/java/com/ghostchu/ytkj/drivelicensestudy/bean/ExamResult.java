package com.ghostchu.ytkj.drivelicensestudy.bean;

public class ExamResult {
    private long id;
    private long userId;
    private String category;
    private int totalNumber;
    private int correctNumber;
    private double score;

    public ExamResult() {
    }

    public ExamResult(long id, long userId, String category, int totalNumber, int correctNumber, double score) {
        this.id = id;
        this.userId = userId;
        this.category = category;
        this.totalNumber = totalNumber;
        this.correctNumber = correctNumber;
        this.score = score;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(int totalNumber) {
        this.totalNumber = totalNumber;
    }

    public int getCorrectNumber() {
        return correctNumber;
    }

    public void setCorrectNumber(int correctNumber) {
        this.correctNumber = correctNumber;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }
}
