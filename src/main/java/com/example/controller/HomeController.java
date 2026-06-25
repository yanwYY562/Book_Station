package com.example.controller;

import com.example.entity.Book;
import com.example.entity.Category;
import com.example.service.BookService;
import com.example.service.CategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class HomeController {

    @Resource
    private BookService bookService;

    @Resource
    private CategoryService categoryService;

    @GetMapping("/")
    public String index(Model model) {
        List<Book> hotBooks = bookService.findTopViewed(6);
        List<Book> popularBooks = bookService.findTopFavorited(6);
        List<Book> freeBooks = bookService.findByIsFree(1);
        List<Category> categories = categoryService.findByStatus(1);

        model.addAttribute("hotBooks", hotBooks);
        model.addAttribute("popularBooks", popularBooks);
        model.addAttribute("freeBooks", freeBooks);
        model.addAttribute("categories", categories);

        return "index";
    }

    @GetMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Model model) {
        List<Book> books = bookService.search(keyword);
        model.addAttribute("books", books);
        model.addAttribute("keyword", keyword);
        return "search-result";
    }
}