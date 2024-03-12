package com.yx.utils;

import java.io.Serializable;

/**
 * Classe englobant les données, renvoyée au front-end
 */
public class DataInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer code;
    private String msg;
    private Object data; //json data
    private Long count; // Informations de pagination: nombre total d'éléments

    public DataInfo() {
    }

    public DataInfo(Integer code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public DataInfo(Integer code, String msg, Object data, Long count) {
        this.code = code;
        this.msg = msg;
        this.data = data;
        this.count = count;
    }

    public Integer getCode() {
        return code;
    }

    public static DataInfo ok() {
        return new DataInfo(Constants.OK_CODE, Constants.OK_MSG, null);
    }

    public static DataInfo ok(Object data) {
        return new DataInfo(Constants.OK_CODE, Constants.OK_MSG, data);
    }

    public static DataInfo ok(String msg, long count, Object data) {
        return new DataInfo(Constants.OK_CODE, Constants.OK_MSG, data,count);
    }

    public static DataInfo ok(String msg, Object data) {
        return new DataInfo(Constants.OK_CODE, msg, data);
    }

    public static DataInfo fail(String msg) {
        return new DataInfo(Constants.FAIL_CODE, msg, null);
    }

    public static DataInfo fail(int errorCode, String msg) {
        return new DataInfo(errorCode, msg, null);
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }
}

