<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>阅读记录 - 悦读书城</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f8f9fa; }
        header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header-content { width: 90%; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav { display: flex; gap: 20px; }
        .nav a { color: white; text-decoration: none; }
        .user-links { display: flex; gap: 15px; }
        .user-links a { color: white; text-decoration: none; }

        .container { width: 90%; margin: 0 auto; padding: 30px 0; }
        .user-center { display: flex; gap: 30px; }
        .sidebar { width: 250px; background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .avatar-section { text-align: center; margin-bottom: 20px; }
        .avatar { width: 100px; height: 100px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 40px; margin: 0 auto; }
        .username { font-size: 18px; font-weight: bold; margin-top: 10px; }
        .user-menu { list-style: none; }
        .user-menu li { margin-bottom: 10px; }
        .user-menu a { display: block; padding: 12px; border-radius: 5px; text-decoration: none; color: #333; transition: background 0.3s; }
        .user-menu a:hover, .user-menu a.active { background: #e8f5e9; color: #2e7d32; }

        .main-content { flex: 1; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .page-title { font-size: 24px; font-weight: bold; margin-bottom: 30px; color: #333; }

        .history-list { list-style: none; }
        .history-item { display: flex; gap: 20px; padding: 20px; border-bottom: 1px solid #eee; align-items: center; }
        .history-item:last-child { border-bottom: none; }
        .history-item:hover { background: #f8f9fa; }
        .book-cover-small { width: 80px; height: 100px; background: linear-gradient(135deg, #e0e0e0 0%, #f5f5f5 100%); border-radius: 5px; overflow: hidden; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .book-cover-small img { width: 100%; height: 100%; object-fit: cover; }
        .book-info { flex: 1; }
        .book-title { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; }
        .book-author { color: #666; font-size: 14px; margin-bottom: 10px; }
        .reading-info { display: flex; gap: 20px; font-size: 13px; color: #999; }
        .chapter-info { color: #667eea; }
        .progress-bar { width: 200px; height: 8px; background: #eee; border-radius: 4px; overflow: hidden; margin-top: 10px; }
        .progress-fill { height: 100%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 4px; }

        .continue-btn { padding: 10px 20px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; font-size: 14px; }
        .continue-btn:hover { background: #5a6fd6; }

        .empty { text-align: center; padding: 60px; color: #999; }
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
            <div class="user-links">
                <a href="/user/profile">${sessionScope.nickname}</a>
                <a href="/logout">退出</a>
                <c:if test="${sessionScope.role == 'admin'}">
                    <a href="/admin">管理后台</a>
                </c:if>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="user-center">
            <div class="sidebar">
                <div class="avatar-section">
                    <div class="avatar">👤</div>
                    <div class="username">${sessionScope.nickname}</div>
                </div>
                <ul class="user-menu">
                    <li><a href="/user/profile">👤 个人资料</a></li>
                    <li><a href="/user/my-books">📚 我的作品</a></li>
                    <li><a href="/user/submit-book">📤 上传图书</a></li>
                    <li><a href="/user/submit-chapter">📝 上传章节</a></li>
                    <li><a href="/user/recharge">💰 账户充值</a></li>
                    <li><a href="/user/favorites">❤️ 我的收藏</a></li>
                    <li><a href="/user/reading-history" class="active">📖 阅读记录</a></li>
                    <li><a href="/user/comments">💬 我的评论</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="page-title">📖 阅读记录</div>
                
                <c:choose>
                    <c:when test="${not empty records}">
                    <ul class="history-list">
                        <c:forEach items="${records}" var="record">
                            <li class="history-item">
                                <div class="book-cover-small">
                                    <c:choose>
                                        <c:when test="${not empty record.bookCoverImage}">
                                            <img src="${record.bookCoverImage}" alt="${record.bookTitle}" onerror="this.parentElement.innerHTML='<span style=font-size:24px;>📖</span>'">
                                        </c:when>
                                        <c:otherwise>
                                            <span style="font-size:24px;">📖</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="book-info">
                                    <div class="book-title">${record.bookTitle}</div>
                                    <div class="book-author">${record.bookAuthor}</div>
                                    <div class="reading-info">
                                        <span class="chapter-info">📑 ${record.chapterTitle}</span>
                                        <span>⏰ <fmt:formatDate value="${record.lastReadTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </div>
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: ${record.readProgress}%"></div>
                                    </div>
                                    <div style="margin-top: 10px; color: #999; font-size: 13px;">阅读进度：${record.readProgress}%</div>
                                </div>
                                <a href="/books/read/${record.bookId}/${record.chapterId}" class="continue-btn">继续阅读</a>
                            </li>
                        </c:forEach>
                    </ul>
                    </c:when>
                    <c:otherwise>
                    <div class="empty">
                        <div class="empty-icon">📖</div>
                        <p>还没有阅读记录</p>
                        <p>去首页找一本好书开始阅读吧！</p>
                    </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>
</body>
</html>