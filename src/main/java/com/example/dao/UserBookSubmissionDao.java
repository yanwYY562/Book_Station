package com.example.dao;

import com.example.entity.UserBookSubmission;
import java.util.List;

public interface UserBookSubmissionDao {
    UserBookSubmission findById(Integer id);
    List<UserBookSubmission> findAll();
    List<UserBookSubmission> findByStatus(Integer status);
    List<UserBookSubmission> findByUserId(Integer userId);
    void save(UserBookSubmission submission);
    void update(UserBookSubmission submission);
    void delete(Integer id);
}
