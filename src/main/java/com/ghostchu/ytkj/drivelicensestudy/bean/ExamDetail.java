package com.ghostchu.ytkj.drivelicensestudy.bean;
public class ExamDetail {
    private long id;
    private long userId;
    private long examId;
    private long questionId;
    private String myAnswer;

    public String[] generateMyAnswer(){
        return myAnswer.split(";");
    }

    public ExamDetail() {
    }

    public ExamDetail(long id, long userId, long examId, long questionId, String myAnswer) {
        this.id = id;
        this.userId = userId;
        this.examId = examId;
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

    public long getExamId() {
        return examId;
    }

    public void setExamId(long examId) {
        this.examId = examId;
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
}
