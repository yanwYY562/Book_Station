package com.example.service.impl;

import com.example.dao.CategoryDao;
import com.example.entity.Category;
import com.example.service.CategoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Resource
    private CategoryDao categoryDao;

    @Override
    public Category findById(Integer id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> findByParentId(Integer parentId) {
        return categoryDao.findByParentId(parentId);
    }

    @Override
    public List<Category> findByStatus(Integer status) {
        return categoryDao.findByStatus(status);
    }

    @Override
    public void save(Category category) {
        categoryDao.save(category);
    }

    @Override
    public void update(Category category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(Integer id) {
        categoryDao.delete(id);
    }
}