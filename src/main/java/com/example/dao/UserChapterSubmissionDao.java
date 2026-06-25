package com.example.dao;

import com.example.entity.UserChapterSubmission;
import java.util.List;

public interface UserChapterSubmissionDao {
    UserChapterSubmission findById(Integer id);
    List<UserChapterSubmission> findAll();
    List<UserChapterSubmission> findByStatus(Integer status);
    List<UserChapterSubmission> findByUserId(Integer userId);
    List<UserChapterSubmission> findByBookId(Integer bookId);
    void save(UserChapterSubmission submission);
    void update(UserChapterSubmission submission);
    void delete(Integer id);
}
