<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>章节管理 - 悦读书城管理后台</title>
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

        .book-selector { margin-bottom: 20px; }
        .book-selector label { margin-right: 10px; color: #333; }
        .book-selector select { padding: 8px 15px; border: 1px solid #ddd; border-radius: 5px; }

        .table-container { background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); overflow: hidden; }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        .data-table th { background: #f8f9fa; font-weight: bold; color: #333; }
        .data-table tr:hover { background: #f8f9fa; }

        .action-links { display: flex; gap: 10px; }
        .action-link { padding: 5px 12px; text-decoration: none; border-radius: 4px; font-size: 13px; }
        .action-link.edit { background: #3498db; color: white; }
        .action-link.delete { background: #e74c3c; color: white; }

        .status-badge { padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8f9fa; color: #666; }

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
                <li><a href="/admin/books"><span class="menu-icon">📚</span> 图书管理</a></li>
                <li><a href="/admin/chapters" class="active"><span class="menu-icon">📑</span> 章节管理</a></li>
                <li><a href="/admin/categories"><span class="menu-icon">📁</span> 分类管理</a></li>
                <li><a href="/admin/users"><span class="menu-icon">👥</span> 用户管理</a></li>
                <li><a href="/admin/comments"><span class="menu-icon">💬</span> 评论管理</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">📑 章节管理</h1>
                <a href="/admin/chapters/add?bookId=${bookId}" class="add-btn">+ 添加章节</a>
            </div>

            <div class="book-selector">
                <form action="/admin/chapters" method="get">
                    <label>选择图书：</label>
                    <select name="bookId" onchange="this.form.submit()">
                        <option value="">全部图书</option>
                        <c:forEach items="${books}" var="book">
                            <option value="${book.id}" ${bookId == book.id ? 'selected' : ''}>${book.title}</option>
                        </c:forEach>
                    </select>
                </form>
            </div>

            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>所属图书</th>
                            <th>章节号</th>
                            <th>标题</th>
                            <th>字数</th>
                            <th>是否免费</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${chapters}" var="chapter">
                            <tr>
                                <td>${chapter.id}</td>
                                <td>${chapter.bookTitle}</td>
                                <td>第${chapter.chapterNumber}章</td>
                                <td>${chapter.title}</td>
                                <td>${chapter.wordCount}</td>
                                <td>
                                    <span class="${chapter.isFree == 1 ? 'price-free' : 'price-paid'}">
                                        ${chapter.isFree == 1 ? '免费' : '付费'}
                                    </span>
                                </td>
                                <td>
                                    <span class="status-badge ${chapter.status == 1 ? 'status-active' : 'status-inactive'}">
                                        ${chapter.status == 1 ? '发布' : '草稿'}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-links">
                                        <a href="/admin/chapters/edit/${chapter.id}" class="action-link edit">编辑</a>
                                        <a href="/admin/chapters/delete/${chapter.id}" class="action-link delete" onclick="return confirm('确定删除该章节吗？')">删除</a>
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