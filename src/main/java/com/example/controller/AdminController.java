package com.example.controller;

import com.example.entity.*;
import com.example.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Resource
    private BookService bookService;

    @Resource
    private ChapterService chapterService;

    @Resource
    private CategoryService categoryService;

    @Resource
    private UserService userService;

    @Resource
    private CommentService commentService;

    @Resource
    private UserBookSubmissionService submissionService;

    @Resource
    private UserChapterSubmissionService chapterSubmissionService;

    @GetMapping("")
    public String index(@RequestParam(value = "tab", required = false) String tab,
                       @RequestParam(value = "status", required = false) Integer status,
                       HttpSession session, Model model) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Map<String, Object> stats = new HashMap<>();
        stats.put("bookCount", bookService.count());
        stats.put("chapterCount", chapterService.count());
        stats.put("userCount", userService.count());
        stats.put("commentCount", commentService.count());
        model.addAttribute("stats", stats);

        List<UserBookSubmission> bookSubmissions;
        List<UserChapterSubmission> chapterSubmissions;

        if (status != null) {
            bookSubmissions = submissionService.findByStatus(status);
            chapterSubmissions = chapterSubmissionService.findByStatus(status);
        } else {
            bookSubmissions = submissionService.findAll();
            chapterSubmissions = chapterSubmissionService.findAll();
        }

        model.addAttribute("bookSubmissions", bookSubmissions);
        model.addAttribute("chapterSubmissions", chapterSubmissions);

        return "admin";
    }

    @GetMapping("/books")
    public String bookList(Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<Book> books = bookService.findAll();
        model.addAttribute("books", books);
        return "admin-book-list";
    }

    @GetMapping("/books/search")
    public String bookSearch(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<Book> books = bookService.search(keyword);
        model.addAttribute("books", books);
        model.addAttribute("keyword", keyword);
        return "admin-book-list";
    }

    @GetMapping("/books/add")
    public String bookAdd(Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<Category> categories = categoryService.findByStatus(1);
        model.addAttribute("categories", categories);
        return "admin-book-form";
    }

    @PostMapping("/books/save")
    public String bookSave(@RequestParam("title") String title,
                          @RequestParam("author") String author,
                          @RequestParam("categoryId") Integer categoryId,
                          @RequestParam(value = "coverImage", required = false) String coverImage,
                          @RequestParam(value = "coverFile", required = false) MultipartFile coverFile,
                          @RequestParam(value = "publisher", required = false) String publisher,
                          @RequestParam("description") String description,
                          @RequestParam("price") BigDecimal price,
                          @RequestParam("isFree") Integer isFree,
                          @RequestParam("wordCount") Integer wordCount,
                          @RequestParam("status") Integer status,
                          HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }

        String finalCoverImage = saveCoverImage(coverFile, coverImage, session);

        Book book = new Book();
        book.setTitle(title);
        book.setAuthor(author);
        book.setCategoryId(categoryId);
        book.setCoverImage(finalCoverImage);
        book.setPublisher(publisher);
        book.setDescription(description);
        book.setPrice(price);
        book.setIsFree(isFree);
        book.setWordCount(wordCount);
        book.setStatus(status);
        book.setChapterCount(0);
        book.setViewCount(0);
        book.setFavoriteCount(0);
        book.setRating(BigDecimal.ZERO);
        bookService.save(book);
        return "redirect:/admin/books";
    }

    @GetMapping("/books/edit/{id}")
    public String bookEdit(@PathVariable("id") Integer id, Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Book book = bookService.findById(id);
        List<Category> categories = categoryService.findByStatus(1);
        model.addAttribute("book", book);
        model.addAttribute("categories", categories);
        return "admin-book-form";
    }

    @PostMapping("/books/update")
    public String bookUpdate(@RequestParam("id") Integer id,
                            @RequestParam("title") String title,
                            @RequestParam("author") String author,
                            @RequestParam("categoryId") Integer categoryId,
                            @RequestParam(value = "coverImage", required = false) String coverImage,
                            @RequestParam(value = "coverFile", required = false) MultipartFile coverFile,
                            @RequestParam(value = "publisher", required = false) String publisher,
                            @RequestParam("description") String description,
                            @RequestParam("price") BigDecimal price,
                            @RequestParam("isFree") Integer isFree,
                            @RequestParam("wordCount") Integer wordCount,
                            @RequestParam("status") Integer status,
                            HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Book book = bookService.findById(id);
        book.setTitle(title);
        book.setAuthor(author);
        book.setCategoryId(categoryId);

        String finalCoverImage = saveCoverImage(coverFile, coverImage, session);
        if (finalCoverImage != null && !finalCoverImage.isEmpty()) {
            book.setCoverImage(finalCoverImage);
        } else if (coverImage != null && !coverImage.isEmpty()) {
            book.setCoverImage(coverImage);
        }

        if (publisher != null) book.setPublisher(publisher);
        book.setDescription(description);
        book.setPrice(price);
        book.setIsFree(isFree);
        book.setWordCount(wordCount);
        book.setStatus(status);
        bookService.update(book);
        return "redirect:/admin/books";
    }

    @GetMapping("/books/delete/{id}")
    public String bookDelete(@PathVariable("id") Integer id, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        bookService.delete(id);
        return "redirect:/admin/books";
    }

    @GetMapping("/chapters")
    public String chapterList(@RequestParam(value = "bookId", required = false) Integer bookId, 
                             Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<Book> books = bookService.findByStatus(1);
        List<Chapter> chapters;
        if (bookId != null) {
            chapters = chapterService.findByBookId(bookId);
        } else {
            chapters = chapterService.findAll();
        }
        model.addAttribute("books", books);
        model.addAttribute("chapters", chapters);
        model.addAttribute("bookId", bookId);
        return "admin-chapter-list";
    }

    @GetMapping("/chapters/add")
    public String chapterAdd(@RequestParam(value = "bookId", required = false) Integer bookId, 
                            Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<Book> books = bookService.findByStatus(1);
        model.addAttribute("books", books);
        model.addAttribute("bookId", bookId);
        if (bookId != null) {
            int chapterCount = chapterService.countByBookId(bookId);
            model.addAttribute("chapterNumber", chapterCount + 1);
        }
        return "admin-chapter-form";
    }

    @PostMapping("/chapters/save")
    public String chapterSave(@RequestParam("bookId") Integer bookId,
                             @RequestParam("chapterNumber") Integer chapterNumber,
                             @RequestParam("title") String title,
                             @RequestParam("content") String content,
                             @RequestParam("wordCount") Integer wordCount,
                             @RequestParam("isFree") Integer isFree,
                             @RequestParam("price") BigDecimal price,
                             @RequestParam("status") Integer status,
                             HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Chapter chapter = new Chapter();
        chapter.setBookId(bookId);
        chapter.setChapterNumber(chapterNumber);
        chapter.setTitle(title);
        chapter.setContent(content);
        chapter.setWordCount(wordCount > 0 ? wordCount : content.length());
        chapter.setIsFree(isFree);
        chapter.setPrice(price);
        chapter.setStatus(status);
        chapterService.save(chapter);
        
        Book book = bookService.findById(bookId);
        if (book != null) {
            book.setChapterCount(chapterService.countByBookId(bookId));
            bookService.update(book);
        }
        
        return "redirect:/admin/chapters?bookId=" + bookId;
    }

    @GetMapping("/chapters/edit/{id}")
    public String chapterEdit(@PathVariable("id") Integer id, Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Chapter chapter = chapterService.findById(id);
        List<Book> books = bookService.findByStatus(1);
        model.addAttribute("chapter", chapter);
        model.addAttribute("books", books);
        model.addAttribute("bookId", chapter.getBookId());
        return "admin-chapter-form";
    }

    @PostMapping("/chapters/update")
    public String chapterUpdate(@RequestParam("id") Integer id,
                               @RequestParam("bookId") Integer bookId,
                               @RequestParam("chapterNumber") Integer chapterNumber,
                               @RequestParam("title") String title,
                               @RequestParam("content") String content,
                               @RequestParam("wordCount") Integer wordCount,
                               @RequestParam("isFree") Integer isFree,
                               @RequestParam("price") BigDecimal price,
                               @RequestParam("status") Integer status,
                               HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Chapter chapter = chapterService.findById(id);
        chapter.setBookId(bookId);
        chapter.setChapterNumber(chapterNumber);
        chapter.setTitle(title);
        chapter.setContent(content);
        chapter.setWordCount(wordCount > 0 ? wordCount : content.length());
        chapter.setIsFree(isFree);
        chapter.setPrice(price);
        chapter.setStatus(status);
        chapterService.update(chapter);
        return "redirect:/admin/chapters?bookId=" + bookId;
    }

    @GetMapping("/chapters/delete/{id}")
    public String chapterDelete(@PathVariable("id") Integer id, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Chapter chapter = chapterService.findById(id);
        Integer bookId = chapter.getBookId();
        chapterService.delete(id);
        
        Book book = bookService.findById(bookId);
        if (book != null) {
            book.setChapterCount(chapterService.countByBookId(bookId));
            bookService.update(book);
        }
        
        return "redirect:/admin/chapters?bookId=" + bookId;
    }

    @GetMapping("/categories")
    public String categoryList(Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        return "admin-category-list";
    }

    @GetMapping("/categories/add")
    public String categoryAdd(HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        return "admin-category-form";
    }

    @PostMapping("/categories/save")
    public String categorySave(@RequestParam("name") String name,
                              @RequestParam("description") String description,
                              @RequestParam("sortOrder") Integer sortOrder,
                              @RequestParam("status") Integer status,
                              HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        category.setParentId(0);
        category.setSortOrder(sortOrder);
        category.setStatus(status);
        categoryService.save(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/edit/{id}")
    public String categoryEdit(@PathVariable("id") Integer id, Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Category category = categoryService.findById(id);
        model.addAttribute("category", category);
        return "admin-category-form";
    }

    @PostMapping("/categories/update")
    public String categoryUpdate(@RequestParam("id") Integer id,
                                @RequestParam("name") String name,
                                @RequestParam("description") String description,
                                @RequestParam("sortOrder") Integer sortOrder,
                                @RequestParam("status") Integer status,
                                HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Category category = categoryService.findById(id);
        category.setName(name);
        category.setDescription(description);
        category.setSortOrder(sortOrder);
        category.setStatus(status);
        categoryService.update(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/delete/{id}")
    public String categoryDelete(@PathVariable("id") Integer id, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        categoryService.delete(id);
        return "redirect:/admin/categories";
    }

    @GetMapping("/users")
    public String userList(Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<User> users = userService.findAll();
        model.addAttribute("users", users);
        return "admin-user-list";
    }

    @GetMapping("/users/add")
    public String userAdd(HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        return "admin-user-form";
    }

    @PostMapping("/users/save")
    public String userSave(@RequestParam("username") String username,
                          @RequestParam("password") String password,
                          @RequestParam("nickname") String nickname,
                          @RequestParam("email") String email,
                          @RequestParam("role") String role,
                          @RequestParam("status") Integer status,
                          HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (!"admin".equals(sessionRole)) {
            return "redirect:/login";
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setNickname(nickname);
        user.setEmail(email);
        user.setRole(role);
        user.setStatus(status);
        userService.register(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/edit/{id}")
    public String userEdit(@PathVariable("id") Integer id, Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        User user = userService.findById(id);
        model.addAttribute("user", user);
        return "admin-user-form";
    }

    @PostMapping("/users/update")
    public String userUpdate(@RequestParam("id") Integer id,
                            @RequestParam("username") String username,
                            @RequestParam("nickname") String nickname,
                            @RequestParam("email") String email,
                            @RequestParam(value = "phone", required = false) String phone,
                            @RequestParam("status") Integer status,
                            @RequestParam("role") String role,
                            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (!"admin".equals(sessionRole)) {
            return "redirect:/login";
        }
        User user = userService.findById(id);
        user.setUsername(username);
        user.setNickname(nickname);
        user.setEmail(email);
        if (phone != null) {
            user.setPhone(phone);
        }
        user.setStatus(status);
        user.setRole(role);
        userService.update(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/delete/{id}")
    public String userDelete(@PathVariable("id") Integer id, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        userService.delete(id);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/balance/{id}")
    public String userBalance(@PathVariable("id") Integer id, Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        User user = userService.findById(id);
        model.addAttribute("user", user);
        return "admin-user-balance";
    }

    @PostMapping("/users/balance/{id}/update")
    public String userBalanceUpdate(@PathVariable("id") Integer id,
                                   @RequestParam("balance") BigDecimal balance,
                                   Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        User user = userService.findById(id);
        user.setBalance(balance);
        userService.update(user);
        
        model.addAttribute("user", userService.findById(id));
        model.addAttribute("success", true);
        return "admin-user-balance";
    }

    @GetMapping("/comments")
    public String commentList(Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<Comment> comments = commentService.findAll();
        model.addAttribute("comments", comments);
        return "admin-comment-list";
    }

    @GetMapping("/comments/pending")
    public String commentPending(Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        List<Comment> comments = commentService.findByStatus(0);
        model.addAttribute("comments", comments);
        model.addAttribute("pending", true);
        return "admin-comment-list";
    }

    @GetMapping("/comments/approve/{id}")
    public String commentApprove(@PathVariable("id") Integer id, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        Comment comment = commentService.findById(id);
        comment.setStatus(1);
        commentService.update(comment);
        return "redirect:/admin/comments/pending";
    }

    @GetMapping("/comments/delete/{id}")
    public String commentDelete(@PathVariable("id") Integer id, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        commentService.delete(id);
        return "redirect:/admin/comments";
    }

    @GetMapping("/submissions")
    public String submissionList(@RequestParam(value = "tab", required = false, defaultValue = "book") String tab,
                                 @RequestParam(value = "status", required = false) Integer status,
                                 Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("bookCount", bookService.count());
        stats.put("chapterCount", chapterService.count());
        stats.put("userCount", userService.count());
        stats.put("commentCount", commentService.count());
        model.addAttribute("stats", stats);
        
        List<UserBookSubmission> bookSubmissions;
        List<UserChapterSubmission> chapterSubmissions;
        
        if (status != null) {
            bookSubmissions = submissionService.findByStatus(status);
            chapterSubmissions = chapterSubmissionService.findByStatus(status);
        } else {
            bookSubmissions = submissionService.findAll();
            chapterSubmissions = chapterSubmissionService.findAll();
        }
        
        model.addAttribute("bookSubmissions", bookSubmissions);
        model.addAttribute("chapterSubmissions", chapterSubmissions);
        
        return "admin";
    }

    @GetMapping("/approve-submission/{id}")
    public String approveSubmission(@PathVariable("id") Integer id, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        submissionService.approve(id);
        return "redirect:/admin/submissions?tab=book&status=0";
    }

    @GetMapping("/reject-submission/{id}")
    public String rejectSubmission(@PathVariable("id") Integer id,
                                  @RequestParam(value = "reason", required = false) String reason,
                                  HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        submissionService.reject(id, reason);
        return "redirect:/admin/submissions?tab=book&status=0";
    }

    @GetMapping("/chapter-submissions")
    public String chapterSubmissionList(@RequestParam(value = "status", required = false) Integer status,
                                       Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        
        List<UserBookSubmission> bookSubmissions;
        List<UserChapterSubmission> chapterSubmissions;
        
        if (status != null) {
            bookSubmissions = submissionService.findByStatus(status);
            chapterSubmissions = chapterSubmissionService.findByStatus(status);
            model.addAttribute("bookStatus", String.valueOf(status));
            model.addAttribute("chapterStatus", String.valueOf(status));
        } else {
            bookSubmissions = submissionService.findAll();
            chapterSubmissions = chapterSubmissionService.findAll();
        }
        
        model.addAttribute("bookSubmissions", bookSubmissions);
        model.addAttribute("chapterSubmissions", chapterSubmissions);
        
        return "admin";
    }

    @GetMapping("/approve-chapter-submission/{id}")
    public String approveChapterSubmission(@PathVariable("id") Integer id, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        chapterSubmissionService.approve(id);
        return "redirect:/admin/submissions?tab=chapter&status=0";
    }

    @GetMapping("/reject-chapter-submission/{id}")
    public String rejectChapterSubmission(@PathVariable("id") Integer id,
                                         @RequestParam(value = "reason", required = false) String reason,
                                         HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            return "redirect:/login";
        }
        chapterSubmissionService.reject(id, reason);
        return "redirect:/admin/submissions?tab=chapter&status=0";
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