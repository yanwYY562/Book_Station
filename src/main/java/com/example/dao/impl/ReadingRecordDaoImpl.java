package com.example.dao.impl;

import com.example.dao.ReadingRecordDao;
import com.example.entity.ReadingRecord;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class ReadingRecordDaoImpl implements ReadingRecordDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public ReadingRecord findById(Integer id) {
        String sql = "SELECT * FROM reading_records WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(ReadingRecord.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public ReadingRecord findByUserIdAndBookId(Integer userId, Integer bookId) {
        String sql = "SELECT r.*, b.title as bookTitle, b.cover_image as bookCover, c.title as chapterTitle " +
                     "FROM reading_records r LEFT JOIN books b ON r.book_id = b.id LEFT JOIN chapters c ON r.chapter_id = c.id " +
                     "WHERE r.user_id = ? AND r.book_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(ReadingRecord.class), userId, bookId);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<ReadingRecord> findByUserId(Integer userId) {
        String sql = "SELECT r.*, b.title as bookTitle, b.cover_image as bookCover, b.cover_image as bookCoverImage, b.author as bookAuthor, c.title as chapterTitle " +
                     "FROM reading_records r LEFT JOIN books b ON r.book_id = b.id LEFT JOIN chapters c ON r.chapter_id = c.id " +
                     "WHERE r.user_id = ? ORDER BY r.last_read_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(ReadingRecord.class), userId);
    }

    @Override
    public void save(ReadingRecord record) {
        String sql = "INSERT INTO reading_records(user_id, book_id, chapter_id, last_read_time, read_progress) VALUES (?, ?, ?, NOW(), ?)";
        jdbcTemplate.update(sql, record.getUserId(), record.getBookId(), record.getChapterId(), record.getReadProgress());
    }

    @Override
    public void update(ReadingRecord record) {
        String sql = "UPDATE reading_records SET chapter_id=?, last_read_time=NOW(), read_progress=? WHERE user_id=? AND book_id=?";
        jdbcTemplate.update(sql, record.getChapterId(), record.getReadProgress(), record.getUserId(), record.getBookId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM reading_records WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}