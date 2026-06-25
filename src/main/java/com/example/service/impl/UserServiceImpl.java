package com.example.service.impl;

import com.example.dao.UserDao;
import com.example.entity.User;
import com.example.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;

    @Override
    public User findById(Integer id) {
        return userDao.findById(id);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void save(User user) {
        userDao.save(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void delete(Integer id) {
        userDao.delete(id);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public List<User> findByRole(String role) {
        return userDao.findByRole(role);
    }

    @Override
    public List<User> findByStatus(Integer status) {
        return userDao.findByStatus(status);
    }

    @Override
    public boolean login(String username, String password) {
        User user = userDao.findByUsername(username);
        return user != null && user.getPassword().equals(password) && user.getStatus() == 1;
    }

    @Override
    public void register(User user) {
        user.setPassword(user.getPassword());
        user.setRole("user");
        user.setStatus(1);
        user.setVipLevel(0);
        user.setBalance(BigDecimal.ZERO);
        user.setAvatar("/images/default-avatar.png");
        userDao.save(user);
    }

    @Override
    public int count() {
        return userDao.count();
    }
}