package com.example.dao;

import com.example.entity.Chapter;

import java.util.List;

public interface ChapterDao {
    Chapter findById(Integer id);
    List<Chapter> findByBookId(Integer bookId);
    List<Chapter> findByBookIdAllStatus(Integer bookId);
    Chapter findFirstByBookId(Integer bookId);
    Chapter findFirstByBookIdAllStatus(Integer bookId);
    Chapter findNextChapter(Integer bookId, Integer chapterNumber);
    Chapter findPreviousChapter(Integer bookId, Integer chapterNumber);
    void save(Chapter chapter);
    void update(Chapter chapter);
    void delete(Integer id);
    int countByBookId(Integer bookId);
    int count();
    List<Chapter> findAll();
    boolean existsByBookIdAndChapterNumber(Integer bookId, Integer chapterNumber);
    Integer findMaxChapterNumber(Integer bookId);
}