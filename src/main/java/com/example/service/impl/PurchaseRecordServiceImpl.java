package com.example.service.impl;

import com.example.dao.PurchaseRecordDao;
import com.example.entity.PurchaseRecord;
import com.example.service.PurchaseRecordService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class PurchaseRecordServiceImpl implements PurchaseRecordService {

    @Resource
    private PurchaseRecordDao purchaseRecordDao;

    @Override
    public void save(PurchaseRecord record) {
        purchaseRecordDao.save(record);
    }

    @Override
    public boolean existsByUserIdAndBookId(Integer userId, Integer bookId) {
        return purchaseRecordDao.existsByUserIdAndBookId(userId, bookId);
    }

    @Override
    public List<PurchaseRecord> findByUserId(Integer userId) {
        return purchaseRecordDao.findByUserId(userId);
    }
}
