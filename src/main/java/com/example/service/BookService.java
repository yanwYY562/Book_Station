package com.example.service;

import com.example.entity.Book;

import java.util.List;

public interface BookService {
    Book findById(Integer id);
    List<Book> findAll();
    List<Book> findByCategoryId(Integer categoryId);
    List<Book> findByStatus(Integer status);
    List<Book> findByIsFree(Integer isFree);
    List<Book> search(String keyword);
    List<Book> findFiltered(Integer categoryId, Integer status, Integer free);
    List<Book> findTopViewed(int limit);
    List<Book> findTopFavorited(int limit);
    List<Book> findByAuthorId(Integer authorId);
    void save(Book book);
    void update(Book book);
    void delete(Integer id);
    void incrementViewCount(Integer id);
    void incrementFavoriteCount(Integer id);
    void decrementFavoriteCount(Integer id);
    void decrementChapterCount(Integer id);
    int count();
}