package com.example.dao.impl;

import com.example.dao.UserBookSubmissionDao;
import com.example.entity.UserBookSubmission;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class UserBookSubmissionDaoImpl implements UserBookSubmissionDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public UserBookSubmission findById(Integer id) {
        String sql = "SELECT s.*, u.username, u.nickname, c.name as categoryName " +
                     "FROM user_book_submissions s " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "LEFT JOIN categories c ON s.category_id = c.id " +
                     "WHERE s.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(UserBookSubmission.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<UserBookSubmission> findAll() {
        String sql = "SELECT s.*, u.username, u.nickname, c.name as categoryName " +
                     "FROM user_book_submissions s " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "LEFT JOIN categories c ON s.category_id = c.id " +
                     "ORDER BY s.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(UserBookSubmission.class));
    }

    @Override
    public List<UserBookSubmission> findByStatus(Integer status) {
        String sql = "SELECT s.*, u.username, u.nickname, c.name as categoryName " +
                     "FROM user_book_submissions s " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "LEFT JOIN categories c ON s.category_id = c.id " +
                     "WHERE s.status = ? ORDER BY s.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(UserBookSubmission.class), status);
    }

    @Override
    public List<UserBookSubmission> findByUserId(Integer userId) {
        String sql = "SELECT s.*, u.username, u.nickname, c.name as categoryName " +
                     "FROM user_book_submissions s " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "LEFT JOIN categories c ON s.category_id = c.id " +
                     "WHERE s.user_id = ? ORDER BY s.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(UserBookSubmission.class), userId);
    }

    @Override
    public void save(UserBookSubmission submission) {
        String sql = "INSERT INTO user_book_submissions(user_id, title, author, category_id, cover_image, " +
                     "description, price, word_count, is_free, status, create_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0, NOW())";
        jdbcTemplate.update(sql, submission.getUserId(), submission.getTitle(), submission.getAuthor(),
                submission.getCategoryId(), submission.getCoverImage(), submission.getDescription(),
                submission.getPrice(), submission.getWordCount(), submission.getIsFree());
    }

    @Override
    public void update(UserBookSubmission submission) {
        String sql = "UPDATE user_book_submissions SET title=?, author=?, category_id=?, cover_image=?, " +
                     "description=?, price=?, word_count=?, is_free=?, status=?, reject_reason=?, update_time=NOW() " +
                     "WHERE id=?";
        jdbcTemplate.update(sql, submission.getTitle(), submission.getAuthor(), submission.getCategoryId(),
                submission.getCoverImage(), submission.getDescription(), submission.getPrice(),
                submission.getWordCount(), submission.getIsFree(), submission.getStatus(),
                submission.getRejectReason(), submission.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM user_book_submissions WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
