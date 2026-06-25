package com.example.service.impl;

import com.example.dao.ChapterDao;
import com.example.entity.Chapter;
import com.example.service.ChapterService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ChapterServiceImpl implements ChapterService {

    @Resource
    private ChapterDao chapterDao;

    @Override
    public Chapter findById(Integer id) {
        return chapterDao.findById(id);
    }

    @Override
    public List<Chapter> findByBookId(Integer bookId) {
        return chapterDao.findByBookId(bookId);
    }

    @Override
    public List<Chapter> findByBookIdAllStatus(Integer bookId) {
        return chapterDao.findByBookIdAllStatus(bookId);
    }

    @Override
    public Chapter findFirstByBookId(Integer bookId) {
        return chapterDao.findFirstByBookId(bookId);
    }

    @Override
    public Chapter findFirstByBookIdAllStatus(Integer bookId) {
        return chapterDao.findFirstByBookIdAllStatus(bookId);
    }

    @Override
    public Chapter findNextChapter(Integer bookId, Integer chapterNumber) {
        return chapterDao.findNextChapter(bookId, chapterNumber);
    }

    @Override
    public Chapter findPreviousChapter(Integer bookId, Integer chapterNumber) {
        return chapterDao.findPreviousChapter(bookId, chapterNumber);
    }

    @Override
    public void save(Chapter chapter) {
        chapterDao.save(chapter);
    }

    @Override
    public void update(Chapter chapter) {
        chapterDao.update(chapter);
    }

    @Override
    public void delete(Integer id) {
        chapterDao.delete(id);
    }

    @Override
    public int countByBookId(Integer bookId) {
        return chapterDao.countByBookId(bookId);
    }

    @Override
    public int count() {
        return chapterDao.count();
    }

    @Override
    public List<Chapter> findAll() {
        return chapterDao.findAll();
    }

    @Override
    public boolean existsByBookIdAndChapterNumber(Integer bookId, Integer chapterNumber) {
        return chapterDao.existsByBookIdAndChapterNumber(bookId, chapterNumber);
    }

    @Override
    public Integer findMaxChapterNumber(Integer bookId) {
        return chapterDao.findMaxChapterNumber(bookId);
    }
}