<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${chapter != null ? '编辑章节' : '添加章节'} - 悦读书城管理后台</title>
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
        .page-header { margin-bottom: 30px; }
        .page-title { font-size: 24px; font-weight: bold; color: #333; }
        .back-link { color: #667eea; text-decoration: none; margin-top: 10px; display: inline-block; }

        .form-container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); max-width: 800px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: bold; }
        .form-group input, .form-group textarea, .form-group select { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        .form-group textarea { resize: vertical; min-height: 200px; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-actions { display: flex; gap: 15px; margin-top: 30px; }
        .submit-btn { padding: 12px 30px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .cancel-btn { padding: 12px 30px; background: #ddd; color: #333; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }

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
                <li><a href="/admin/chapters"><span class="menu-icon">📑</span> 章节管理</a></li>
                <li><a href="/admin/categories"><span class="menu-icon">📁</span> 分类管理</a></li>
                <li><a href="/admin/users"><span class="menu-icon">👥</span> 用户管理</a></li>
                <li><a href="/admin/comments"><span class="menu-icon">💬</span> 评论管理</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">📑 ${chapter != null ? '编辑章节' : '添加章节'}</h1>
                <a href="/admin/chapters?bookId=${bookId}" class="back-link">← 返回列表</a>
            </div>

            <div class="form-container">
                <form action="${chapter != null ? '/admin/chapters/update' : '/admin/chapters/save'}" method="post">
                    <input type="hidden" name="id" value="${chapter != null ? chapter.id : ''}">
                    
                    <div class="form-group">
                        <label>所属图书 *</label>
                        <select name="bookId" required>
                            <option value="">请选择图书</option>
                            <c:forEach items="${books}" var="book">
                                <option value="${book.id}" ${(chapter != null && chapter.bookId == book.id) || (bookId != null && bookId == book.id) ? 'selected' : ''}>${book.title}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>章节号 *</label>
                            <input type="number" name="chapterNumber" value="${chapter != null ? chapter.chapterNumber : ''}" required>
                        </div>
                        <div class="form-group">
                            <label>标题 *</label>
                            <input type="text" name="title" value="${chapter != null ? chapter.title : ''}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>内容</label>
                        <textarea name="content">${chapter != null ? chapter.content : ''}</textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>字数</label>
                            <input type="number" name="wordCount" value="${chapter != null ? chapter.wordCount : '0'}">
                        </div>
                        <div class="form-group">
                            <label>是否免费</label>
                            <select name="isFree">
                                <option value="0" ${chapter != null && chapter.isFree == 0 ? 'selected' : ''}>付费</option>
                                <option value="1" ${chapter != null && chapter.isFree == 1 ? 'selected' : ''}>免费</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>价格</label>
                            <input type="number" name="price" step="0.01" value="${chapter != null ? chapter.price : '0.00'}">
                        </div>
                        <div class="form-group">
                            <label>状态</label>
                            <select name="status">
                                <option value="0" ${chapter != null && chapter.status == 0 ? 'selected' : ''}>草稿</option>
                                <option value="1" ${chapter != null && chapter.status == 1 ? 'selected' : ''}>发布</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="submit-btn">保存</button>
                        <a href="/admin/chapters?bookId=${bookId}" class="cancel-btn">取消</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城管理后台</p>
    </footer>
</body>
</html>