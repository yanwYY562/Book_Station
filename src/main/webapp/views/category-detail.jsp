<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${category.name} - 悦读书城</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f8f9fa; }
        header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header-content { width: 90%; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav { display: flex; gap: 20px; }
        .nav a { color: white; text-decoration: none; }
        .search-box { display: flex; gap: 10px; }
        .search-input { padding: 8px 15px; border: none; border-radius: 20px; width: 250px; }
        .search-btn { padding: 8px 20px; background: white; color: #667eea; border: none; border-radius: 20px; cursor: pointer; }
        .user-links { display: flex; gap: 15px; }
        .user-links a { color: white; text-decoration: none; }

        .container { width: 90%; margin: 0 auto; padding: 30px 0; }
        .category-header { margin-bottom: 30px; padding: 20px; background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .category-header h1 { color: #333; font-size: 28px; margin-bottom: 10px; }
        .category-header p { color: #666; }

        .book-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 25px; }
        .book-card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 15px rgba(0,0,0,0.08); transition: transform 0.3s; }
        .book-card:hover { transform: translateY(-5px); }
        .book-cover { height: 300px; background: linear-gradient(135deg, #e0e0e0 0%, #f5f5f5 100%); display: flex; align-items: center; justify-content: center; position: relative; overflow: hidden; }
        .book-cover img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; }
        .book-info { padding: 15px; }
        .book-title { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; }
        .book-author { color: #666; font-size: 14px; margin-bottom: 10px; }
        .book-meta { display: flex; justify-content: space-between; align-items: center; }
        .book-price { color: #e74c3c; font-weight: bold; }
        .book-tag { background: #e8f5e9; color: #2e7d32; padding: 3px 8px; border-radius: 5px; font-size: 12px; }
        .read-btn { display: block; text-align: center; padding: 10px; background: #667eea; color: white; text-decoration: none; margin-top: 10px; border-radius: 5px; }

        .empty { text-align: center; padding: 50px; color: #999; }
        .empty-icon { font-size: 64px; margin-bottom: 20px; }

        footer { background: #333; color: white; padding: 30px 0; text-align: center; margin-top: 40px; }
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <a href="/" class="logo">📚 悦读书城</a>
            <div class="nav">
                <a href="/">首页</a>
                <a href="/categories">分类</a>
                <a href="/books">图书</a>
            </div>
            <form action="/search" method="get" class="search-box">
                <input type="text" name="keyword" class="search-input" placeholder="搜索书名、作者...">
                <button type="submit" class="search-btn">搜索</button>
            </form>
            <div class="user-links">
                <c:if test="${sessionScope.username == null}">
                    <a href="/login">登录</a>
                    <a href="/register">注册</a>
                </c:if>
                <c:if test="${sessionScope.username != null}">
                    <a href="/user/profile">${sessionScope.nickname}</a>
                    <a href="/logout">退出</a>
                    <c:if test="${sessionScope.role == 'admin'}">
                        <a href="/admin">管理后台</a>
                    </c:if>
                </c:if>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="category-header">
            <h1>📖 ${category.name}</h1>
            <c:if test="${category.description != null}">
                <p>${category.description}</p>
            </c:if>
            <p style="margin-top: 10px; color: #999;">共找到 ${books.size()} 本相关图书</p>
        </div>

        <c:if test="${books.size() > 0}">
            <div class="book-grid">
                <c:forEach items="${books}" var="book">
                    <div class="book-card">
                        <div class="book-cover">
                            <c:choose>
                                <c:when test="${not empty book.coverImage}">
                                    <img src="${book.coverImage}" alt="${book.title}" onerror="this.parentElement.innerHTML='<span style=font-size:48px;>📖</span>'">
                                </c:when>
                                <c:otherwise>
                                    <span style="font-size:48px;">📖</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="book-info">
                            <div class="book-title">${book.title}</div>
                            <div class="book-author">${book.author}</div>
                            <div class="book-meta">
                                <span class="book-price"><c:if test="${book.isFree == 1}">免费</c:if><c:if test="${book.isFree != 1}">¥${book.price}</c:if></span>
                                <span class="book-tag">${book.categoryName}</span>
                            </div>
                            <a href="/books/${book.id}" class="read-btn">查看详情</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${books.size() == 0}">
            <div class="empty">
                <div class="empty-icon">📚</div>
                <p>该分类下暂无图书</p>
            </div>
        </c:if>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>
</body>
</html>