<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书分类 - 悦读书城</title>
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

        .container { width: 90%; margin: 0 auto; padding: 40px 0; }
        .page-header { text-align: center; margin-bottom: 40px; }
        .page-header h1 { color: #333; font-size: 32px; margin-bottom: 10px; }
        .page-header p { color: #666; }

        .category-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); gap: 20px; }
        .category-card { 
            background: white; 
            border-radius: 15px; 
            padding: 30px 20px; 
            text-align: center; 
            box-shadow: 0 2px 15px rgba(0,0,0,0.08); 
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .category-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.2);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .category-card:hover .category-icon { transform: scale(1.2); }
        .category-card:hover .category-name { color: white; }
        .category-icon { font-size: 48px; margin-bottom: 15px; transition: transform 0.3s; }
        .category-name { font-size: 18px; font-weight: bold; color: #333; transition: color 0.3s; }
        .category-link { text-decoration: none; }

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
        <div class="page-header">
            <h1>📖 图书分类</h1>
            <p>选择分类，探索更多精彩图书</p>
        </div>

        <div class="category-grid">
            <c:forEach items="${categories}" var="category">
                <a href="/categories/${category.id}" class="category-link">
                    <div class="category-card">
                        <div class="category-icon">📚</div>
                        <div class="category-name">${category.name}</div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>
</body>
</html>