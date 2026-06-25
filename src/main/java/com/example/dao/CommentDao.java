package com.example.dao;

import com.example.entity.Comment;

import java.util.List;

public interface CommentDao {
    Comment findById(Integer id);
    List<Comment> findByBookId(Integer bookId);
    List<Comment> findByUserId(Integer userId);
    List<Comment> findByStatus(Integer status);
    void save(Comment comment);
    void update(Comment comment);
    void delete(Integer id);
    int countByBookId(Integer bookId);
    int count();
    List<Comment> findAll();
}