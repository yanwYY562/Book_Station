<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的评论 - 悦读书城</title>
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

        .comment-list { max-width: 800px; }
        .comment-card { background: #f8f9fa; border-radius: 10px; padding: 20px; margin-bottom: 20px; }
        .comment-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .book-info { display: flex; align-items: center; gap: 15px; }
        .book-cover-small { width: 50px; height: 65px; background: #eee; border-radius: 5px; display: flex; align-items: center; justify-content: center; }
        .book-cover-small img { width: 100%; height: 100%; object-fit: cover; border-radius: 5px; }
        .book-title-link { font-weight: bold; color: #333; text-decoration: none; }
        .book-title-link:hover { color: #667eea; }
        .rating { color: #ffc107; font-size: 14px; }
        .comment-content { color: #666; line-height: 1.8; margin-bottom: 15px; }
        .comment-footer { display: flex; justify-content: space-between; align-items: center; }
        .comment-time { font-size: 12px; color: #999; }
        .delete-btn { padding: 6px 12px; background: #fff; color: #e74c3c; border: 1px solid #e74c3c; border-radius: 4px; text-decoration: none; font-size: 13px; }
        .delete-btn:hover { background: #ffebee; }

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
                    <li><a href="/user/reading-history">📖 阅读记录</a></li>
                    <li><a href="/user/comments" class="active">💬 我的评论</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="page-title">💬 我的评论</div>
                
                <div class="comment-list">
                    <c:choose>
                        <c:when test="${not empty comments}">
                        <c:forEach items="${comments}" var="comment">
                            <div class="comment-card">
                                <div class="comment-header">
                                    <div class="book-info">
                                        <div class="book-cover-small">
                                            <c:choose>
                                                <c:when test="${not empty comment.bookCoverImage}">
                                                    <img src="${comment.bookCoverImage}" alt="${comment.bookTitle}" onerror="this.parentElement.innerHTML='<span style=font-size:24px;>📖</span>'">
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="font-size:24px;">📖</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <a href="/books/${comment.bookId}" class="book-title-link">${comment.bookTitle}</a>
                                        </div>
                                    </div>
                                    <div class="rating">
                                        <c:forEach begin="1" end="5" var="i">
                                            <span>${i <= comment.rating ? '★' : '☆'}</span>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="comment-content">${comment.content}</div>
                                <div class="comment-footer">
                                    <div class="comment-time">
                                        <c:if test="${comment.createTime != null}">
                                            <fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                        </c:if>
                                    </div>
                                    <a href="/comment/delete/${comment.id}" class="delete-btn" onclick="return confirm('确定删除这条评论吗？')">删除</a>
                                </div>
                            </div>
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
                        <div class="empty">
                            <div class="empty-icon">💬</div>
                            <p>还没有发表任何评论</p>
                            <p>去图书详情页发表你的看法吧！</p>
                        </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>
</body>
</html>