package com.example.service;

import com.example.entity.PurchaseRecord;
import java.util.List;

public interface PurchaseRecordService {
    void save(PurchaseRecord record);
    boolean existsByUserIdAndBookId(Integer userId, Integer bookId);
    List<PurchaseRecord> findByUserId(Integer userId);
}
