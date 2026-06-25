package com.example.controller;

import com.example.entity.Book;
import com.example.entity.Category;
import com.example.service.BookService;
import com.example.service.CategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class CategoryController {

    @Resource
    private CategoryService categoryService;

    @Resource
    private BookService bookService;

    @GetMapping("/categories")
    public String list(Model model) {
        List<Category> categories = categoryService.findByStatus(1);
        model.addAttribute("categories", categories);
        return "category-list";
    }

    @GetMapping("/categories/{id}")
    public String booksByCategory(@PathVariable("id") Integer id, Model model) {
        Category category = categoryService.findById(id);
        List<Book> books = bookService.findByCategoryId(id);
        
        model.addAttribute("category", category);
        model.addAttribute("books", books);
        return "category-detail";
    }
}