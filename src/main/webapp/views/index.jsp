<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>在线图书阅读书城</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f8f9fa; }
        header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 100; }
        .header-content { width: 90%; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav { display: flex; gap: 20px; align-items: center; }
        .nav a { color: white; text-decoration: none; }
        .search-box { display: flex; gap: 10px; }
        .search-input { padding: 8px 15px; border: none; border-radius: 20px; width: 250px; }
        .search-btn { padding: 8px 20px; background: white; color: #667eea; border: none; border-radius: 20px; cursor: pointer; }
        .user-links { display: flex; gap: 15px; }
        .user-links a { color: white; text-decoration: none; }

        .hero { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 60px 0; text-align: center; color: white; }
        .hero h1 { font-size: 48px; margin-bottom: 20px; }
        .hero p { font-size: 18px; margin-bottom: 30px; }
        .hero-search { display: flex; justify-content: center; gap: 10px; }
        .hero-search input { padding: 12px 20px; width: 400px; border: none; border-radius: 30px; font-size: 16px; }
        .hero-search button { padding: 12px 30px; background: #f093fb; color: white; border: none; border-radius: 30px; cursor: pointer; font-size: 16px; }

        .container { width: 90%; margin: 0 auto; }

        /* 通用区块hover下拉展开样式 */
        .section-wrapper { position: relative; overflow: visible; }
        .section { padding: 40px 0; }
        .section-title-wrapper { 
            text-align: center; 
            margin-bottom: 0; 
            padding: 30px 0; 
            cursor: pointer; 
            transition: all 0.3s ease;
            position: relative;
            z-index: 10;
        }
        .section-title-wrapper:hover { background: rgba(102, 126, 234, 0.05); }
        .section-title { 
            font-size: 28px; 
            color: #333; 
            display: inline-block; 
            padding: 15px 40px;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        .section-title-wrapper:hover .section-title {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        .section-title::after {
            content: ' ▼';
            font-size: 12px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .section-title-wrapper:hover .section-title::after {
            opacity: 1;
        }

        /* 下拉展开内容区域 */
        .section-content {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.5s ease-out, opacity 0.3s ease;
            opacity: 0;
        }
        .section-title-wrapper:hover ~ .section-content {
            max-height: 2000px;
            opacity: 1;
        }
        /* 修复hover状态：当wrapper或content被hover时保持展开 */
        .section-wrapper:hover .section-content {
            max-height: 2000px;
            opacity: 1;
        }

        /* 图书网格 */
        .book-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); 
            gap: 25px;
            padding: 20px 0;
        }
        .book-card { 
            background: white; 
            border-radius: 10px; 
            overflow: hidden; 
            box-shadow: 0 2px 15px rgba(0,0,0,0.08); 
            transition: transform 0.3s, box-shadow 0.3s; 
        }
        .book-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .book-cover { 
            height: 300px; 
            background: linear-gradient(135deg, #e0e0e0 0%, #f5f5f5 100%); 
            display: flex; 
            align-items: center; 
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        .book-cover img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s; }
        .book-card:hover .book-cover img { transform: scale(1.05); }
        .book-info { padding: 15px; }
        .book-title { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; }
        .book-author { color: #666; font-size: 14px; margin-bottom: 10px; }
        .book-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
        .book-price { color: #e74c3c; font-weight: bold; }
        .book-tag { background: #e8f5e9; color: #2e7d32; padding: 3px 8px; border-radius: 5px; font-size: 12px; }
        .read-btn { 
            display: block; 
            text-align: center; 
            padding: 10px; 
            background: #667eea; 
            color: white; 
            text-decoration: none; 
            border-radius: 5px; 
            transition: background 0.3s;
        }
        .read-btn:hover { background: #5568d3; }

        /* 分类区块特殊样式 */
        .category-wrapper { background: white; }
        .category-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); 
            gap: 15px;
        }
        .category-item { 
            text-align: center; 
            padding: 20px 10px; 
            border-radius: 10px; 
            background: #f8f9fa; 
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        .category-item:hover { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        .category-item:hover a { color: white; }
        .category-item:hover .category-icon { transform: scale(1.2); }
        .category-item a { 
            text-decoration: none; 
            color: #333; 
            font-weight: 500;
            transition: color 0.3s;
        }
        .category-icon { 
            font-size: 32px; 
            margin-bottom: 10px; 
            transition: transform 0.3s;
        }

        footer { background: #333; color: white; padding: 30px 0; text-align: center; margin-top: 40px; }

        /* 动画效果 */
        .book-card {
            animation: fadeInUp 0.6s ease-out;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .book-grid .book-card:nth-child(1) { animation-delay: 0.1s; }
        .book-grid .book-card:nth-child(2) { animation-delay: 0.2s; }
        .book-grid .book-card:nth-child(3) { animation-delay: 0.3s; }
        .book-grid .book-card:nth-child(4) { animation-delay: 0.4s; }
        .book-grid .book-card:nth-child(5) { animation-delay: 0.5s; }
        .book-grid .book-card:nth-child(6) { animation-delay: 0.6s; }
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

    <div class="hero">
        <h1>发现你的下一本好书</h1>
        <p>海量图书，畅快阅读</p>
        <form action="/search" method="get" class="hero-search">
            <input type="text" name="keyword" placeholder="搜索你想读的书...">
            <button type="submit">开始探索</button>
        </form>
    </div>

    <!-- 图书分类区块 -->
    <div class="section-wrapper category-wrapper">
        <div class="section-title-wrapper">
            <h2 class="section-title">📖 图书分类</h2>
        </div>
        <div class="section-content">
            <div class="container">
                <div class="category-grid">
                    <c:forEach items="${categories}" var="category">
                        <div class="category-item">
                            <div class="category-icon">📚</div>
                            <a href="/categories/${category.id}">${category.name}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <!-- 热门推荐区块 -->
    <div class="section-wrapper">
        <div class="section-title-wrapper">
            <h2 class="section-title">🔥 热门推荐</h2>
        </div>
        <div class="section-content">
            <div class="container">
                <div class="book-grid">
                    <c:forEach items="${hotBooks}" var="book">
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
                                <a href="/books/${book.id}" class="read-btn">立即阅读</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <!-- 人气精选区块 -->
    <div class="section-wrapper">
        <div class="section-title-wrapper">
            <h2 class="section-title">⭐ 人气精选</h2>
        </div>
        <div class="section-content">
            <div class="container">
                <div class="book-grid">
                    <c:forEach items="${popularBooks}" var="book">
                        <div class="book-card">
                            <div class="book-cover">
                                <c:choose>
                                    <c:when test="${not empty book.coverImage}">
                                        <img src="${book.coverImage}" alt="${book.title}" onerror="this.parentElement.innerHTML='<span style=font-size:48px;>📚</span>'">
                                    </c:when>
                                    <c:otherwise>
                                        <span style="font-size:48px;">📚</span>
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
                                <a href="/books/${book.id}" class="read-btn">立即阅读</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <!-- 免费好书区块 -->
    <div class="section-wrapper">
        <div class="section-title-wrapper">
            <h2 class="section-title">🎁 免费好书</h2>
        </div>
        <div class="section-content">
            <div class="container">
                <div class="book-grid">
                    <c:forEach items="${freeBooks}" var="book">
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
                                    <span class="book-price" style="color:#2e7d32;">免费</span>
                                    <span class="book-tag">${book.categoryName}</span>
                                </div>
                                <a href="/books/${book.id}" class="read-btn">立即阅读</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>
</body>
</html>