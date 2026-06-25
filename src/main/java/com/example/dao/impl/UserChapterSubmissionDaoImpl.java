package com.example.dao.impl;

import com.example.dao.UserChapterSubmissionDao;
import com.example.entity.UserChapterSubmission;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class UserChapterSubmissionDaoImpl implements UserChapterSubmissionDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public UserChapterSubmission findById(Integer id) {
        String sql = "SELECT s.*, b.title as bookTitle, u.nickname as authorName " +
                     "FROM user_chapter_submissions s " +
                     "LEFT JOIN books b ON s.book_id = b.id " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "WHERE s.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(UserChapterSubmission.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<UserChapterSubmission> findAll() {
        String sql = "SELECT s.*, b.title as bookTitle, u.nickname as authorName " +
                     "FROM user_chapter_submissions s " +
                     "LEFT JOIN books b ON s.book_id = b.id " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "ORDER BY s.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(UserChapterSubmission.class));
    }

    @Override
    public List<UserChapterSubmission> findByStatus(Integer status) {
        String sql = "SELECT s.*, b.title as bookTitle, u.nickname as authorName " +
                     "FROM user_chapter_submissions s " +
                     "LEFT JOIN books b ON s.book_id = b.id " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "WHERE s.status = ? ORDER BY s.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(UserChapterSubmission.class), status);
    }

    @Override
    public List<UserChapterSubmission> findByUserId(Integer userId) {
        String sql = "SELECT s.*, b.title as bookTitle, u.nickname as authorName " +
                     "FROM user_chapter_submissions s " +
                     "LEFT JOIN books b ON s.book_id = b.id " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "WHERE s.user_id = ? ORDER BY s.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(UserChapterSubmission.class), userId);
    }

    @Override
    public List<UserChapterSubmission> findByBookId(Integer bookId) {
        String sql = "SELECT s.*, b.title as bookTitle, u.nickname as authorName " +
                     "FROM user_chapter_submissions s " +
                     "LEFT JOIN books b ON s.book_id = b.id " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "WHERE s.book_id = ? ORDER BY s.chapter_number ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(UserChapterSubmission.class), bookId);
    }

    @Override
    public void save(UserChapterSubmission submission) {
        String sql = "INSERT INTO user_chapter_submissions(user_id, book_id, chapter_number, title, content, is_free, status, create_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 0, NOW())";
        jdbcTemplate.update(sql, submission.getUserId(), submission.getBookId(), submission.getChapterNumber(),
                submission.getTitle(), submission.getContent(), submission.getIsFree());
    }

    @Override
    public void update(UserChapterSubmission submission) {
        String sql = "UPDATE user_chapter_submissions SET chapter_number=?, title=?, content=?, is_free=?, status=?, reject_reason=?, update_time=NOW() WHERE id=?";
        jdbcTemplate.update(sql, submission.getChapterNumber(), submission.getTitle(), submission.getContent(),
                submission.getIsFree(), submission.getStatus(), submission.getRejectReason(), submission.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM user_chapter_submissions WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
