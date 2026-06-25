package com.example.dao;

import com.example.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface UserDao {
    User findById(Integer id);
    User findByUsername(String username);
    User findByEmail(String email);
    void save(User user);
    void update(User user);
    void delete(Integer id);
    List<User> findAll();
    List<User> findByRole(String role);
    List<User> findByStatus(Integer status);
    int count();
}