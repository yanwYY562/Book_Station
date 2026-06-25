package com.example.entity;

import java.math.BigDecimal;
import java.util.Date;

public class Chapter {
    private Integer id;
    private Integer bookId;
    private Integer chapterNumber;
    private String title;
    private String content;
    private Integer wordCount;
    private Integer isFree;
    private BigDecimal price;
    private Integer status;
    private Date createTime;
    private Date updateTime;

    private String bookTitle;

    public Chapter() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getBookId() { return bookId; }
    public void setBookId(Integer bookId) { this.bookId = bookId; }
    public Integer getChapterNumber() { return chapterNumber; }
    public void setChapterNumber(Integer chapterNumber) { this.chapterNumber = chapterNumber; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Integer getWordCount() { return wordCount; }
    public void setWordCount(Integer wordCount) { this.wordCount = wordCount; }
    public Integer getIsFree() { return isFree; }
    public void setIsFree(Integer isFree) { this.isFree = isFree; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
}