package com.example.entity;

import java.math.BigDecimal;
import java.util.Date;

public class Book {
    private Integer id;
    private String title;
    private String author;
    private Integer authorId;
    private Integer categoryId;
    private String coverImage;
    private String description;
    private BigDecimal price;
    private Integer wordCount;
    private Integer chapterCount;
    private Integer status;
    private Integer isFree;
    private Integer viewCount;
    private Integer favoriteCount;
    private BigDecimal rating;
    private String publisher;
    private Date publishDate;
    private Date createTime;
    private Date updateTime;

    private String categoryName;

    public Book() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public Integer getAuthorId() { return authorId; }
    public void setAuthorId(Integer authorId) { this.authorId = authorId; }
    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }
    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Integer getWordCount() { return wordCount; }
    public void setWordCount(Integer wordCount) { this.wordCount = wordCount; }
    public Integer getChapterCount() { return chapterCount; }
    public void setChapterCount(Integer chapterCount) { this.chapterCount = chapterCount; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getIsFree() { return isFree; }
    public void setIsFree(Integer isFree) { this.isFree = isFree; }
    public Integer getViewCount() { return viewCount; }
    public void setViewCount(Integer viewCount) { this.viewCount = viewCount; }
    public Integer getFavoriteCount() { return favoriteCount; }
    public void setFavoriteCount(Integer favoriteCount) { this.favoriteCount = favoriteCount; }
    public BigDecimal getRating() { return rating; }
    public void setRating(BigDecimal rating) { this.rating = rating; }
    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }
    public Date getPublishDate() { return publishDate; }
    public void setPublishDate(Date publishDate) { this.publishDate = publishDate; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
}