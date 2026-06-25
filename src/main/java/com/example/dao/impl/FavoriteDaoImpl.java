package com.example.dao.impl;

import com.example.dao.FavoriteDao;
import com.example.entity.Favorite;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class FavoriteDaoImpl implements FavoriteDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public Favorite findById(Integer id) {
        String sql = "SELECT * FROM favorites WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Favorite.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Favorite findByUserIdAndBookId(Integer userId, Integer bookId) {
        String sql = "SELECT f.*, b.title as bookTitle, b.cover_image as bookCover, b.author as bookAuthor " +
                     "FROM favorites f LEFT JOIN books b ON f.book_id = b.id WHERE f.user_id = ? AND f.book_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Favorite.class), userId, bookId);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Favorite> findByUserId(Integer userId) {
        String sql = "SELECT f.*, b.title as bookTitle, b.cover_image as bookCover, b.cover_image as bookCoverImage, b.author as bookAuthor, b.is_free as bookIsFree, b.price as bookPrice " +
                     "FROM favorites f LEFT JOIN books b ON f.book_id = b.id WHERE f.user_id = ? ORDER BY f.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Favorite.class), userId);
    }

    @Override
    public void save(Favorite favorite) {
        String sql = "INSERT INTO favorites(user_id, book_id, create_time) VALUES (?, ?, NOW())";
        jdbcTemplate.update(sql, favorite.getUserId(), favorite.getBookId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM favorites WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public void deleteByUserIdAndBookId(Integer userId, Integer bookId) {
        String sql = "DELETE FROM favorites WHERE user_id = ? AND book_id = ?";
        jdbcTemplate.update(sql, userId, bookId);
    }

    @Override
    public boolean exists(Integer userId, Integer bookId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ? AND book_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, bookId);
        return count != null && count > 0;
    }
}