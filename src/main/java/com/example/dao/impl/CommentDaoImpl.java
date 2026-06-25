package com.example.dao.impl;

import com.example.dao.CommentDao;
import com.example.entity.Comment;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class CommentDaoImpl implements CommentDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public Comment findById(Integer id) {
        String sql = "SELECT * FROM comments WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Comment.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Comment> findByBookId(Integer bookId) {
        String sql = "SELECT c.*, u.username, u.nickname as userNickname, b.title as bookTitle " +
                     "FROM comments c LEFT JOIN users u ON c.user_id = u.id LEFT JOIN books b ON c.book_id = b.id " +
                     "WHERE c.book_id = ? AND c.status = 1 ORDER BY c.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Comment.class), bookId);
    }

    @Override
    public List<Comment> findByUserId(Integer userId) {
        String sql = "SELECT c.*, u.username, u.nickname as userNickname, b.title as bookTitle, b.cover_image as bookCoverImage " +
                     "FROM comments c LEFT JOIN users u ON c.user_id = u.id LEFT JOIN books b ON c.book_id = b.id " +
                     "WHERE c.user_id = ? ORDER BY c.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Comment.class), userId);
    }

    @Override
    public List<Comment> findByStatus(Integer status) {
        String sql = "SELECT c.*, u.username, u.nickname as userNickname, b.title as bookTitle " +
                     "FROM comments c LEFT JOIN users u ON c.user_id = u.id LEFT JOIN books b ON c.book_id = b.id " +
                     "WHERE c.status = ? ORDER BY c.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Comment.class), status);
    }

    @Override
    public void save(Comment comment) {
        String sql = "INSERT INTO comments(user_id, book_id, content, rating, status, create_time) VALUES (?, ?, ?, ?, ?, NOW())";
        jdbcTemplate.update(sql, comment.getUserId(), comment.getBookId(), comment.getContent(), comment.getRating(), comment.getStatus());
    }

    @Override
    public void update(Comment comment) {
        String sql = "UPDATE comments SET content=?, rating=?, status=? WHERE id=?";
        jdbcTemplate.update(sql, comment.getContent(), comment.getRating(), comment.getStatus(), comment.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM comments WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public int countByBookId(Integer bookId) {
        String sql = "SELECT COUNT(*) FROM comments WHERE book_id = ? AND status = 1";
        return jdbcTemplate.queryForObject(sql, Integer.class, bookId);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM comments WHERE status = 1";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    @Override
    public List<Comment> findAll() {
        String sql = "SELECT c.*, u.username, u.nickname as userNickname, b.title as bookTitle " +
                     "FROM comments c LEFT JOIN users u ON c.user_id = u.id LEFT JOIN books b ON c.book_id = b.id " +
                     "ORDER BY c.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Comment.class));
    }
}