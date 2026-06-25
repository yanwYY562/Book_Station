<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>图书管理 - 悦读书城管理后台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f8f9fa; }
        header { background: #2c3e50; padding: 15px 0; color: white; }
        .header-content { width: 90%; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; text-decoration: none; }

        .container { display: flex; }
        .sidebar { width: 220px; background: #34495e; min-height: calc(100vh - 65px); padding: 20px; }
        .sidebar-menu { list-style: none; }
        .sidebar-menu li { margin-bottom: 10px; }
        .sidebar-menu a { display: block; padding: 12px 15px; color: white; text-decoration: none; border-radius: 5px; transition: background 0.3s; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: #2c3e50; }
        .menu-icon { margin-right: 10px; }

        .main-content { flex: 1; padding: 30px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .page-title { font-size: 24px; font-weight: bold; color: #333; }
        .add-btn { padding: 10px 20px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; }

        .search-bar { display: flex; gap: 15px; margin-bottom: 20px; }
        .search-input { padding: 10px 15px; border: 1px solid #ddd; border-radius: 5px; width: 300px; }
        .search-btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }

        .table-container { background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); overflow: hidden; }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        .data-table th { background: #f8f9fa; font-weight: bold; color: #333; }
        .data-table tr:hover { background: #f8f9fa; }

        .action-links { display: flex; gap: 10px; }
        .action-link { padding: 5px 12px; text-decoration: none; border-radius: 4px; font-size: 13px; }
        .action-link.edit { background: #3498db; color: white; }
        .action-link.delete { background: #e74c3c; color: white; }
        .action-link.chapters { background: #9b59b6; color: white; }

        .status-badge { padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .status-published { background: #d4edda; color: #155724; }
        .status-draft { background: #fff3cd; color: #856404; }
        .status-completed { background: #d1ecf1; color: #0c5460; }

        .price-free { color: #2e7d32; font-weight: bold; }
        .price-paid { color: #e74c3c; font-weight: bold; }

        footer { background: #333; color: white; padding: 20px 0; text-align: center; margin-top: 40px; }
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <div class="logo">🔧 悦读书城管理后台</div>
            <div class="nav-links">
                <a href="/">返回首页</a>
                <a href="/logout">退出登录</a>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="/admin"><span class="menu-icon">📊</span> 控制台</a></li>
                <li><a href="/admin?tab=review"><span class="menu-icon">✅</span> 内容审核</a></li>
                <li><a href="/admin/books" class="active"><span class="menu-icon">📚</span> 图书管理</a></li>
                <li><a href="/admin/chapters"><span class="menu-icon">📑</span> 章节管理</a></li>
                <li><a href="/admin/categories"><span class="menu-icon">📁</span> 分类管理</a></li>
                <li><a href="/admin/users"><span class="menu-icon">👥</span> 用户管理</a></li>
                <li><a href="/admin/comments"><span class="menu-icon">💬</span> 评论管理</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">📚 图书管理</h1>
                <a href="/admin/books/add" class="add-btn">+ 添加图书</a>
            </div>

            <div class="search-bar">
                <form action="/admin/books/search" method="get">
                    <input type="text" name="keyword" class="search-input" placeholder="搜索书名、作者..." value="${keyword}">
                    <button type="submit" class="search-btn">搜索</button>
                </form>
            </div>

            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>封面</th>
                            <th>书名</th>
                            <th>作者</th>
                            <th>分类</th>
                            <th>价格</th>
                            <th>状态</th>
                            <th>阅读量</th>
                            <th>收藏量</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${books}" var="book">
                            <tr>
                                <td>${book.id}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty book.coverImage}">
                                            <img src="${book.coverImage}" alt="${book.title}" style="width: 50px; height: 65px; object-fit: cover;" onerror="this.parentElement.innerHTML='📖'">
                                        </c:when>
                                        <c:otherwise>
                                            📖
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${book.title}</td>
                                <td>${book.author}</td>
                                <td>${book.categoryName}</td>
                                <td>
                                    <span class="${book.isFree == 1 ? 'price-free' : 'price-paid'}">
                                        <c:if test="${book.isFree == 1}">免费</c:if><c:if test="${book.isFree != 1}">¥${book.price}</c:if>
                                    </span>
                                </td>
                                <td>
                                    <span class="status-badge ${book.status == 1 ? 'status-published' : (book.status == 2 ? 'status-completed' : 'status-draft')}">
                                        ${book.status == 1 ? '连载中' : (book.status == 2 ? '已完结' : '草稿')}
                                    </span>
                                </td>
                                <td>${book.viewCount}</td>
                                <td>${book.favoriteCount}</td>
                                <td>
                                    <div class="action-links">
                                        <a href="/admin/chapters?bookId=${book.id}" class="action-link chapters">章节</a>
                                        <a href="/admin/books/edit/${book.id}" class="action-link edit">编辑</a>
                                        <a href="/admin/books/delete/${book.id}" class="action-link delete" onclick="return confirm('确定删除该图书吗？')">删除</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城管理后台</p>
    </footer>
</body>
</html>