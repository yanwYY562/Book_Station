package com.example.service.impl;

import com.example.dao.UserBookSubmissionDao;
import com.example.dao.BookDao;
import com.example.entity.UserBookSubmission;
import com.example.entity.Book;
import com.example.service.UserBookSubmissionService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;

@Service
public class UserBookSubmissionServiceImpl implements UserBookSubmissionService {

    @Resource
    private UserBookSubmissionDao submissionDao;

    @Resource
    private BookDao bookDao;

    @Override
    public UserBookSubmission findById(Integer id) {
        return submissionDao.findById(id);
    }

    @Override
    public List<UserBookSubmission> findAll() {
        return submissionDao.findAll();
    }

    @Override
    public List<UserBookSubmission> findByStatus(Integer status) {
        return submissionDao.findByStatus(status);
    }

    @Override
    public List<UserBookSubmission> findByUserId(Integer userId) {
        return submissionDao.findByUserId(userId);
    }

    @Override
    public void save(UserBookSubmission submission) {
        submissionDao.save(submission);
    }

    @Override
    @Transactional
    public void approve(Integer id) {
        UserBookSubmission submission = submissionDao.findById(id);
        if (submission == null) return;

        Book book = new Book();
        book.setTitle(submission.getTitle());
        book.setAuthor(submission.getAuthor());
        book.setAuthorId(submission.getUserId());
        book.setCategoryId(submission.getCategoryId());
        book.setCoverImage(submission.getCoverImage());
        book.setDescription(submission.getDescription());
        book.setPrice(submission.getPrice());
        book.setWordCount(submission.getWordCount());
        book.setChapterCount(0);
        book.setStatus(1);
        book.setIsFree(submission.getIsFree());
        book.setViewCount(0);
        book.setFavoriteCount(0);
        book.setRating(BigDecimal.ZERO);
        bookDao.save(book);

        submission.setStatus(1);
        submissionDao.update(submission);
    }

    @Override
    public void reject(Integer id, String reason) {
        UserBookSubmission submission = submissionDao.findById(id);
        if (submission == null) return;
        submission.setStatus(2);
        submission.setRejectReason(reason);
        submissionDao.update(submission);
    }

    @Override
    public void delete(Integer id) {
        submissionDao.delete(id);
    }
}
