package com.example.dao.impl;

import com.example.dao.UserDao;
import com.example.entity.User;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public User findById(Integer id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), username);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), email);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void save(User user) {
        String sql = "INSERT INTO users(username, password, email, phone, nickname, avatar, role, status, vip_level, balance, create_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        jdbcTemplate.update(sql,
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                user.getPhone(),
                user.getNickname(),
                user.getAvatar(),
                user.getRole(),
                user.getStatus(),
                user.getVipLevel(),
                user.getBalance());
    }

    @Override
    public void update(User user) {
        String sql = "UPDATE users SET password=?, email=?, phone=?, nickname=?, avatar=?, role=?, status=?, vip_level=?, balance=?, last_login_time=? WHERE id=?";
        jdbcTemplate.update(sql,
                user.getPassword(),
                user.getEmail(),
                user.getPhone(),
                user.getNickname(),
                user.getAvatar(),
                user.getRole(),
                user.getStatus(),
                user.getVipLevel(),
                user.getBalance(),
                user.getLastLoginTime(),
                user.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM users WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public List<User> findAll() {
        String sql = "SELECT * FROM users ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(User.class));
    }

    @Override
    public List<User> findByRole(String role) {
        String sql = "SELECT * FROM users WHERE role = ? ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(User.class), role);
    }

    @Override
    public List<User> findByStatus(Integer status) {
        String sql = "SELECT * FROM users WHERE status = ? ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(User.class), status);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM users WHERE status = 1";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}