package com.example.dao.impl;

import com.example.dao.CategoryDao;
import com.example.entity.Category;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class CategoryDaoImpl implements CategoryDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public Category findById(Integer id) {
        String sql = "SELECT * FROM categories WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Category.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Category> findAll() {
        String sql = "SELECT * FROM categories ORDER BY sort_order ASC, id ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Category.class));
    }

    @Override
    public List<Category> findByParentId(Integer parentId) {
        String sql = "SELECT * FROM categories WHERE parent_id = ? ORDER BY sort_order ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Category.class), parentId);
    }

    @Override
    public List<Category> findByStatus(Integer status) {
        String sql = "SELECT * FROM categories WHERE status = ? ORDER BY sort_order ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Category.class), status);
    }

    @Override
    public void save(Category category) {
        String sql = "INSERT INTO categories(name, description, parent_id, sort_order, icon, status, create_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?, NOW())";
        jdbcTemplate.update(sql,
                category.getName(),
                category.getDescription(),
                category.getParentId(),
                category.getSortOrder(),
                category.getIcon(),
                category.getStatus());
    }

    @Override
    public void update(Category category) {
        String sql = "UPDATE categories SET name=?, description=?, parent_id=?, sort_order=?, icon=?, status=? WHERE id=?";
        jdbcTemplate.update(sql,
                category.getName(),
                category.getDescription(),
                category.getParentId(),
                category.getSortOrder(),
                category.getIcon(),
                category.getStatus(),
                category.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}