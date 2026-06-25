<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的收藏 - 悦读书城</title>
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

        .book-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; }
        .book-card { background: #f8f9fa; border-radius: 10px; overflow: hidden; }
        .book-cover { height: 250px; background: linear-gradient(135deg, #e0e0e0 0%, #f5f5f5 100%); display: flex; align-items: center; justify-content: center; position: relative; overflow: hidden; }
        .book-cover img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; }
        .book-info { padding: 15px; }
        .book-title { font-size: 14px; font-weight: bold; color: #333; margin-bottom: 5px; }
        .book-author { color: #666; font-size: 12px; margin-bottom: 10px; }
        .book-price { color: #e74c3c; font-weight: bold; }
        .book-actions { display: flex; gap: 10px; margin-top: 10px; }
        .action-btn { flex: 1; padding: 8px; text-align: center; border-radius: 5px; text-decoration: none; font-size: 13px; }
        .action-btn.read { background: #667eea; color: white; }
        .action-btn.remove { background: #f5f5f5; color: #e74c3c; border: 1px solid #e74c3c; }

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
                    <li><a href="/user/favorites" class="active">❤️ 我的收藏</a></li>
                    <li><a href="/user/reading-history">📖 阅读记录</a></li>
                    <li><a href="/user/comments">💬 我的评论</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="page-title">❤️ 我的收藏</div>
                
                <c:choose>
                    <c:when test="${not empty favorites}">
                    <div class="book-list">
                        <c:forEach items="${favorites}" var="favorite">
                            <div class="book-card">
                                <div class="book-cover">
                                    <c:choose>
                                        <c:when test="${not empty favorite.bookCoverImage}">
                                            <img src="${favorite.bookCoverImage}" alt="${favorite.bookTitle}" onerror="this.parentElement.innerHTML='<span style=font-size:40px;>📖</span>'">
                                        </c:when>
                                        <c:otherwise>
                                            <span style="font-size:40px;">📖</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="book-info">
                                    <div class="book-title">${favorite.bookTitle}</div>
                                    <div class="book-author">${favorite.bookAuthor}</div>
                                    <div class="book-price"><c:if test="${favorite.bookIsFree == 1}">免费</c:if><c:if test="${favorite.bookIsFree != 1}">¥${favorite.bookPrice}</c:if></div>
                                    <div class="book-actions">
                                        <a href="/books/read/${favorite.bookId}" class="action-btn read">立即阅读</a>
                                        <a href="/user/toggle-favorite/${favorite.bookId}" class="action-btn remove">取消收藏</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    </c:when>
                    <c:otherwise>
                    <div class="empty">
                        <div class="empty-icon">📚</div>
                        <p>还没有收藏任何图书</p>
                        <p>去首页看看有什么好书吧！</p>
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