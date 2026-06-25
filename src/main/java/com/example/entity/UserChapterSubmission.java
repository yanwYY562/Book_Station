package com.example.entity;

import java.math.BigDecimal;
import java.util.Date;

public class UserChapterSubmission {
    private Integer id;
    private Integer userId;
    private Integer bookId;
    private Integer chapterNumber;
    private String title;
    private String content;
    private Integer isFree;
    private BigDecimal price;
    private Integer status;
    private String rejectReason;
    private Date createTime;
    private Date updateTime;

    private String bookTitle;
    private String authorName;

    public UserChapterSubmission() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getBookId() { return bookId; }
    public void setBookId(Integer bookId) { this.bookId = bookId; }
    public Integer getChapterNumber() { return chapterNumber; }
    public void setChapterNumber(Integer chapterNumber) { this.chapterNumber = chapterNumber; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Integer getIsFree() { return isFree; }
    public void setIsFree(Integer isFree) { this.isFree = isFree; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getRejectReason() { return rejectReason; }
    public void setRejectReason(String rejectReason) { this.rejectReason = rejectReason; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }
}
