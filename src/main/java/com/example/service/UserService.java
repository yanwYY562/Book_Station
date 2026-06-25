package com.example.service;

import com.example.entity.User;

import java.util.List;

public interface UserService {
    User findById(Integer id);
    User findByUsername(String username);
    User findByEmail(String email);
    void save(User user);
    void update(User user);
    void delete(Integer id);
    List<User> findAll();
    List<User> findByRole(String role);
    List<User> findByStatus(Integer status);
    boolean login(String username, String password);
    void register(User user);
    int count();
}