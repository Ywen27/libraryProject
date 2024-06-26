package com.yx.po;

import java.io.Serializable;
import java.util.Date;

public class LendList implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lend_list.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lend_list.bookId
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Integer bookId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lend_list.readerId
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Integer readerId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lend_list.lendDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Date lendDate;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lend_list.backDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Date backDate;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lend_list.backType
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Integer backType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lend_list.exceptRemarks
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private String exceptRemarks;

    private BookInfo bookInfo;

    private ReaderInfo readerInfo;
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table lend_list
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private static final long serialVersionUID = 1L;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lend_list.id
     *
     * @return the value of lend_list.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lend_list.id
     *
     * @param id the value for lend_list.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lend_list.bookId
     *
     * @return the value of lend_list.bookId
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Integer getBookId() {
        return bookId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lend_list.bookId
     *
     * @param bookId the value for lend_list.bookId
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lend_list.readerId
     *
     * @return the value of lend_list.readerId
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Integer getReaderId() {
        return readerId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lend_list.readerId
     *
     * @param readerId the value for lend_list.readerId
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setReaderId(Integer readerId) {
        this.readerId = readerId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lend_list.lendDate
     *
     * @return the value of lend_list.lendDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Date getLendDate() {
        return lendDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lend_list.lendDate
     *
     * @param lenddate the value for lend_list.lendDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setLendDate(Date lenddate) {
        this.lendDate = lenddate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lend_list.backDate
     *
     * @return the value of lend_list.backDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Date getBackDate() {
        return backDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lend_list.backDate
     *
     * @param backDate the value for lend_list.backDate
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setBackDate(Date backDate) {
        this.backDate = backDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lend_list.backType
     *
     * @return the value of lend_list.backType
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Integer getBackType() {
        return backType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lend_list.backType
     *
     * @param backType the value for lend_list.backType
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setBackType(Integer backType) {
        this.backType = backType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lend_list.exceptRemarks
     *
     * @return the value of lend_list.exceptRemarks
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public String getExceptRemarks() {
        return exceptRemarks;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lend_list.exceptRemarks
     *
     * @param exceptRemarks the value for lend_list.exceptRemarks
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setExceptRemarks(String exceptRemarks) {
        this.exceptRemarks = exceptRemarks == null ? null : exceptRemarks.trim();
    }

    public BookInfo getBookInfo() {
        return bookInfo;
    }

    public void setBookInfo(BookInfo bookInfo) {
        this.bookInfo = bookInfo;
    }

    public ReaderInfo getReaderInfo() {
        return readerInfo;
    }

    public void setReaderInfo(ReaderInfo readerInfo) {
        this.readerInfo = readerInfo;
    }
}