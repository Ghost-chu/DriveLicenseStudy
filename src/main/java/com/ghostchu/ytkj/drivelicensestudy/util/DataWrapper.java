package com.ghostchu.ytkj.drivelicensestudy.util;

public class DataWrapper {
    private final String message;
    private final String jumpUrl;
    private final Object data;

    public DataWrapper(String message, String jumpUrl, Object data) {
        this.message = message;
        this.jumpUrl = jumpUrl;
        this.data = data;
    }

    public String getMessage() {
        return message;
    }

    public Object getData() {
        return data;
    }

    public String getJumpUrl() {
        return jumpUrl;
    }
}
