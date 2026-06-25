package com.example.service;

import com.example.entity.UserBookSubmission;
import java.util.List;

public interface UserBookSubmissionService {
    UserBookSubmission findById(Integer id);
    List<UserBookSubmission> findAll();
    List<UserBookSubmission> findByStatus(Integer status);
    List<UserBookSubmission> findByUserId(Integer userId);
    void save(UserBookSubmission submission);
    void approve(Integer id);
    void reject(Integer id, String reason);
    void delete(Integer id);
}
