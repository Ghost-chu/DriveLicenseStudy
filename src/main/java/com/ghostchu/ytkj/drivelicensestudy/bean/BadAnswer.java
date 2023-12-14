package com.ghostchu.ytkj.drivelicensestudy.bean;

public class BadAnswer {
    private long id;
    private long userId;
    private long questionId;
    private String myAnswer;

    public BadAnswer() {
    }

    public BadAnswer(long id, long userId, long questionId, String myAnswer) {
        this.id = id;
        this.userId = userId;
        this.questionId = questionId;
        this.myAnswer = myAnswer;
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

    public long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(long questionId) {
        this.questionId = questionId;
    }

    public String getMyAnswer() {
        return myAnswer;
    }

    public void setMyAnswer(String myAnswer) {
        this.myAnswer = myAnswer;
    }

    public String[] generateAnswers(){
        return myAnswer.split(";");
    }
}
