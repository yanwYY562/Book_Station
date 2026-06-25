package com.example.service.impl;

import com.example.dao.BookDao;
import com.example.entity.Book;
import com.example.service.BookService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Resource
    private BookDao bookDao;

    @Override
    public Book findById(Integer id) {
        return bookDao.findById(id);
    }

    @Override
    public List<Book> findAll() {
        return bookDao.findAll();
    }

    @Override
    public List<Book> findByCategoryId(Integer categoryId) {
        return bookDao.findByCategoryId(categoryId);
    }

    @Override
    public List<Book> findByStatus(Integer status) {
        return bookDao.findByStatus(status);
    }

    @Override
    public List<Book> findByIsFree(Integer isFree) {
        return bookDao.findByIsFree(isFree);
    }

    @Override
    public List<Book> search(String keyword) {
        return bookDao.search(keyword);
    }

    @Override
    public List<Book> findFiltered(Integer categoryId, Integer status, Integer free) {
        return bookDao.findFiltered(categoryId, status, free);
    }

    @Override
    public List<Book> findTopViewed(int limit) {
        return bookDao.findTopViewed(limit);
    }

    @Override
    public List<Book> findTopFavorited(int limit) {
        return bookDao.findTopFavorited(limit);
    }

    @Override
    public List<Book> findByAuthorId(Integer authorId) {
        return bookDao.findByAuthorId(authorId);
    }

    @Override
    public void save(Book book) {
        bookDao.save(book);
    }

    @Override
    public void update(Book book) {
        bookDao.update(book);
    }

    @Override
    public void delete(Integer id) {
        bookDao.delete(id);
    }

    @Override
    public void incrementViewCount(Integer id) {
        bookDao.incrementViewCount(id);
    }

    @Override
    public void incrementFavoriteCount(Integer id) {
        bookDao.incrementFavoriteCount(id);
    }

    @Override
    public void decrementFavoriteCount(Integer id) {
        bookDao.decrementFavoriteCount(id);
    }

    @Override
    public void decrementChapterCount(Integer id) {
        bookDao.decrementChapterCount(id);
    }

    @Override
    public int count() {
        return bookDao.count();
    }
}