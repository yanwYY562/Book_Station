package com.example.service.impl;

import com.example.dao.CommentDao;
import com.example.entity.Comment;
import com.example.service.CommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentDao commentDao;

    @Override
    public Comment findById(Integer id) {
        return commentDao.findById(id);
    }

    @Override
    public List<Comment> findByBookId(Integer bookId) {
        return commentDao.findByBookId(bookId);
    }

    @Override
    public List<Comment> findByUserId(Integer userId) {
        return commentDao.findByUserId(userId);
    }

    @Override
    public List<Comment> findByStatus(Integer status) {
        return commentDao.findByStatus(status);
    }

    @Override
    public void save(Comment comment) {
        commentDao.save(comment);
    }

    @Override
    public void update(Comment comment) {
        commentDao.update(comment);
    }

    @Override
    public void delete(Integer id) {
        commentDao.delete(id);
    }

    @Override
    public int countByBookId(Integer bookId) {
        return commentDao.countByBookId(bookId);
    }

    @Override
    public int count() {
        return commentDao.count();
    }

    @Override
    public List<Comment> findAll() {
        return commentDao.findAll();
    }
}