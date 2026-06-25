<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的作品 - 悦读书城</title>
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
        .user-menu a { display: block; padding: 12px; border-radius: 5px; text-decoration: none; color: #333; transition: background 0.3s; cursor: pointer; }
        .user-menu a:hover, .user-menu a.active { background: #e8f5e9; color: #2e7d32; }

        .main-content { flex: 1; background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); overflow: hidden; }
        .tab-header { display: flex; border-bottom: 1px solid #eee; }
        .tab-item { padding: 15px 30px; cursor: pointer; font-weight: 500; color: #666; border-bottom: 3px solid transparent; transition: all 0.3s; }
        .tab-item:hover { color: #667eea; }
        .tab-item.active { color: #667eea; border-bottom-color: #667eea; }
        .tab-content { padding: 30px; }
        .page-title { font-size: 24px; font-weight: bold; margin-bottom: 30px; color: #333; }

        .book-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; }
        .book-card { border: 1px solid #eee; border-radius: 10px; overflow: hidden; transition: all 0.3s; }
        .book-card:hover { box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .book-cover { height: 200px; background: linear-gradient(135deg, #e0e0e0 0%, #f5f5f5 100%); display: flex; align-items: center; justify-content: center; }
        .book-cover img { width: 100%; height: 100%; object-fit: cover; }
        .book-info { padding: 15px; }
        .book-title { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; }
        .book-category { display: inline-block; padding: 3px 8px; background: #eee; border-radius: 5px; font-size: 12px; color: #666; margin-bottom: 10px; }
        .book-stats { display: flex; gap: 15px; font-size: 13px; color: #999; }
        .book-actions { margin-top: 15px; display: flex; gap: 10px; }
        .action-btn { padding: 8px 16px; border-radius: 5px; text-decoration: none; font-size: 13px; }
        .action-btn-primary { background: #667eea; color: white; }
        .action-btn-primary:hover { background: #5a6fd6; }
        .action-btn-secondary { background: #eee; color: #333; }
        .action-btn-secondary:hover { background: #ddd; }

        .status-badge { display: inline-block; padding: 4px 10px; border-radius: 20px; font-size: 12px; margin-bottom: 10px; }
        .status-1 { background: #28a745; color: white; }
        .status-0 { background: #ffc107; color: #333; }

        .empty { text-align: center; padding: 60px; color: #999; }
        .empty-icon { font-size: 64px; margin-bottom: 20px; }

        footer { background: #333; color: white; padding: 30px 0; text-align: center; margin-top: 40px; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: 500; }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px;
        }
        .form-group textarea { height: 200px; resize: vertical; }
        .form-hint { font-size: 12px; color: #999; margin-top: 5px; }
        .cover-upload { display: flex; gap: 15px; align-items: flex-start; }
        .cover-preview { width: 100px; height: 140px; border: 2px dashed #ddd; border-radius: 8px; display: flex; align-items: center; justify-content: center; overflow: hidden; background: #f9f9f9; flex-shrink: 0; }
        .cover-preview img { width: 100%; height: 100%; object-fit: cover; }
        .cover-preview span { font-size: 36px; color: #ccc; }
        .cover-input { flex: 1; }
        .cover-input input[type="file"] { padding: 8px; border: 1px solid #ddd; border-radius: 5px; width: 100%; background: #f9f9f9; font-size: 13px; }
        .cover-url { margin-top: 8px; }
        .cover-url input { font-size: 13px; }
        .btn { padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; }
        .btn-primary { background: #667eea; color: white; }
        .btn-primary:hover { background: #5a6fd6; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-secondary:hover { background: #5a6268; }
        .btn-group { display: flex; gap: 15px; margin-top: 30px; }

        .submit-list { margin-top: 40px; }
        .submit-item { border: 1px solid #eee; border-radius: 8px; padding: 20px; margin-bottom: 15px; }
        .submit-item.pending { border-left: 4px solid #ffc107; }
        .submit-item.approved { border-left: 4px solid #28a745; }
        .submit-item.rejected { border-left: 4px solid #dc3545; }
        .submit-header { display: flex; justify-content: space-between; align-items: center; }
        .submit-title { font-size: 16px; font-weight: bold; color: #333; }
        .status-badge-sm { padding: 4px 10px; border-radius: 20px; font-size: 12px; }
        .reject-reason { color: #dc3545; font-size: 13px; margin-top: 10px; padding: 10px; background: #fff5f5; border-radius: 5px; }

        .my-books-small { display: grid; grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); gap: 15px; margin-bottom: 20px; }
        .book-card-small { border: 1px solid #eee; border-radius: 8px; padding: 15px; text-align: center; cursor: pointer; transition: all 0.3s; }
        .book-card-small:hover, .book-card-small.selected { border-color: #667eea; background: #f8f9ff; }
        .book-cover-small { width: 80px; height: 100px; margin: 0 auto 10px; background: #eee; border-radius: 5px; display: flex; align-items: center; justify-content: center; }
        .book-title-small { font-size: 14px; font-weight: bold; color: #333; }
        .selected-hint { margin-top: 10px; padding: 12px; border: 1px solid #ddd; border-radius: 5px; min-height: 40px; color: #999; }
        .selected-hint.active { color: #667eea; font-weight: bold; }
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
                    <li><a onclick="showTab('myBooks')" class="active">📚 我的作品</a></li>
                    <li><a onclick="showTab('submitBook')">📤 上传图书</a></li>
                    <li><a onclick="showTab('submitChapter')">📝 上传章节</a></li>
                    <li><a href="/user/recharge">💰 账户充值</a></li>
                    <li><a href="/user/favorites">❤️ 我的收藏</a></li>
                    <li><a href="/user/reading-history">📖 阅读记录</a></li>
                    <li><a href="/user/comments">💬 我的评论</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="tab-header">
                    <div class="tab-item active" onclick="showTab('myBooks')">📚 我的作品</div>
                    <div class="tab-item" onclick="showTab('submitBook')">📤 上传图书</div>
                    <div class="tab-item" onclick="showTab('submitChapter')">📝 上传章节</div>
                </div>

                <div id="tab-myBooks" class="tab-content">
                    <div class="page-title">📚 我的作品</div>
                    
                    <c:choose>
                        <c:when test="${not empty myBooks}">
                            <div class="book-list">
                                <c:forEach items="${myBooks}" var="book">
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
                                            <span class="status-badge status-${book.status}">${book.status == 1 ? '已发布' : '审核中'}</span>
                                            <div class="book-title">${book.title}</div>
                                            <span class="book-category">${book.categoryName}</span>
                                            <div class="book-stats">
                                                <span>📖 ${book.chapterCount}章</span>
                                                <span>👁️ ${book.viewCount}阅读</span>
                                                <span>❤️ ${book.favoriteCount}收藏</span>
                                            </div>
                                            <div class="book-actions">
                                                <a href="/books/${book.id}" class="action-btn action-btn-primary">查看详情</a>
                                                <a onclick="showTab('submitChapter'); selectBookForChapter(${book.id}, '${book.title}')" class="action-btn action-btn-secondary">上传章节</a>
                                                <button onclick="deleteBook(${book.id}, '${book.title}')" class="action-btn action-btn-danger">删除图书</button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty">
                                <div class="empty-icon">📝</div>
                                <p>您还没有发布任何作品</p>
                                <p><a href="#" onclick="showTab('submitBook')" style="color: #667eea;">点击这里上传您的第一本书</a></p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div id="tab-submitBook" class="tab-content" style="display: none;">
                    <div class="page-title">📤 上传图书</div>
                    
                    <form id="bookForm" action="/user/submit-book" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label>书名 *</label>
                            <input type="text" name="title" required placeholder="请输入图书名称">
                        </div>
                        <div class="form-group">
                            <label>作者 *</label>
                            <input type="text" name="author" value="${sessionScope.nickname}" readonly required>
                            <div class="form-hint">作者默认为您的昵称，不可修改</div>
                        </div>
                        <div class="form-group">
                            <label>分类 *</label>
                            <select name="categoryId" required>
                                <option value="">请选择分类</option>
                                <c:forEach items="${categories}" var="cat">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>封面图片</label>
                            <div class="cover-upload">
                                <div class="cover-preview" id="userCoverPreview">
                                    <span>📖</span>
                                </div>
                                <div class="cover-input">
                                    <input type="file" name="coverFile" accept="image/*" id="userCoverFile">
                                    <div class="cover-url">
                                        <input type="text" name="coverImage" placeholder="或输入封面图片URL">
                                    </div>
                                    <div class="form-hint">支持 jpg、png、gif 格式，文件大小不超过 10MB</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>价格 *</label>
                            <input type="number" name="price" step="0.01" value="0.00" required>
                            <div class="form-hint">设为0表示免费图书</div>
                        </div>
                        <div class="form-group">
                            <label>字数</label>
                            <input type="number" name="wordCount" value="0" placeholder="请输入字数">
                        </div>
                        <div class="form-group">
                            <label>简介</label>
                            <textarea name="description" placeholder="请输入图书简介"></textarea>
                        </div>
                        <div class="form-group">
                            <label>是否免费</label>
                            <select name="isFree">
                                <option value="0">付费</option>
                                <option value="1">免费</option>
                            </select>
                        </div>
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary">提交审核</button>
                            <button type="reset" class="btn btn-secondary">重置</button>
                        </div>
                    </form>

                    <div class="submit-list">
                        <h3 style="margin-bottom: 20px; color: #333;">📋 我的提交记录</h3>
                        <c:choose>
                            <c:when test="${not empty bookSubmissions}">
                                <c:forEach items="${bookSubmissions}" var="sub">
                                    <div class="submit-item ${sub.status == 0 ? 'pending' : sub.status == 1 ? 'approved' : 'rejected'}">
                                        <div class="submit-header">
                                            <div class="submit-title">📖 ${sub.title}</div>
                                            <span class="status-badge-sm status-${sub.status}">
                                                <c:choose>
                                                    <c:when test="${sub.status == 0}">待审核</c:when>
                                                    <c:when test="${sub.status == 1}">已通过</c:when>
                                                    <c:otherwise>已拒绝</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div style="margin-top: 10px; color: #666; font-size: 14px;">作者：${sub.author} | 分类：${sub.categoryName}</div>
                                        <div style="margin-top: 5px; color: #999; font-size: 13px;">提交时间：<fmt:formatDate value="${sub.createTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                                        <c:if test="${sub.status == 2 && not empty sub.rejectReason}">
                                            <div class="reject-reason">拒绝原因：${sub.rejectReason}</div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 30px; color: #999;">
                                    <p>暂无提交记录</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div id="tab-submitChapter" class="tab-content" style="display: none;">
                    <div class="page-title">📝 上传章节</div>
                    
                    <div class="form-group">
                        <label>选择书籍 *</label>
                        <div class="my-books-small">
                            <c:choose>
                                <c:when test="${not empty myBooks}">
                                    <c:forEach items="${myBooks}" var="book">
                                        <div class="book-card-small" onclick="selectBookForChapter(${book.id}, '${book.title}')">
                                            <div class="book-cover-small">📖</div>
                                            <div class="book-title-small">${book.title}</div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div style="text-align: center; padding: 40px; color: #999;">
                                        <p style="font-size: 48px; margin-bottom: 15px;">📚</p>
                                        <p>您还没有通过审核的书籍</p>
                                        <p><a href="#" onclick="showTab('submitBook')" style="color: #667eea;">请先上传图书并通过审核</a></p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <form id="chapterForm" action="/user/submit-chapter" method="post" style="display: ${myBooks.isEmpty() ? 'none' : 'block'};">
                        <input type="hidden" name="bookId" id="chapterBookId">
                        <input type="hidden" name="bookTitle" id="chapterBookTitle">

                        <div class="form-group">
                            <label>已选书籍</label>
                            <div id="selectedBookDisplay" class="selected-hint">请从上方选择书籍</div>
                        </div>

                        <div class="form-group">
                            <label>章节序号</label>
                            <input type="number" name="chapterNumber" min="1" placeholder="不填则自动生成下一个序号">
                            <span style="color: #666; font-size: 12px;">留空将自动生成下一个序号</span>
                        </div>
                        <div class="form-group">
                            <label>章节标题 *</label>
                            <input type="text" name="title" required placeholder="请输入章节标题">
                        </div>
                        <div class="form-group">
                            <label>章节内容 *</label>
                            <textarea name="content" required placeholder="请输入章节内容"></textarea>
                        </div>
                        <div class="form-group">
                            <label>是否免费</label>
                            <select name="isFree" onchange="toggleChapterPrice(this.value)">
                                <option value="0">付费</option>
                                <option value="1">免费</option>
                            </select>
                        </div>
                        <div class="form-group" id="chapterPriceGroup">
                            <label>价格</label>
                            <input type="number" name="price" step="0.01" value="0.00">
                        </div>
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary" onclick="return validateChapterForm()">提交审核</button>
                            <button type="button" onclick="resetChapterForm()" class="btn btn-secondary">重置</button>
                        </div>
                    </form>

                    <div class="submit-list">
                        <h3 style="margin-bottom: 20px; color: #333;">📋 我的章节提交记录</h3>
                        <c:choose>
                            <c:when test="${not empty chapterSubmissions}">
                                <c:forEach items="${chapterSubmissions}" var="sub">
                                    <div class="submit-item ${sub.status == 0 ? 'pending' : sub.status == 1 ? 'approved' : 'rejected'}">
                                        <div class="submit-header">
                                            <div class="submit-title">第${sub.chapterNumber}章 ${sub.title}</div>
                                            <span class="status-badge-sm status-${sub.status}">
                                                <c:choose>
                                                    <c:when test="${sub.status == 0}">待审核</c:when>
                                                    <c:when test="${sub.status == 1}">已通过</c:when>
                                                    <c:otherwise>已拒绝</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div style="margin-top: 10px; color: #666; font-size: 14px;">所属书籍：${sub.bookTitle}</div>
                                        <div style="margin-top: 5px; color: #999; font-size: 13px;">提交时间：<fmt:formatDate value="${sub.createTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                                        <c:if test="${sub.status == 2 && not empty sub.rejectReason}">
                                            <div class="reject-reason">拒绝原因：${sub.rejectReason}</div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 30px; color: #999;">
                                    <p>暂无章节提交记录</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>

    <script>
        function showTab(tabName) {
            document.querySelectorAll('.tab-item').forEach(item => item.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.style.display = 'none');
            document.querySelectorAll('.user-menu a').forEach(link => link.classList.remove('active'));
            
            document.querySelector('.tab-item[onclick="showTab(\'' + tabName + '\')"]').classList.add('active');
            document.querySelector('.user-menu a[onclick="showTab(\'' + tabName + '\')"]').classList.add('active');
            document.getElementById('tab-' + tabName).style.display = 'block';
        }

        function selectBookForChapter(bookId, bookTitle) {
            document.querySelectorAll('.book-card-small').forEach(card => card.classList.remove('selected'));
            event.target.closest('.book-card-small').classList.add('selected');
            document.getElementById('chapterBookId').value = bookId;
            document.getElementById('chapterBookTitle').value = bookTitle;
            document.getElementById('selectedBookDisplay').innerHTML = '<strong>📖 ' + bookTitle + '</strong>';
            document.getElementById('selectedBookDisplay').classList.add('active');
        }

        function resetChapterForm() {
            document.getElementById('chapterForm').reset();
            document.getElementById('selectedBookDisplay').innerHTML = '请从上方选择书籍';
            document.getElementById('selectedBookDisplay').classList.remove('active');
            document.querySelectorAll('.book-card-small').forEach(card => card.classList.remove('selected'));
        }

        function validateChapterForm() {
            var bookId = document.getElementById('chapterBookId').value;
            if (!bookId || bookId.trim() === '') {
                alert('请先选择要上传章节的书籍');
                return false;
            }
            return true;
        }

        function toggleChapterPrice(isFree) {
            var priceGroup = document.getElementById('chapterPriceGroup');
            if (isFree == '1') {
                priceGroup.style.display = 'none';
            } else {
                priceGroup.style.display = 'block';
            }
        }

        function deleteBook(bookId, bookTitle) {
            if (confirm('确定要删除图书《' + bookTitle + '》吗？此操作将删除该图书的所有章节和相关数据，且无法恢复！')) {
                window.location.href = '/user/delete-book/' + bookId;
            }
        }

        var coverFileInput = document.getElementById('userCoverFile');
        if (coverFileInput) {
            coverFileInput.addEventListener('change', function(e) {
                var file = e.target.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var preview = document.getElementById('userCoverPreview');
                        preview.innerHTML = '<img src="' + e.target.result + '" alt="封面预览">';
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
    </script>
</body>
</html>
