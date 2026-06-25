package com.example.entity;

import java.util.Date;

public class Comment {
    private Integer id;
    private Integer userId;
    private Integer bookId;
    private String content;
    private Integer rating;
    private Integer status;
    private Date createTime;

    private String username;
    private String nickname;
    private String userNickname;
    private String bookTitle;
    private String bookCoverImage;

    public Comment() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getBookId() { return bookId; }
    public void setBookId(Integer bookId) { this.bookId = bookId; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getUserNickname() { return userNickname; }
    public void setUserNickname(String userNickname) { this.userNickname = userNickname; }
    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
    public String getBookCoverImage() { return bookCoverImage; }
    public void setBookCoverImage(String bookCoverImage) { this.bookCoverImage = bookCoverImage; }
}