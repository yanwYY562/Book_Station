package com.example.entity;

import java.util.Date;

public class Favorite {
    private Integer id;
    private Integer userId;
    private Integer bookId;
    private Date createTime;

    private String bookTitle;
    private String bookCover;
    private String bookCoverImage;
    private String bookAuthor;
    private Integer bookIsFree;
    private java.math.BigDecimal bookPrice;

    public Favorite() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getBookId() { return bookId; }
    public void setBookId(Integer bookId) { this.bookId = bookId; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
    public String getBookCover() { return bookCover; }
    public void setBookCover(String bookCover) { this.bookCover = bookCover; }
    public String getBookCoverImage() { return bookCoverImage; }
    public void setBookCoverImage(String bookCoverImage) { this.bookCoverImage = bookCoverImage; }
    public String getBookAuthor() { return bookAuthor; }
    public void setBookAuthor(String bookAuthor) { this.bookAuthor = bookAuthor; }
    public Integer getBookIsFree() { return bookIsFree; }
    public void setBookIsFree(Integer bookIsFree) { this.bookIsFree = bookIsFree; }
    public java.math.BigDecimal getBookPrice() { return bookPrice; }
    public void setBookPrice(java.math.BigDecimal bookPrice) { this.bookPrice = bookPrice; }
}