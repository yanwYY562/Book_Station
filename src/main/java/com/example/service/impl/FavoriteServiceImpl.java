package com.example.service.impl;

import com.example.dao.FavoriteDao;
import com.example.entity.Favorite;
import com.example.service.BookService;
import com.example.service.FavoriteService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Resource
    private FavoriteDao favoriteDao;

    @Resource
    private BookService bookService;

    @Override
    public Favorite findById(Integer id) {
        return favoriteDao.findById(id);
    }

    @Override
    public Favorite findByUserIdAndBookId(Integer userId, Integer bookId) {
        return favoriteDao.findByUserIdAndBookId(userId, bookId);
    }

    @Override
    public List<Favorite> findByUserId(Integer userId) {
        return favoriteDao.findByUserId(userId);
    }

    @Override
    public void save(Favorite favorite) {
        favoriteDao.save(favorite);
    }

    @Override
    public void delete(Integer id) {
        favoriteDao.delete(id);
    }

    @Override
    public void deleteByUserIdAndBookId(Integer userId, Integer bookId) {
        favoriteDao.deleteByUserIdAndBookId(userId, bookId);
    }

    @Override
    public boolean exists(Integer userId, Integer bookId) {
        return favoriteDao.exists(userId, bookId);
    }

    @Override
    public void toggleFavorite(Integer userId, Integer bookId) {
        if (favoriteDao.exists(userId, bookId)) {
            favoriteDao.deleteByUserIdAndBookId(userId, bookId);
            bookService.decrementFavoriteCount(bookId);
        } else {
            Favorite favorite = new Favorite();
            favorite.setUserId(userId);
            favorite.setBookId(bookId);
            favoriteDao.save(favorite);
            bookService.incrementFavoriteCount(bookId);
        }
    }
}