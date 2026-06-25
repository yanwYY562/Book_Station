package com.example.service;

import com.example.entity.Favorite;

import java.util.List;

public interface FavoriteService {
    Favorite findById(Integer id);
    Favorite findByUserIdAndBookId(Integer userId, Integer bookId);
    List<Favorite> findByUserId(Integer userId);
    void save(Favorite favorite);
    void delete(Integer id);
    void deleteByUserIdAndBookId(Integer userId, Integer bookId);
    boolean exists(Integer userId, Integer bookId);
    void toggleFavorite(Integer userId, Integer bookId);
}