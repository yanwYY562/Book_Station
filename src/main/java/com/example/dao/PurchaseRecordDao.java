package com.example.dao;

import com.example.entity.PurchaseRecord;
import java.util.List;

public interface PurchaseRecordDao {
    void save(PurchaseRecord record);
    boolean existsByUserIdAndBookId(Integer userId, Integer bookId);
    List<PurchaseRecord> findByUserId(Integer userId);
}
