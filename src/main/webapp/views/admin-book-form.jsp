<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${book != null ? '编辑图书' : '添加图书'} - 悦读书城管理后台</title>
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
        .form-group textarea { resize: vertical; min-height: 120px; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-actions { display: flex; gap: 15px; margin-top: 30px; }
        .submit-btn { padding: 12px 30px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .cancel-btn { padding: 12px 30px; background: #ddd; color: #333; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }

        .cover-upload { display: flex; gap: 20px; align-items: flex-start; }
        .cover-preview { width: 120px; height: 160px; border: 2px dashed #ddd; border-radius: 8px; display: flex; align-items: center; justify-content: center; overflow: hidden; background: #f9f9f9; flex-shrink: 0; }
        .cover-preview img { width: 100%; height: 100%; object-fit: cover; }
        .cover-preview span { font-size: 40px; color: #ccc; }
        .cover-input { flex: 1; }
        .cover-input input[type="file"] { padding: 10px; border: 1px solid #ddd; border-radius: 5px; width: 100%; background: #f9f9f9; }
        .cover-url { margin-top: 10px; }
        .cover-url input { font-size: 13px; }

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
                <h1 class="page-title">📚 ${book != null ? '编辑图书' : '添加图书'}</h1>
                <a href="/admin/books" class="back-link">← 返回列表</a>
            </div>

            <div class="form-container">
                <form action="${book != null ? '/admin/books/update' : '/admin/books/save'}" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${book != null ? book.id : ''}">
                    
                    <div class="form-group">
                        <label>书名 *</label>
                        <input type="text" name="title" value="${book != null ? book.title : ''}" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>作者 *</label>
                            <input type="text" name="author" value="${book != null ? book.author : ''}" required>
                        </div>
                        <div class="form-group">
                            <label>分类 *</label>
                            <select name="categoryId" required>
                                <option value="">请选择分类</option>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.id}" ${book != null && book.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>封面图片</label>
                        <div class="cover-upload">
                            <div class="cover-preview" id="coverPreview">
                                <c:choose>
                                    <c:when test="${book != null && book.coverImage != null && book.coverImage != ''}">
                                        <img src="${book.coverImage}" alt="封面预览" id="previewImg">
                                    </c:when>
                                    <c:otherwise>
                                        <span>📖</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="cover-input">
                                <input type="file" name="coverFile" accept="image/*" id="coverFile">
                                <div class="cover-url">
                                    <input type="text" name="coverImage" value="${book != null ? book.coverImage : ''}" placeholder="或输入封面图片URL">
                                </div>
                                <p style="font-size: 12px; color: #999; margin-top: 8px;">支持 jpg、png、gif 格式，文件大小不超过 10MB</p>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>价格</label>
                            <input type="number" name="price" step="0.01" value="${book != null ? book.price : '0.00'}">
                        </div>
                        <div class="form-group">
                            <label>是否免费</label>
                            <select name="isFree">
                                <option value="0" ${book != null && book.isFree == 0 ? 'selected' : ''}>付费</option>
                                <option value="1" ${book != null && book.isFree == 1 ? 'selected' : ''}>免费</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>内容简介</label>
                        <textarea name="description">${book != null ? book.description : ''}</textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>字数</label>
                            <input type="number" name="wordCount" value="${book != null ? book.wordCount : '0'}">
                        </div>
                        <div class="form-group">
                            <label>状态</label>
                            <select name="status">
                                <option value="0" ${book != null && book.status == 0 ? 'selected' : ''}>草稿</option>
                                <option value="1" ${book != null && book.status == 1 ? 'selected' : ''}>连载中</option>
                                <option value="2" ${book != null && book.status == 2 ? 'selected' : ''}>已完结</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="submit-btn">保存</button>
                        <a href="/admin/books" class="cancel-btn">取消</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城管理后台</p>
    </footer>

    <script>
        document.getElementById('coverFile').addEventListener('change', function(e) {
            var file = e.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var preview = document.getElementById('coverPreview');
                    preview.innerHTML = '<img src="' + e.target.result + '" alt="封面预览" id="previewImg">';
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html>