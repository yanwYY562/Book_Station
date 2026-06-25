package com.example.service.impl;

import com.example.dao.ReadingRecordDao;
import com.example.entity.ReadingRecord;
import com.example.service.ReadingRecordService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ReadingRecordServiceImpl implements ReadingRecordService {

    @Resource
    private ReadingRecordDao readingRecordDao;

    @Override
    public ReadingRecord findById(Integer id) {
        return readingRecordDao.findById(id);
    }

    @Override
    public ReadingRecord findByUserIdAndBookId(Integer userId, Integer bookId) {
        return readingRecordDao.findByUserIdAndBookId(userId, bookId);
    }

    @Override
    public List<ReadingRecord> findByUserId(Integer userId) {
        return readingRecordDao.findByUserId(userId);
    }

    @Override
    public void save(ReadingRecord record) {
        readingRecordDao.save(record);
    }

    @Override
    public void update(ReadingRecord record) {
        readingRecordDao.update(record);
    }

    @Override
    public void delete(Integer id) {
        readingRecordDao.delete(id);
    }

    @Override
    public void updateReadingProgress(Integer userId, Integer bookId, Integer chapterId, Integer progress) {
        saveOrUpdate(userId, bookId, chapterId, progress);
    }

    @Override
    public void saveOrUpdate(Integer userId, Integer bookId, Integer chapterId, Integer progress) {
        ReadingRecord record = readingRecordDao.findByUserIdAndBookId(userId, bookId);
        if (record != null) {
            record.setChapterId(chapterId);
            record.setReadProgress(progress);
            readingRecordDao.update(record);
        } else {
            ReadingRecord newRecord = new ReadingRecord();
            newRecord.setUserId(userId);
            newRecord.setBookId(bookId);
            newRecord.setChapterId(chapterId);
            newRecord.setReadProgress(progress);
            readingRecordDao.save(newRecord);
        }
    }
}