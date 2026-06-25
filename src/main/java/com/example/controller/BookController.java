package com.example.controller;

import com.example.entity.Book;
import com.example.entity.Category;
import com.example.entity.Chapter;
import com.example.entity.Comment;
import com.example.entity.PurchaseRecord;
import com.example.entity.User;
import com.example.service.BookService;
import com.example.service.CategoryService;
import com.example.service.ChapterService;
import com.example.service.CommentService;
import com.example.service.FavoriteService;
import com.example.service.PurchaseRecordService;
import com.example.service.ReadingRecordService;
import com.example.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BookController {

    @Resource
    private BookService bookService;

    @Resource
    private ChapterService chapterService;

    @Resource
    private CommentService commentService;

    @Resource
    private CategoryService categoryService;

    @Resource
    private ReadingRecordService readingRecordService;

    @Resource
    private FavoriteService favoriteService;

    @Resource
    private UserService userService;

    @Resource
    private PurchaseRecordService purchaseRecordService;

    @GetMapping("/books")
    public String list(@RequestParam(value = "category", required = false) Integer category,
                      @RequestParam(value = "status", required = false) Integer status,
                      @RequestParam(value = "free", required = false) Integer free,
                      Model model) {
        List<Book> books;
        if (category != null || status != null || free != null) {
            books = bookService.findFiltered(category, status, free);
        } else {
            books = bookService.findAll();
        }
        List<Category> categories = categoryService.findByStatus(1);
        model.addAttribute("books", books);
        model.addAttribute("categories", categories);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedFree", free);
        return "books";
    }

    @GetMapping("/books/{id}")
    public String detail(@PathVariable("id") Integer id,
                        @RequestParam(value = "from", required = false) String from,
                        @RequestParam(value = "error", required = false) String error,
                        @RequestParam(value = "success", required = false) String success,
                        Model model, HttpSession session) {
        Book book = bookService.findById(id);

        Integer userId = (Integer) session.getAttribute("userId");
        
        // 阅读量在阅读页面统一处理，详情页不再增加
        
        boolean isAuthor = userId != null && book.getAuthorId() != null && book.getAuthorId().equals(userId);
        
        // 作者可以看到所有章节（包括待审核），其他用户只能看到已审核通过的章节
        List<Chapter> chapters;
        if (isAuthor) {
            chapters = chapterService.findByBookIdAllStatus(id);
        } else {
            chapters = chapterService.findByBookId(id);
        }
        
        List<Comment> comments = commentService.findByBookId(id);
        int commentCount = commentService.countByBookId(id);

        model.addAttribute("book", book);
        model.addAttribute("chapters", chapters);
        model.addAttribute("comments", comments);
        model.addAttribute("commentCount", commentCount);

        model.addAttribute("userId", userId);

        boolean isFavorited = false;
        boolean hasPurchased = false;
        Double userBalance = 0.0;
        if (userId != null) {
            isFavorited = favoriteService.exists(userId, id);
            hasPurchased = purchaseRecordService.existsByUserIdAndBookId(userId, id);
            User user = userService.findById(userId);
            userBalance = user.getBalance() != null ? user.getBalance().doubleValue() : 0.0;
        }
        model.addAttribute("isFavorited", isFavorited);
        model.addAttribute("hasPurchased", hasPurchased);
        model.addAttribute("isAuthor", isAuthor);
        model.addAttribute("userBalance", userBalance);

        return "book-detail";
    }

    @GetMapping("/books/read/{bookId}/{chapterId}")
    public String read(@PathVariable("bookId") Integer bookId,
                       @PathVariable("chapterId") Integer chapterId,
                       Model model, HttpSession session) {
        Book book = bookService.findById(bookId);
        Chapter chapter = chapterService.findById(chapterId);

        Integer userId = (Integer) session.getAttribute("userId");

        // 检查是否是作者
        boolean isAuthor = userId != null && book.getAuthorId() != null && book.getAuthorId().equals(userId);

        // 检查是否可以阅读此章节
        if (!isAuthor && book.getIsFree() != 1 && chapter.getIsFree() != 1) {
            // 图书和章节都需要购买，且用户不是作者
            if (userId == null || !purchaseRecordService.existsByUserIdAndBookId(userId, bookId)) {
                // 未登录或未购买，重定向到图书详情页
                return "redirect:/books/" + bookId + "?error=not_purchased";
            }
        }

        Chapter nextChapter = chapterService.findNextChapter(bookId, chapter.getChapterNumber());
        Chapter prevChapter = chapterService.findPreviousChapter(bookId, chapter.getChapterNumber());
        List<Chapter> chapters = chapterService.findByBookId(bookId);

        model.addAttribute("book", book);
        model.addAttribute("chapter", chapter);
        model.addAttribute("nextChapter", nextChapter);
        model.addAttribute("prevChapter", prevChapter);
        model.addAttribute("chapters", chapters);

        if (userId != null) {
            model.addAttribute("userId", userId);
            readingRecordService.saveOrUpdate(userId, bookId, chapterId, 0);
        }

        return "reader";
    }

    @GetMapping("/books/purchase/{bookId}")
    public String purchase(@PathVariable("bookId") Integer bookId, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login?redirect=/books/" + bookId;
        }

        User user = userService.findById(userId);
        Book book = bookService.findById(bookId);

        // 免费图书直接阅读
        if (book.getIsFree() == 1) {
            return "redirect:/books/read/" + bookId;
        }

        // 检查是否已经购买
        if (purchaseRecordService.existsByUserIdAndBookId(userId, bookId)) {
            return "redirect:/books/read/" + bookId;
        }

        // 检查余额是否足够
        if (user.getBalance() == null || user.getBalance().compareTo(book.getPrice()) < 0) {
            return "redirect:/books/" + bookId + "?error=insufficient";
        }

        // 扣除余额并保存购买记录
        user.setBalance(user.getBalance().subtract(book.getPrice()));
        userService.update(user);

        // 保存购买记录
        PurchaseRecord record = new PurchaseRecord();
        record.setUserId(userId);
        record.setBookId(bookId);
        record.setPrice(book.getPrice());
        purchaseRecordService.save(record);

        return "redirect:/books/" + bookId + "?success=purchased";
    }

    @GetMapping("/books/read/{bookId}")
    public String readFirstChapter(@PathVariable("bookId") Integer bookId, HttpSession session) {
        Book book = bookService.findById(bookId);
        Integer userId = (Integer) session.getAttribute("userId");

        // 检查是否是作者
        boolean isAuthor = userId != null && book.getAuthorId() != null && book.getAuthorId().equals(userId);

        // 检查是否可以阅读
        if (book.getIsFree() != 1) {
            // 付费图书
            if (userId == null) {
                return "redirect:/login?redirect=/books/" + bookId;
            }
            // 作者可以免费阅读，不需要购买
            if (!isAuthor && !purchaseRecordService.existsByUserIdAndBookId(userId, bookId)) {
                return "redirect:/books/" + bookId + "?error=not_purchased";
            }
        }

        // 阅读量只在第一次进入阅读页面时增加一次
        String readBooksKey = userId != null ? "READ_BOOKS_" + userId : "READ_BOOKS_GUEST";
        @SuppressWarnings("unchecked")
        java.util.Set<Integer> readBooks = (java.util.Set<Integer>) session.getAttribute(readBooksKey);
        
        if (readBooks == null) {
            readBooks = new java.util.HashSet<>();
        }
        
        if (!readBooks.contains(bookId)) {
            readBooks.add(bookId);
            session.setAttribute(readBooksKey, readBooks);
            bookService.incrementViewCount(bookId);
        }

        // 作者可以阅读所有状态的章节，其他用户只能阅读已审核通过的章节
        Chapter firstChapter;
        if (isAuthor) {
            firstChapter = chapterService.findFirstByBookIdAllStatus(bookId);
        } else {
            firstChapter = chapterService.findFirstByBookId(bookId);
        }
        
        if (firstChapter != null) {
            return "redirect:/books/read/" + bookId + "/" + firstChapter.getId();
        }
        return "redirect:/books/" + bookId;
    }
}