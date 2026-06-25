package com.example.service;

import com.example.entity.ReadingRecord;

import java.util.List;

public interface ReadingRecordService {
    ReadingRecord findById(Integer id);
    ReadingRecord findByUserIdAndBookId(Integer userId, Integer bookId);
    List<ReadingRecord> findByUserId(Integer userId);
    void save(ReadingRecord record);
    void update(ReadingRecord record);
    void delete(Integer id);
    void updateReadingProgress(Integer userId, Integer bookId, Integer chapterId, Integer progress);
    void saveOrUpdate(Integer userId, Integer bookId, Integer chapterId, Integer progress);
}