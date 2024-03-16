package com.yx.po;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Notice implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column notice.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column notice.topic
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private String topic;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column notice.content
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private String content;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column notice.author
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private String author;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column notice.createDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")//接收页面传来的时间格式
    @JSONField(format="yyyy-MM-dd HH:mm:ss")//对返回的时间对象用fastjson格式化时间
    private Date createdate;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table notice
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private static final long serialVersionUID = 1L;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column notice.id
     *
     * @return the value of notice.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column notice.id
     *
     * @param id the value for notice.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column notice.topic
     *
     * @return the value of notice.topic
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public String getTopic() {
        return topic;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column notice.topic
     *
     * @param topic the value for notice.topic
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setTopic(String topic) {
        this.topic = topic == null ? null : topic.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column notice.content
     *
     * @return the value of notice.content
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column notice.content
     *
     * @param content the value for notice.content
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column notice.author
     *
     * @return the value of notice.author
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public String getAuthor() {
        return author;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column notice.author
     *
     * @param author the value for notice.author
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column notice.createDate
     *
     * @return the value of notice.createDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Date getCreatedate() {
        return createdate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column notice.createDate
     *
     * @param createdate the value for notice.createDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }
}