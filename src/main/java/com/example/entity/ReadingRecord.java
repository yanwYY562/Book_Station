package com.example.entity;

import java.util.Date;

public class ReadingRecord {
    private Integer id;
    private Integer userId;
    private Integer bookId;
    private Integer chapterId;
    private Date lastReadTime;
    private Integer readProgress;

    private String bookTitle;
    private String bookCover;
    private String bookCoverImage;
    private String bookAuthor;
    private String chapterTitle;

    public ReadingRecord() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getBookId() { return bookId; }
    public void setBookId(Integer bookId) { this.bookId = bookId; }
    public Integer getChapterId() { return chapterId; }
    public void setChapterId(Integer chapterId) { this.chapterId = chapterId; }
    public Date getLastReadTime() { return lastReadTime; }
    public void setLastReadTime(Date lastReadTime) { this.lastReadTime = lastReadTime; }
    public Integer getReadProgress() { return readProgress; }
    public void setReadProgress(Integer readProgress) { this.readProgress = readProgress; }
    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
    public String getBookCover() { return bookCover; }
    public void setBookCover(String bookCover) { this.bookCover = bookCover; }
    public String getBookCoverImage() { return bookCoverImage; }
    public void setBookCoverImage(String bookCoverImage) { this.bookCoverImage = bookCoverImage; }
    public String getBookAuthor() { return bookAuthor; }
    public void setBookAuthor(String bookAuthor) { this.bookAuthor = bookAuthor; }
    public String getChapterTitle() { return chapterTitle; }
    public void setChapterTitle(String chapterTitle) { this.chapterTitle = chapterTitle; }
}