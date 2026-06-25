package com.example.dao.impl;

import com.example.dao.ChapterDao;
import com.example.entity.Chapter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class ChapterDaoImpl implements ChapterDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public Chapter findById(Integer id) {
        String sql = "SELECT c.*, b.title as bookTitle FROM chapters c LEFT JOIN books b ON c.book_id = b.id WHERE c.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Chapter.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Chapter> findByBookId(Integer bookId) {
        String sql = "SELECT * FROM chapters WHERE book_id = ? AND status = 1 ORDER BY chapter_number ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Chapter.class), bookId);
    }

    @Override
    public List<Chapter> findByBookIdAllStatus(Integer bookId) {
        String sql = "SELECT * FROM chapters WHERE book_id = ? ORDER BY chapter_number ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Chapter.class), bookId);
    }

    @Override
    public Chapter findFirstByBookId(Integer bookId) {
        String sql = "SELECT * FROM chapters WHERE book_id = ? AND status = 1 ORDER BY chapter_number ASC LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Chapter.class), bookId);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Chapter findFirstByBookIdAllStatus(Integer bookId) {
        String sql = "SELECT * FROM chapters WHERE book_id = ? ORDER BY chapter_number ASC LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Chapter.class), bookId);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Chapter findNextChapter(Integer bookId, Integer chapterNumber) {
        String sql = "SELECT * FROM chapters WHERE book_id = ? AND chapter_number > ? AND status = 1 ORDER BY chapter_number ASC LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Chapter.class), bookId, chapterNumber);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Chapter findPreviousChapter(Integer bookId, Integer chapterNumber) {
        String sql = "SELECT * FROM chapters WHERE book_id = ? AND chapter_number < ? AND status = 1 ORDER BY chapter_number DESC LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Chapter.class), bookId, chapterNumber);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void save(Chapter chapter) {
        String sql = "INSERT INTO chapters(book_id, chapter_number, title, content, word_count, is_free, price, status, create_time, update_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        jdbcTemplate.update(sql,
                chapter.getBookId(),
                chapter.getChapterNumber(),
                chapter.getTitle(),
                chapter.getContent(),
                chapter.getWordCount(),
                chapter.getIsFree(),
                chapter.getPrice(),
                chapter.getStatus());
    }

    @Override
    public void update(Chapter chapter) {
        String sql = "UPDATE chapters SET book_id=?, chapter_number=?, title=?, content=?, word_count=?, is_free=?, price=?, status=?, update_time=NOW() WHERE id=?";
        jdbcTemplate.update(sql,
                chapter.getBookId(),
                chapter.getChapterNumber(),
                chapter.getTitle(),
                chapter.getContent(),
                chapter.getWordCount(),
                chapter.getIsFree(),
                chapter.getPrice(),
                chapter.getStatus(),
                chapter.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM chapters WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public int countByBookId(Integer bookId) {
        String sql = "SELECT COUNT(*) FROM chapters WHERE book_id = ? AND status = 1";
        return jdbcTemplate.queryForObject(sql, Integer.class, bookId);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM chapters WHERE status = 1";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    @Override
    public List<Chapter> findAll() {
        String sql = "SELECT c.*, b.title as bookTitle FROM chapters c LEFT JOIN books b ON c.book_id = b.id WHERE c.status = 1 ORDER BY c.book_id ASC, c.chapter_number ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Chapter.class));
    }

    @Override
    public boolean existsByBookIdAndChapterNumber(Integer bookId, Integer chapterNumber) {
        String sql = "SELECT COUNT(*) FROM chapters WHERE book_id = ? AND chapter_number = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, bookId, chapterNumber);
        return count != null && count > 0;
    }

    @Override
    public Integer findMaxChapterNumber(Integer bookId) {
        String sql = "SELECT MAX(chapter_number) FROM chapters WHERE book_id = ?";
        Integer max = jdbcTemplate.queryForObject(sql, Integer.class, bookId);
        return max != null ? max : 0;
    }
}