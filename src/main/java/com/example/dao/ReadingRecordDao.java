package com.example.dao;

import com.example.entity.ReadingRecord;

import java.util.List;

public interface ReadingRecordDao {
    ReadingRecord findById(Integer id);
    ReadingRecord findByUserIdAndBookId(Integer userId, Integer bookId);
    List<ReadingRecord> findByUserId(Integer userId);
    void save(ReadingRecord record);
    void update(ReadingRecord record);
    void delete(Integer id);
}