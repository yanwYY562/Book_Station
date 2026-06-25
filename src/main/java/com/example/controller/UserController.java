package com.example.controller;

import com.example.entity.Comment;
import com.example.entity.Favorite;
import com.example.entity.ReadingRecord;
import com.example.entity.User;
import com.example.entity.UserBookSubmission;
import com.example.entity.UserChapterSubmission;
import com.example.entity.Book;
import com.example.entity.Category;
import com.example.service.CommentService;
import com.example.service.FavoriteService;
import com.example.service.ReadingRecordService;
import com.example.service.UserService;
import com.example.service.UserBookSubmissionService;
import com.example.service.UserChapterSubmissionService;
import com.example.service.CategoryService;
import com.example.service.BookService;
import com.example.service.ChapterService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Controller
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private FavoriteService favoriteService;

    @Resource
    private ReadingRecordService readingRecordService;

    @Resource
    private CommentService commentService;

    @Resource
    private UserBookSubmissionService submissionService;

    @Resource
    private UserChapterSubmissionService chapterSubmissionService;

    @Resource
    private ChapterService chapterService;

    @Resource
    private CategoryService categoryService;

    @Resource
    private BookService bookService;

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "redirect", required = false) String redirect, HttpSession session) {
        if (redirect != null) {
            session.setAttribute("redirectUrl", redirect);
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("username") String username,
                       @RequestParam("password") String password,
                       HttpSession session, Model model) {
        if (userService.login(username, password)) {
            User user = userService.findByUsername(username);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("nickname", user.getNickname());
            session.setAttribute("role", user.getRole());
            
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            session.removeAttribute("redirectUrl");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                return "redirect:" + redirectUrl;
            }
            return "redirect:/";
        }
        model.addAttribute("error", "用户名或密码错误");
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam("username") String username,
                          @RequestParam("password") String password,
                          @RequestParam("email") String email,
                          @RequestParam("nickname") String nickname,
                          Model model) {
        if (userService.findByUsername(username) != null) {
            model.addAttribute("error", "用户名已存在");
            return "register";
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setNickname(nickname);
        userService.register(user);
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/user/profile")
    public String profile(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        User user = userService.findById(userId);
        model.addAttribute("user", user);
        return "user-profile";
    }

    @PostMapping("/user/profile/update")
    public String updateProfile(@RequestParam("nickname") String nickname,
                               @RequestParam("email") String email,
                               @RequestParam(value = "phone", required = false) String phone,
                               @RequestParam(value = "password", required = false) String password,
                               HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        User user = userService.findById(userId);
        user.setNickname(nickname);
        user.setEmail(email);
        if (phone != null) {
            user.setPhone(phone);
        }
        if (password != null && !password.isEmpty()) {
            user.setPassword(password);
        }
        
        userService.update(user);
        
        session.setAttribute("nickname", nickname);
        
        model.addAttribute("user", userService.findById(userId));
        model.addAttribute("success", true);
        return "user-profile";
    }

    @GetMapping("/user/recharge")
    public String recharge(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        User user = userService.findById(userId);
        model.addAttribute("user", user);
        return "user-recharge";
    }

    @PostMapping("/user/recharge/submit")
    public String rechargeSubmit(@RequestParam("amount") Double amount, 
                                HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        User user = userService.findById(userId);
        // 增加余额
        if (user.getBalance() == null) {
            user.setBalance(new BigDecimal(amount));
        } else {
            user.setBalance(user.getBalance().add(new BigDecimal(amount)));
        }
        userService.update(user);
        model.addAttribute("user", user);
        model.addAttribute("rechargeAmount", amount);
        model.addAttribute("showMessage", true);
        return "user-recharge";
    }

    @GetMapping("/user/favorites")
    public String favorites(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        List<Favorite> favorites = favoriteService.findByUserId(userId);
        model.addAttribute("favorites", favorites);
        return "user-favorites";
    }

    @GetMapping("/user/reading-history")
    public String readingHistory(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        List<ReadingRecord> records = readingRecordService.findByUserId(userId);
        model.addAttribute("records", records);
        return "user-reading-history";
    }

    @GetMapping("/user/comments")
    public String comments(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        List<Comment> comments = commentService.findByUserId(userId);
        model.addAttribute("comments", comments);
        return "user-comments";
    }

    @GetMapping("/user/toggle-favorite/{bookId}")
    public String toggleFavorite(@PathVariable("bookId") Integer bookId, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId != null) {
            favoriteService.toggleFavorite(userId, bookId);
            return "redirect:/books/" + bookId + "?from=favorite";
        } else {
            return "redirect:/login?redirect=/books/" + bookId;
        }
    }

    @PostMapping("/books/{bookId}/comment")
    public String addComment(@PathVariable("bookId") Integer bookId,
                            @RequestParam("content") String content,
                            @RequestParam(value = "rating", defaultValue = "5") Integer rating,
                            HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId != null) {
            Comment comment = new Comment();
            comment.setUserId(userId);
            comment.setBookId(bookId);
            comment.setContent(content);
            comment.setRating(rating);
            comment.setStatus(1);
            commentService.save(comment);
        }
        return "redirect:/books/" + bookId;
    }

    @GetMapping("/comment/delete/{id}")
    public String deleteComment(@PathVariable("id") Integer id, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");
        Integer bookId = null;
        
        if (userId != null) {
            Comment comment = commentService.findById(id);
            if (comment != null) {
                bookId = comment.getBookId();
                // 管理员可以删除任何评论，普通用户只能删除自己的评论
                if ("admin".equals(role) || comment.getUserId().equals(userId)) {
                    commentService.delete(id);
                }
            }
        }
        // 如果知道书籍ID，重定向回图书详情页，否则返回用户评论页
        if (bookId != null) {
            return "redirect:/books/" + bookId;
        }
        return "redirect:/user/comments";
    }

    @GetMapping("/user/submit-book")
    public String submitBookPage(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        List<Category> categories = categoryService.findByStatus(1);
        List<UserBookSubmission> bookSubmissions = submissionService.findByUserId(userId);
        List<Book> myBooks = bookService.findByAuthorId(userId);
        List<UserChapterSubmission> chapterSubmissions = chapterSubmissionService.findByUserId(userId);
        model.addAttribute("categories", categories);
        model.addAttribute("bookSubmissions", bookSubmissions);
        model.addAttribute("myBooks", myBooks);
        model.addAttribute("chapterSubmissions", chapterSubmissions);
        return "user-my-books";
    }

    @PostMapping("/user/submit-book")
    public String submitBook(@RequestParam("title") String title,
                            @RequestParam("author") String author,
                            @RequestParam("categoryId") Integer categoryId,
                            @RequestParam("price") BigDecimal price,
                            @RequestParam(value = "wordCount", defaultValue = "0") Integer wordCount,
                            @RequestParam(value = "description", required = false) String description,
                            @RequestParam(value = "coverImage", required = false) String coverImage,
                            @RequestParam(value = "coverFile", required = false) MultipartFile coverFile,
                            @RequestParam(value = "isFree", defaultValue = "0") Integer isFree,
                            HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        String finalCoverImage = saveCoverImage(coverFile, coverImage, session);

        UserBookSubmission submission = new UserBookSubmission();
        submission.setUserId(userId);
        submission.setTitle(title);
        submission.setAuthor(author);
        submission.setCategoryId(categoryId);
        submission.setPrice(price);
        submission.setWordCount(wordCount);
        submission.setDescription(description);
        submission.setCoverImage(finalCoverImage);
        submission.setIsFree(isFree);
        submissionService.save(submission);

        List<Category> categories = categoryService.findByStatus(1);
        List<UserBookSubmission> bookSubmissions = submissionService.findByUserId(userId);
        List<Book> myBooks = bookService.findByAuthorId(userId);
        List<UserChapterSubmission> chapterSubmissions = chapterSubmissionService.findByUserId(userId);
        model.addAttribute("categories", categories);
        model.addAttribute("bookSubmissions", bookSubmissions);
        model.addAttribute("myBooks", myBooks);
        model.addAttribute("chapterSubmissions", chapterSubmissions);
        model.addAttribute("message", "提交成功！等待管理员审核。");
        return "user-my-books";
    }

    @GetMapping("/user/my-books")
    public String myBooks(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        List<Book> myBooks = bookService.findByAuthorId(userId);
        List<UserBookSubmission> bookSubmissions = submissionService.findByUserId(userId);
        List<UserChapterSubmission> chapterSubmissions = chapterSubmissionService.findByUserId(userId);
        List<Category> categories = categoryService.findByStatus(1);
        model.addAttribute("myBooks", myBooks);
        model.addAttribute("bookSubmissions", bookSubmissions);
        model.addAttribute("chapterSubmissions", chapterSubmissions);
        model.addAttribute("categories", categories);
        return "user-my-books";
    }

    @GetMapping("/user/submit-chapter")
    public String submitChapterPage(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        List<Book> myBooks = bookService.findByAuthorId(userId);
        List<UserChapterSubmission> chapterSubmissions = chapterSubmissionService.findByUserId(userId);
        List<Category> categories = categoryService.findByStatus(1);
        List<UserBookSubmission> bookSubmissions = submissionService.findByUserId(userId);
        model.addAttribute("myBooks", myBooks);
        model.addAttribute("chapterSubmissions", chapterSubmissions);
        model.addAttribute("categories", categories);
        model.addAttribute("bookSubmissions", bookSubmissions);
        return "user-my-books";
    }

    @PostMapping("/user/submit-chapter")
    public String submitChapter(@RequestParam("bookId") Integer bookId,
                               @RequestParam(value = "chapterNumber", required = false) Integer chapterNumber,
                               @RequestParam("title") String title,
                               @RequestParam("content") String content,
                               @RequestParam(value = "isFree", defaultValue = "0") Integer isFree,
                               @RequestParam(value = "price", required = false) BigDecimal price,
                               HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        // 如果没有指定章节序号，自动生成下一个可用的序号
        if (chapterNumber == null || chapterNumber <= 0) {
            chapterNumber = chapterService.findMaxChapterNumber(bookId) + 1;
        }

        // 检查章节序号是否已存在
        if (chapterService.existsByBookIdAndChapterNumber(bookId, chapterNumber)) {
            List<Book> myBooks = bookService.findByAuthorId(userId);
            List<UserChapterSubmission> chapterSubmissions = chapterSubmissionService.findByUserId(userId);
            List<Category> categories = categoryService.findByStatus(1);
            List<UserBookSubmission> bookSubmissions = submissionService.findByUserId(userId);
            model.addAttribute("myBooks", myBooks);
            model.addAttribute("chapterSubmissions", chapterSubmissions);
            model.addAttribute("categories", categories);
            model.addAttribute("bookSubmissions", bookSubmissions);
            model.addAttribute("error", "章节序号 " + chapterNumber + " 已存在，请选择其他序号");
            model.addAttribute("selectedBookId", bookId);
            model.addAttribute("selectedBookTitle", bookService.findById(bookId).getTitle());
            return "user-my-books";
        }

        UserChapterSubmission submission = new UserChapterSubmission();
        submission.setUserId(userId);
        submission.setBookId(bookId);
        submission.setChapterNumber(chapterNumber);
        submission.setTitle(title);
        submission.setContent(content);
        submission.setIsFree(isFree);
        submission.setPrice(price != null ? price : BigDecimal.ZERO);
        chapterSubmissionService.save(submission);

        List<Book> myBooks = bookService.findByAuthorId(userId);
        List<UserChapterSubmission> chapterSubmissions = chapterSubmissionService.findByUserId(userId);
        List<Category> categories = categoryService.findByStatus(1);
        List<UserBookSubmission> bookSubmissions = submissionService.findByUserId(userId);
        model.addAttribute("myBooks", myBooks);
        model.addAttribute("chapterSubmissions", chapterSubmissions);
        model.addAttribute("categories", categories);
        model.addAttribute("bookSubmissions", bookSubmissions);
        model.addAttribute("message", "章节提交成功！等待管理员审核。");
        return "user-my-books";
    }

    @GetMapping("/user/delete-book/{bookId}")
    public String deleteBook(@PathVariable("bookId") Integer bookId, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        Book book = bookService.findById(bookId);
        if (book != null && book.getAuthorId() != null && book.getAuthorId().equals(userId)) {
            bookService.delete(bookId);
            model.addAttribute("message", "图书删除成功！");
        } else {
            model.addAttribute("error", "您没有权限删除该图书！");
        }

        List<Book> myBooks = bookService.findByAuthorId(userId);
        List<UserChapterSubmission> chapterSubmissions = chapterSubmissionService.findByUserId(userId);
        List<Category> categories = categoryService.findByStatus(1);
        List<UserBookSubmission> bookSubmissions = submissionService.findByUserId(userId);
        model.addAttribute("myBooks", myBooks);
        model.addAttribute("chapterSubmissions", chapterSubmissions);
        model.addAttribute("categories", categories);
        model.addAttribute("bookSubmissions", bookSubmissions);
        return "user-my-books";
    }

    @GetMapping("/user/delete-chapter/{chapterId}")
    public String deleteChapter(@PathVariable("chapterId") Integer chapterId,
                               @RequestParam("bookId") Integer bookId,
                               HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        Book book = bookService.findById(bookId);
        if (book != null && book.getAuthorId() != null && book.getAuthorId().equals(userId)) {
            chapterService.delete(chapterId);
            bookService.decrementChapterCount(bookId);
            model.addAttribute("message", "章节删除成功！");
        } else {
            model.addAttribute("error", "您没有权限删除该章节！");
        }

        return "redirect:/books/" + bookId;
    }

    private String saveCoverImage(MultipartFile coverFile, String coverImageUrl, HttpSession session) {
        if (coverFile != null && !coverFile.isEmpty()) {
            try {
                ServletContext context = session.getServletContext();
                String uploadPath = context.getRealPath("/uploads/covers");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String originalFilename = coverFile.getOriginalFilename();
                String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                String newFilename = UUID.randomUUID().toString() + extension;

                File destFile = new File(uploadDir, newFilename);
                coverFile.transferTo(destFile);

                return "/uploads/covers/" + newFilename;
            } catch (Exception e) {
                e.printStackTrace();
                return coverImageUrl;
            }
        }
        return coverImageUrl;
    }
}