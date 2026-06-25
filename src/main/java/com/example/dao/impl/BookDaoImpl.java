package com.example.dao.impl;

import com.example.dao.BookDao;
import com.example.entity.Book;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Repository
public class BookDaoImpl implements BookDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public Book findById(Integer id) {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id WHERE b.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Book.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Book> findAll() {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id WHERE b.status IN (1, 2) ORDER BY b.id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Book.class));
    }

    @Override
    public List<Book> findByCategoryId(Integer categoryId) {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id WHERE b.category_id = ? AND b.status IN (1, 2) ORDER BY b.id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Book.class), categoryId);
    }

    @Override
    public List<Book> findByStatus(Integer status) {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id WHERE b.status = ? ORDER BY b.id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Book.class), status);
    }

    @Override
    public List<Book> findByIsFree(Integer isFree) {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id WHERE b.is_free = ? AND b.status IN (1, 2) ORDER BY b.id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Book.class), isFree);
    }

    @Override
    public List<Book> search(String keyword) {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id " +
                     "WHERE b.status IN (1, 2) AND (b.title LIKE ? OR b.author LIKE ? OR b.description LIKE ?) ORDER BY b.id DESC";
        String pattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Book.class), pattern, pattern, pattern);
    }

    @Override
    public List<Book> findFiltered(Integer categoryId, Integer status, Integer free) {
        StringBuilder sql = new StringBuilder("SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id WHERE b.status IN (1, 2)");
        List<Object> params = new ArrayList<>();
        
        if (categoryId != null) {
            sql.append(" AND b.category_id = ?");
            params.add(categoryId);
        }
        if (status != null) {
            sql.append(" AND b.status = ?");
            params.add(status);
        }
        if (free != null) {
            sql.append(" AND b.is_free = ?");
            params.add(free);
        }
        sql.append(" ORDER BY b.id DESC");
        
        return jdbcTemplate.query(sql.toString(), new BeanPropertyRowMapper<>(Book.class), params.toArray());
    }

    @Override
    public List<Book> findTopViewed(int limit) {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id " +
                     "WHERE b.status IN (1, 2) ORDER BY b.view_count DESC LIMIT ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Book.class), limit);
    }

    @Override
    public List<Book> findTopFavorited(int limit) {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id " +
                     "WHERE b.status IN (1, 2) ORDER BY b.favorite_count DESC LIMIT ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Book.class), limit);
    }

    @Override
    public List<Book> findByAuthorId(Integer authorId) {
        String sql = "SELECT b.*, c.name as categoryName FROM books b LEFT JOIN categories c ON b.category_id = c.id " +
                     "WHERE b.author_id = ? AND b.status = 1 ORDER BY b.create_time DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Book.class), authorId);
    }

    @Override
    public void save(Book book) {
        String sql = "INSERT INTO books(title, author, author_id, category_id, cover_image, description, price, word_count, " +
                     "chapter_count, status, is_free, view_count, favorite_count, rating, publisher, publish_date, create_time, update_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        jdbcTemplate.update(sql,
                book.getTitle(),
                book.getAuthor(),
                book.getAuthorId(),
                book.getCategoryId(),
                book.getCoverImage(),
                book.getDescription(),
                book.getPrice(),
                book.getWordCount(),
                book.getChapterCount(),
                book.getStatus(),
                book.getIsFree(),
                book.getViewCount(),
                book.getFavoriteCount(),
                book.getRating(),
                book.getPublisher(),
                book.getPublishDate());
    }

    @Override
    public void update(Book book) {
        String sql = "UPDATE books SET title=?, author=?, category_id=?, cover_image=?, description=?, price=?, " +
                     "word_count=?, chapter_count=?, status=?, is_free=?, rating=?, publisher=?, publish_date=?, update_time=NOW() WHERE id=?";
        jdbcTemplate.update(sql,
                book.getTitle(),
                book.getAuthor(),
                book.getCategoryId(),
                book.getCoverImage(),
                book.getDescription(),
                book.getPrice(),
                book.getWordCount(),
                book.getChapterCount(),
                book.getStatus(),
                book.getIsFree(),
                book.getRating(),
                book.getPublisher(),
                book.getPublishDate(),
                book.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM books WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public void incrementViewCount(Integer id) {
        String sql = "UPDATE books SET view_count = view_count + 1 WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public void incrementFavoriteCount(Integer id) {
        String sql = "UPDATE books SET favorite_count = favorite_count + 1 WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public void incrementChapterCount(Integer id) {
        String sql = "UPDATE books SET chapter_count = chapter_count + 1 WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public void decrementChapterCount(Integer id) {
        String sql = "UPDATE books SET chapter_count = chapter_count - 1 WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public void decrementFavoriteCount(Integer id) {
        String sql = "UPDATE books SET favorite_count = favorite_count - 1 WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM books WHERE status IN (1, 2)";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}