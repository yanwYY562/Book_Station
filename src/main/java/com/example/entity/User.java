package com.example.entity;

import java.math.BigDecimal;
import java.util.Date;

public class User {
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String nickname;
    private String avatar;
    private String role;
    private Integer status;
    private Integer vipLevel;
    private BigDecimal balance;
    private Date createTime;
    private Date lastLoginTime;

    public User() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getVipLevel() { return vipLevel; }
    public void setVipLevel(Integer vipLevel) { this.vipLevel = vipLevel; }
    public BigDecimal getBalance() { return balance; }
    public void setBalance(BigDecimal balance) { this.balance = balance; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getLastLoginTime() { return lastLoginTime; }
    public void setLastLoginTime(Date lastLoginTime) { this.lastLoginTime = lastLoginTime; }
}