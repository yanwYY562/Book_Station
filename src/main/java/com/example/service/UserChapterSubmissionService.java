package com.example.service;

import com.example.entity.UserChapterSubmission;
import java.util.List;

public interface UserChapterSubmissionService {
    UserChapterSubmission findById(Integer id);
    List<UserChapterSubmission> findAll();
    List<UserChapterSubmission> findByStatus(Integer status);
    List<UserChapterSubmission> findByUserId(Integer userId);
    List<UserChapterSubmission> findByBookId(Integer bookId);
    void save(UserChapterSubmission submission);
    void approve(Integer id);
    void reject(Integer id, String reason);
    void delete(Integer id);
}
