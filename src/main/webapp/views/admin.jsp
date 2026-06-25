<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>管理后台 - 悦读书城</title>
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
        .sidebar-menu a { display: block; padding: 12px 15px; color: white; text-decoration: none; border-radius: 5px; transition: background 0.3s; cursor: pointer; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: #2c3e50; }
        .menu-icon { margin-right: 10px; }

        .main-content { flex: 1; padding: 30px; }
        .page-title { font-size: 24px; font-weight: bold; margin-bottom: 30px; color: #333; }

        .tab-header { display: flex; background: white; padding: 10px; border-radius: 8px; margin-bottom: 20px; }
        .tab-item { padding: 12px 30px; cursor: pointer; font-weight: 500; color: #666; border-radius: 5px; transition: all 0.3s; }
        .tab-item:hover { background: #f0f0f0; }
        .tab-item.active { background: #667eea; color: white; }
        .tab-content { display: none; }
        .tab-content.active { display: block; }

        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .stat-value { font-size: 32px; font-weight: bold; color: #667eea; margin-bottom: 5px; }
        .stat-label { color: #666; }

        .quick-actions { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; }
        .action-card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .action-card h3 { color: #333; margin-bottom: 15px; }
        .action-list { list-style: none; }
        .action-list li { margin-bottom: 10px; }
        .action-list a { color: #667eea; text-decoration: none; }
        .action-list a:hover { text-decoration: underline; }

        .filter-bar { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; display: flex; gap: 15px; }
        .filter-bar a { padding: 8px 16px; border-radius: 5px; text-decoration: none; color: #666; transition: all 0.3s; }
        .filter-bar a:hover { background: #e8e8e8; }
        .filter-bar a.active { background: #667eea; color: white; }

        .submission-table { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; font-weight: 500; color: #333; }
        tr:hover { background: #f8f9fa; }
        .book-cover { width: 50px; height: 70px; background: #eee; border-radius: 3px; overflow: hidden; }
        .book-cover img { width: 100%; height: 100%; object-fit: cover; }
        .status-badge { display: inline-block; padding: 4px 10px; border-radius: 20px; font-size: 12px; }
        .status-0 { background: #ffc107; color: #333; }
        .status-1 { background: #28a745; color: white; }
        .status-2 { background: #dc3545; color: white; }
        .action-btn { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; margin-right: 5px; }
        .btn-approve { background: #28a745; color: white; }
        .btn-reject { background: #dc3545; color: white; }
        .btn-view { background: #667eea; color: white; }

        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; }
        .modal.show { display: flex; align-items: center; justify-content: center; }
        .modal-content { background: white; padding: 30px; border-radius: 10px; max-width: 500px; width: 90%; }
        .modal-title { font-size: 18px; font-weight: bold; margin-bottom: 20px; }
        .modal-input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 20px; }
        .modal-buttons { display: flex; gap: 10px; justify-content: flex-end; }
        .modal-btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
        .modal-btn-primary { background: #dc3545; color: white; }
        .modal-btn-secondary { background: #6c757d; color: white; }

        .reject-reason { color: #dc3545; font-size: 13px; margin-top: 10px; padding: 10px; background: #fff5f5; border-radius: 5px; }

        .empty { text-align: center; padding: 60px; color: #999; }
        .empty-icon { font-size: 64px; margin-bottom: 20px; }

        footer { background: #333; color: white; padding: 20px 0; text-align: center; margin-top: auto; }
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
                <li><a onclick="showMainTab('dashboard')" class="active"><span class="menu-icon">📊</span> 控制台</a></li>
                <li><a onclick="showMainTab('review')"><span class="menu-icon">✅</span> 内容审核</a></li>
                <li><a href="/admin/books"><span class="menu-icon">📚</span> 图书管理</a></li>
                <li><a href="/admin/chapters"><span class="menu-icon">📑</span> 章节管理</a></li>
                <li><a href="/admin/categories"><span class="menu-icon">📁</span> 分类管理</a></li>
                <li><a href="/admin/users"><span class="menu-icon">👥</span> 用户管理</a></li>
                <li><a href="/admin/comments"><span class="menu-icon">💬</span> 评论管理</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div id="tab-dashboard" class="main-tab-content">
                <h1 class="page-title">📊 控制台</h1>

                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-value">${stats.bookCount}</div>
                        <div class="stat-label">📚 图书总数</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">${stats.chapterCount}</div>
                        <div class="stat-label">📑 章节总数</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">${stats.userCount}</div>
                        <div class="stat-label">👥 用户总数</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">${stats.commentCount}</div>
                        <div class="stat-label">💬 评论总数</div>
                    </div>
                </div>

                <div class="quick-actions">
                    <div class="action-card">
                        <h3>📚 图书管理</h3>
                        <ul class="action-list">
                            <li><a href="/admin/books">查看图书列表</a></li>
                            <li><a href="/admin/books/add">添加新图书</a></li>
                        </ul>
                    </div>
                    <div class="action-card">
                        <h3>👥 用户管理</h3>
                        <ul class="action-list">
                            <li><a href="/admin/users">查看用户列表</a></li>
                            <li><a href="/admin/users/add">添加新用户</a></li>
                        </ul>
                    </div>
                    <div class="action-card">
                        <h3>📁 分类管理</h3>
                        <ul class="action-list">
                            <li><a href="/admin/categories">查看分类列表</a></li>
                            <li><a href="/admin/categories/add">添加新分类</a></li>
                        </ul>
                    </div>
                    <div class="action-card">
                        <h3>💬 评论管理</h3>
                        <ul class="action-list">
                            <li><a href="/admin/comments">查看评论列表</a></li>
                            <li><a href="/admin/comments/pending">待审核评论</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div id="tab-review" class="main-tab-content" style="display: none;">
                <h1 class="page-title">📋 内容审核</h1>

                <div class="tab-header">
                    <div class="tab-item active" data-tab="book">📖 图书审核</div>
                    <div class="tab-item" data-tab="chapter">📝 章节审核</div>
                </div>

                <div id="review-book" class="tab-content active">
                    <div class="filter-bar" data-parent="book">
                        <a href="#" data-status="" class="active">全部</a>
                        <a href="#" data-status="0">待审核</a>
                        <a href="#" data-status="1">已通过</a>
                        <a href="#" data-status="2">已拒绝</a>
                    </div>

                    <div class="submission-table">
                        <c:choose>
                            <c:when test="${not empty bookSubmissions}">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>封面</th>
                                            <th>书名/作者</th>
                                            <th>分类/价格</th>
                                            <th>提交人</th>
                                            <th>状态</th>
                                            <th>时间</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${bookSubmissions}" var="sub">
                                            <tr>
                                                <td>${sub.id}</td>
                                                <td>
                                                    <div class="book-cover">
                                                        <c:choose>
                                                            <c:when test="${not empty sub.coverImage}">
                                                                <img src="${sub.coverImage}" alt="">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="font-size:20px; display:flex; align-items:center; justify-content:center; height:100%;">📖</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div style="font-weight:500;">${sub.title}</div>
                                                    <div style="color:#666; font-size:13px;">${sub.author}</div>
                                                </td>
                                                <td>
                                                    <div>${sub.categoryName}</div>
                                                    <div style="color:#667eea;">¥${sub.price}</div>
                                                </td>
                                                <td>
                                                    <div>${sub.nickname}</div>
                                                    <div style="color:#999; font-size:12px;">@${sub.username}</div>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${sub.status == 0}">
                                                            <span class="status-badge status-0">待审核</span>
                                                        </c:when>
                                                        <c:when test="${sub.status == 1}">
                                                            <span class="status-badge status-1">已通过</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge status-2">已拒绝</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:if test="${sub.status == 2 && not empty sub.rejectReason}">
                                                        <div class="reject-reason">${sub.rejectReason}</div>
                                                    </c:if>
                                                </td>
                                                <td><fmt:formatDate value="${sub.createTime}" pattern="yyyy-MM-dd"/></td>
                                                <td>
                                                    <c:if test="${sub.status == 0}">
                                                        <button onclick="approveBook(${sub.id})" class="action-btn btn-approve">通过</button>
                                                        <button onclick="showBookRejectModal(${sub.id})" class="action-btn btn-reject">拒绝</button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="empty">
                                    <div class="empty-icon">📋</div>
                                    <p>暂无图书提交记录</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div id="review-chapter" class="tab-content">
                    <div class="filter-bar" data-parent="chapter">
                        <a href="#" data-status="" class="active">全部</a>
                        <a href="#" data-status="0">待审核</a>
                        <a href="#" data-status="1">已通过</a>
                        <a href="#" data-status="2">已拒绝</a>
                    </div>

                    <div class="submission-table">
                        <c:choose>
                            <c:when test="${not empty chapterSubmissions}">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>所属书籍</th>
                                            <th>章节信息</th>
                                            <th>作者</th>
                                            <th>状态</th>
                                            <th>时间</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${chapterSubmissions}" var="sub">
                                            <tr>
                                                <td>${sub.id}</td>
                                                <td>
                                                    <div style="font-weight:500;">${sub.bookTitle}</div>
                                                    <div style="color:#666; font-size:13px;">图书ID: ${sub.bookId}</div>
                                                </td>
                                                <td>
                                                    <div>第${sub.chapterNumber}章 ${sub.title}</div>
                                                    <div style="color:#667eea; font-size:13px;">${sub.isFree == 1 ? '免费' : '付费'}</div>
                                                </td>
                                                <td>${sub.authorName}</td>
                                                <td>
                                                    <span class="status-badge status-${sub.status}">
                                                        <c:choose>
                                                            <c:when test="${sub.status == 0}">待审核</c:when>
                                                            <c:when test="${sub.status == 1}">已通过</c:when>
                                                            <c:otherwise>已拒绝</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                    <c:if test="${sub.status == 2 && not empty sub.rejectReason}">
                                                        <div class="reject-reason">${sub.rejectReason}</div>
                                                    </c:if>
                                                </td>
                                                <td><fmt:formatDate value="${sub.createTime}" pattern="yyyy-MM-dd"/></td>
                                                <td>
                                                    <c:if test="${sub.status == 0}">
                                                        <button onclick="approveChapter(${sub.id})" class="action-btn btn-approve">通过</button>
                                                        <button onclick="showChapterRejectModal(${sub.id})" class="action-btn btn-reject">拒绝</button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="empty">
                                    <div class="empty-icon">📋</div>
                                    <p>暂无章节提交记录</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="bookRejectModal" class="modal">
        <div class="modal-content">
            <div class="modal-title">拒绝图书提交</div>
            <input type="hidden" id="bookRejectId">
            <textarea id="bookRejectReason" class="modal-input" placeholder="请输入拒绝原因（选填）" rows="4"></textarea>
            <div class="modal-buttons">
                <button onclick="closeBookRejectModal()" class="modal-btn modal-btn-secondary">取消</button>
                <button onclick="confirmBookReject()" class="modal-btn modal-btn-primary">确认拒绝</button>
            </div>
        </div>
    </div>

    <div id="chapterRejectModal" class="modal">
        <div class="modal-content">
            <div class="modal-title">拒绝章节提交</div>
            <input type="hidden" id="chapterRejectId">
            <textarea id="chapterRejectReason" class="modal-input" placeholder="请输入拒绝原因（选填）" rows="4"></textarea>
            <div class="modal-buttons">
                <button onclick="closeChapterRejectModal()" class="modal-btn modal-btn-secondary">取消</button>
                <button onclick="confirmChapterReject()" class="modal-btn modal-btn-primary">确认拒绝</button>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城管理后台</p>
    </footer>

    <script>
        var currentReviewTab = 'book';
        var reviewTabStatus = { book: '', chapter: '' };

        function showMainTab(tabName) {
            document.querySelectorAll('.sidebar-menu a').forEach(item => item.classList.remove('active'));
            document.querySelectorAll('.main-tab-content').forEach(content => content.style.display = 'none');
            document.querySelector('.sidebar-menu a[onclick="showMainTab(\'' + tabName + '\')"]').classList.add('active');
            document.getElementById('tab-' + tabName).style.display = 'block';
        }

        function showReviewTab(tabName, skipRedirect) {
            currentReviewTab = tabName;
            
            document.querySelectorAll('.tab-header .tab-item').forEach(item => item.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
            document.querySelector('.tab-header .tab-item[data-tab="' + tabName + '"]').classList.add('active');
            document.getElementById('review-' + tabName).classList.add('active');
            
            localStorage.setItem('reviewTab', tabName);
            
            var savedStatus = localStorage.getItem('reviewTabStatus_' + tabName) || '';
            reviewTabStatus[tabName] = savedStatus;
            
            var filterBar = document.getElementById('review-' + tabName).querySelector('.filter-bar');
            if (filterBar) {
                filterBar.querySelectorAll('a').forEach(link => link.classList.remove('active'));
                var statusLink = filterBar.querySelector('a[data-status="' + savedStatus + '"]');
                if (statusLink) {
                    statusLink.classList.add('active');
                } else {
                    filterBar.querySelector('a[data-status=""]').classList.add('active');
                }
            }
            
            if (!skipRedirect && savedStatus !== '') {
                var url = '/admin?tab=review&reviewTab=' + tabName + '&status=' + savedStatus;
                window.location.href = url;
            }
        }

        function filterReviews(event) {
            event.preventDefault();
            event.stopPropagation();
            
            var target = event.target;
            var filterBar = target.closest('.filter-bar');
            var parentTab = filterBar.dataset.parent;
            var status = target.dataset.status;
            
            reviewTabStatus[parentTab] = status;
            localStorage.setItem('reviewTabStatus_' + parentTab, status);
            
            filterBar.querySelectorAll('a').forEach(link => link.classList.remove('active'));
            target.classList.add('active');
            
            var url = '/admin?tab=review&reviewTab=' + parentTab;
            if (status !== '') {
                url += '&status=' + status;
            }
            
            window.location.href = url;
        }

        function approveBook(id) {
            localStorage.setItem('reviewTabStatus_book', '0');
            fetch('/admin/approve-submission/' + id, {
                method: 'GET'
            }).then(response => {
                if (response.ok) {
                    window.location.href = '/admin?tab=review&reviewTab=book&status=0';
                }
            });
        }

        function showBookRejectModal(id) {
            document.getElementById('bookRejectId').value = id;
            document.getElementById('bookRejectModal').classList.add('show');
        }

        function closeBookRejectModal() {
            document.getElementById('bookRejectModal').classList.remove('show');
        }

        function confirmBookReject() {
            var id = document.getElementById('bookRejectId').value;
            var reason = document.getElementById('bookRejectReason').value;
            localStorage.setItem('reviewTabStatus_book', '0');
            fetch('/admin/reject-submission/' + id + '?reason=' + encodeURIComponent(reason), {
                method: 'GET'
            }).then(response => {
                if (response.ok) {
                    window.location.href = '/admin?tab=review&reviewTab=book&status=0';
                }
            });
        }

        function approveChapter(id) {
            localStorage.setItem('reviewTabStatus_chapter', '0');
            fetch('/admin/approve-chapter-submission/' + id, {
                method: 'GET'
            }).then(response => {
                if (response.ok) {
                    window.location.href = '/admin?tab=review&reviewTab=chapter&status=0';
                }
            });
        }

        function showChapterRejectModal(id) {
            document.getElementById('chapterRejectId').value = id;
            document.getElementById('chapterRejectModal').classList.add('show');
        }

        function closeChapterRejectModal() {
            document.getElementById('chapterRejectModal').classList.remove('show');
        }

        function confirmChapterReject() {
            var id = document.getElementById('chapterRejectId').value;
            var reason = document.getElementById('chapterRejectReason').value;
            localStorage.setItem('reviewTabStatus_chapter', '0');
            fetch('/admin/reject-chapter-submission/' + id + '?reason=' + encodeURIComponent(reason), {
                method: 'GET'
            }).then(response => {
                if (response.ok) {
                    window.location.href = '/admin?tab=review&reviewTab=chapter&status=0';
                }
            });
        }

        window.onclick = function(event) {
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('show');
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            var urlParams = new URLSearchParams(window.location.search);
            var tab = urlParams.get('tab');
            var reviewTab = urlParams.get('reviewTab') || localStorage.getItem('reviewTab') || 'book';
            var status = urlParams.get('status');
            
            reviewTabStatus.book = localStorage.getItem('reviewTabStatus_book') || '';
            reviewTabStatus.chapter = localStorage.getItem('reviewTabStatus_chapter') || '';
            
            currentReviewTab = reviewTab;
            
            if (tab === 'review') {
                showMainTab('review');
                
                document.querySelectorAll('.tab-header .tab-item').forEach(item => item.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
                document.querySelector('.tab-header .tab-item[data-tab="' + reviewTab + '"]').classList.add('active');
                document.getElementById('review-' + reviewTab).classList.add('active');
                
                var currentStatus = status !== null ? status : reviewTabStatus[reviewTab];
                reviewTabStatus[reviewTab] = currentStatus;
                localStorage.setItem('reviewTabStatus_' + reviewTab, currentStatus);
                
                var filterBar = document.getElementById('review-' + reviewTab).querySelector('.filter-bar');
                if (filterBar) {
                    filterBar.querySelectorAll('a').forEach(link => link.classList.remove('active'));
                    var statusLink = filterBar.querySelector('a[data-status="' + currentStatus + '"]');
                    if (statusLink) {
                        statusLink.classList.add('active');
                    } else {
                        filterBar.querySelector('a[data-status=""]').classList.add('active');
                    }
                }
            }
            
            document.querySelectorAll('.filter-bar a').forEach(link => {
                link.addEventListener('click', filterReviews);
            });
            
            document.querySelectorAll('.tab-header .tab-item').forEach(item => {
                item.addEventListener('click', function() {
                    showReviewTab(this.dataset.tab, false);
                });
            });
        });
    </script>
</body>
</html>