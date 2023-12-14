package com.ghostchu.ytkj.drivelicensestudy.bean;

public class Question {
    private long id;
    private String category;
    private String title;
    private byte[] attachment;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String correct;

    public Question() {
    }

    public Question(long id, String category, String title, byte[] attachment, String optionA, String optionB, String optionC, String optionD, String correct) {
        this.id = id;
        this.category = category;
        this.title = title;
        this.attachment = attachment;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correct = correct;
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

    public void setTitle(String title) {
        this.title = title;
    }

    public byte[] getAttachment() {
        return attachment;
    }

    public void setAttachment(byte[] attachment) {
        this.attachment = attachment;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getCorrect() {
        return correct;
    }

    public String[] generateCorrectOptions(){
        return correct.split(";");
    }

    public void setCorrect(String correct) {
        this.correct = correct;
    }
}
