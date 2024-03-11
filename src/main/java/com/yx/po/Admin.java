package com.yx.po;

import java.io.Serializable;

public class Admin implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column admin.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column admin.username
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private String username;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column admin.password
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private String password;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column admin.adminType
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private Integer admintype;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table admin
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    private static final long serialVersionUID = 1L;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column admin.id
     *
     * @return the value of admin.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column admin.id
     *
     * @param id the value for admin.id
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column admin.username
     *
     * @return the value of admin.username
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public String getUsername() {
        return username;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column admin.username
     *
     * @param username the value for admin.username
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column admin.password
     *
     * @return the value of admin.password
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public String getPassword() {
        return password;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column admin.password
     *
     * @param password the value for admin.password
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column admin.adminType
     *
     * @return the value of admin.adminType
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public Integer getAdmintype() {
        return admintype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column admin.adminType
     *
     * @param admintype the value for admin.adminType
     *
     * @mbggenerated Sun Mar 10 22:17:10 EDT 2024
     */
    public void setAdmintype(Integer admintype) {
        this.admintype = admintype;
    }
}