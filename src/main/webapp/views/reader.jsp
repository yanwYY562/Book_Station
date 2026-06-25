<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${book.title} - ${chapter.title} - 悦读书城</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f5f5f5; }
        header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header-content { width: 90%; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav { display: flex; gap: 20px; }
        .nav a { color: white; text-decoration: none; }
        .user-links { display: flex; gap: 15px; }
        .user-links a { color: white; text-decoration: none; }

        .container { display: flex; }
        .sidebar { width: 280px; background: white; min-height: calc(100vh - 65px); border-right: 1px solid #eee; }
        .sidebar-header { padding: 15px; border-bottom: 1px solid #eee; }
        .sidebar-header h3 { color: #333; font-size: 16px; }
        .chapter-list { padding: 10px; }
        .chapter-item { padding: 10px; border-radius: 5px; cursor: pointer; transition: background 0.3s; }
        .chapter-item:hover { background: #f8f9fa; }
        .chapter-item.active { background: #e8f5e9; color: #2e7d32; }
        .chapter-item a { text-decoration: none; color: inherit; display: block; }
        .chapter-number { font-size: 12px; color: #999; margin-right: 10px; }
        .chapter-free { color: #2e7d32; font-size: 12px; float: right; }
        .chapter-locked { color: #e74c3c; font-size: 12px; float: right; }

        .main-content { flex: 1; padding: 30px; }
        .reader-header { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .book-title { font-size: 20px; font-weight: bold; color: #333; margin-bottom: 10px; }
        .chapter-title { font-size: 18px; color: #666; }

        .content-area { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); line-height: 2; font-size: 16px; color: #333; }
        .content-area p { margin-bottom: 1.5em; text-indent: 2em; }

        .nav-buttons { display: flex; justify-content: space-between; margin-top: 30px; }
        .nav-btn { padding: 12px 24px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; display: inline-flex; align-items: center; gap: 8px; }
        .nav-btn:hover { background: #5a6fd6; }
        .nav-btn.disabled { background: #ccc; cursor: not-allowed; }

        .action-buttons { display: flex; gap: 15px; margin-top: 20px; }
        .action-btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; }
        .action-btn.favorite { background: #fff3e0; color: #ff9800; border: 1px solid #ff9800; }
        .action-btn.favorite:hover { background: #ffe0b2; }

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
                <c:if test="${sessionScope.username == null}">
                    <a href="/login">登录</a>
                    <a href="/register">注册</a>
                </c:if>
                <c:if test="${sessionScope.username != null}">
                    <a href="/user/profile">${sessionScope.nickname}</a>
                    <a href="/logout">退出</a>
                </c:if>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>📖 ${book != null ? book.title : ''}</h3>
            </div>
            <div class="chapter-list">
                <c:if test="${chapters != null && chapters.size() > 0}">
                    <c:forEach items="${chapters}" var="ch">
                        <div class="chapter-item ${chapter != null && ch.id == chapter.id ? 'active' : ''}">
                            <a href="/books/read/${book != null ? book.id : ''}/${ch.id}">
                                <span class="chapter-number">第${ch.chapterNumber}章</span>
                                ${ch.title}
                                <c:if test="${ch.isFree == 1}">
                                    <span class="chapter-free">免费</span>
                                </c:if>
                                <c:if test="${ch.isFree == 0}">
                                    <span class="chapter-locked">付费</span>
                                </c:if>
                            </a>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${chapters == null || chapters.size() == 0}">
                    <div style="text-align: center; padding: 20px; color: #999;">暂无章节</div>
                </c:if>
            </div>
        </div>

        <div class="main-content">
            <c:if test="${chapter != null}">
                <div class="reader-header">
                    <div class="book-title">📚 ${book != null ? book.title : ''}</div>
                    <div class="chapter-title">第${chapter.chapterNumber}章 ${chapter.title}</div>
                </div>

                <div class="content-area">
                    <p>${chapter.content}</p>
                </div>

                <div class="nav-buttons">
                    <c:if test="${prevChapter != null}">
                        <a href="/books/read/${book != null ? book.id : ''}/${prevChapter.id}" class="nav-btn">
                            ← 上一章
                        </a>
                    </c:if>
                    <c:if test="${prevChapter == null}">
                        <span class="nav-btn disabled">← 上一章</span>
                    </c:if>
                    
                    <span>第${chapter.chapterNumber}章 / 共${chapters != null ? chapters.size() : 0}章</span>
                    
                    <c:if test="${nextChapter != null}">
                        <a href="/books/read/${book != null ? book.id : ''}/${nextChapter.id}" class="nav-btn">
                            下一章 →
                        </a>
                    </c:if>
                    <c:if test="${nextChapter == null}">
                        <span class="nav-btn disabled">下一章 →</span>
                    </c:if>
                </div>

                <div class="action-buttons">
                    <a href="/books/${book != null ? book.id : ''}" class="action-btn favorite">
                        📖 返回图书详情
                    </a>
                </div>
            </c:if>
            <c:if test="${chapter == null}">
                <div style="text-align: center; padding: 100px; color: #999;">
                    <div style="font-size: 64px; margin-bottom: 20px;">📖</div>
                    <p>章节不存在</p>
                </div>
            </c:if>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>
</body>
</html>
