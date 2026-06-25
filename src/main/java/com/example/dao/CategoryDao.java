package com.example.dao;

import com.example.entity.Category;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface CategoryDao {
    Category findById(Integer id);
    List<Category> findAll();
    List<Category> findByParentId(Integer parentId);
    List<Category> findByStatus(Integer status);
    void save(Category category);
    void update(Category category);
    void delete(Integer id);
}