package com.example.service.impl;

import com.example.dao.UserChapterSubmissionDao;
import com.example.dao.ChapterDao;
import com.example.dao.BookDao;
import com.example.entity.UserChapterSubmission;
import com.example.entity.Chapter;
import com.example.service.UserChapterSubmissionService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;

@Service
public class UserChapterSubmissionServiceImpl implements UserChapterSubmissionService {

    @Resource
    private UserChapterSubmissionDao submissionDao;

    @Resource
    private ChapterDao chapterDao;

    @Resource
    private BookDao bookDao;

    @Override
    public UserChapterSubmission findById(Integer id) {
        return submissionDao.findById(id);
    }

    @Override
    public List<UserChapterSubmission> findAll() {
        return submissionDao.findAll();
    }

    @Override
    public List<UserChapterSubmission> findByStatus(Integer status) {
        return submissionDao.findByStatus(status);
    }

    @Override
    public List<UserChapterSubmission> findByUserId(Integer userId) {
        return submissionDao.findByUserId(userId);
    }

    @Override
    public List<UserChapterSubmission> findByBookId(Integer bookId) {
        return submissionDao.findByBookId(bookId);
    }

    @Override
    public void save(UserChapterSubmission submission) {
        submissionDao.save(submission);
    }

    @Override
    @Transactional
    public void approve(Integer id) {
        UserChapterSubmission submission = submissionDao.findById(id);
        if (submission == null) return;

        Chapter chapter = new Chapter();
        chapter.setBookId(submission.getBookId());
        chapter.setChapterNumber(submission.getChapterNumber());
        chapter.setTitle(submission.getTitle());
        chapter.setContent(submission.getContent());
        chapter.setWordCount(submission.getContent().length());
        chapter.setIsFree(submission.getIsFree());
        chapter.setPrice(submission.getPrice() != null ? submission.getPrice() : BigDecimal.ZERO);
        chapter.setStatus(1);
        chapterDao.save(chapter);

        bookDao.incrementChapterCount(submission.getBookId());

        submission.setStatus(1);
        submissionDao.update(submission);
    }

    @Override
    public void reject(Integer id, String reason) {
        UserChapterSubmission submission = submissionDao.findById(id);
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
