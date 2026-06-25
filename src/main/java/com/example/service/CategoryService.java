package com.example.service;

import com.example.entity.Category;

import java.util.List;

public interface CategoryService {
    Category findById(Integer id);
    List<Category> findAll();
    List<Category> findByParentId(Integer parentId);
    List<Category> findByStatus(Integer status);
    void save(Category category);
    void update(Category category);
    void delete(Integer id);
}