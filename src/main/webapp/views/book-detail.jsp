<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${book.title} - 悦读书城</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f8f9fa; }
        header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header-content { width: 90%; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav { display: flex; gap: 20px; }
        .nav a { color: white; text-decoration: none; }
        .search-box { display: flex; gap: 10px; }
        .search-input { padding: 8px 15px; border: none; border-radius: 20px; width: 250px; }
        .search-btn { padding: 8px 20px; background: white; color: #667eea; border: none; border-radius: 20px; cursor: pointer; }
        .user-links { display: flex; gap: 15px; }
        .user-links a { color: white; text-decoration: none; }

        .container { width: 90%; margin: 0 auto; padding: 30px 0; }
        .book-detail { display: flex; gap: 30px; }
        .book-cover-large { width: 280px; height: 380px; background: linear-gradient(135deg, #e0e0e0 0%, #f5f5f5 100%); border-radius: 10px; overflow: hidden; }
        .book-cover-large img { width: 100%; height: 100%; object-fit: cover; }
        .book-info { flex: 1; }
        .book-title { font-size: 28px; font-weight: bold; color: #333; margin-bottom: 10px; }
        .book-meta { color: #666; font-size: 14px; margin-bottom: 20px; }
        .book-meta span { margin-right: 20px; }
        .book-description { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; line-height: 1.8; color: #444; }
        .book-stats { display: flex; gap: 30px; margin-bottom: 20px; }
        .stat-item { text-align: center; }
        .stat-value { font-size: 24px; font-weight: bold; color: #667eea; }
        .stat-label { font-size: 14px; color: #666; }

        .action-bar { display: flex; gap: 15px; margin-bottom: 30px; }
        .action-btn { padding: 12px 30px; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; }
        .action-btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .action-btn-primary:hover { opacity: 0.9; }
        .action-btn-secondary { background: #fff; color: #667eea; border: 2px solid #667eea; }
        .action-btn-secondary:hover { background: #f0f0ff; }
        .action-btn-danger { background: #e74c3c; color: white; }
        .action-btn-danger:hover { background: #c0392b; }

        .section { background: white; border-radius: 10px; padding: 20px; margin-bottom: 20px; }
        .section-title { font-size: 20px; font-weight: bold; color: #333; margin-bottom: 20px; }
        
        .chapter-list { list-style: none; }
        .chapter-item { padding: 12px 15px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        .chapter-item:last-child { border-bottom: none; }
        .chapter-item:hover { background: #f8f9fa; }
        .chapter-link { text-decoration: none; color: #333; flex: 1; }
        .chapter-number { color: #999; font-size: 14px; margin-right: 10px; }
        .chapter-free { color: #2ecc71; font-size: 12px; padding: 2px 8px; background: #e8f5e9; border-radius: 3px; }
        .chapter-price { color: #e74c3c; font-size: 12px; }

        .comment-list { list-style: none; }
        .comment-item { padding: 15px 0; border-bottom: 1px solid #eee; }
        .comment-item:last-child { border-bottom: none; }
        .comment-header { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .comment-author { font-weight: bold; color: #333; }
        .comment-time { color: #999; font-size: 12px; }
        .comment-content { color: #555; line-height: 1.6; }
        .comment-rating { color: #f39c12; }

        .comment-form { margin-top: 20px; }
        .comment-textarea { width: 100%; padding: 15px; border: 1px solid #ddd; border-radius: 5px; resize: vertical; min-height: 100px; }
        .rating-group { margin-bottom: 15px; }
        .rating-label { margin-right: 10px; color: #666; }
        .rating-star { font-size: 20px; color: #ddd; cursor: pointer; }
        .rating-star.active, .rating-star:hover { color: #f39c12; }

        footer { background: #333; color: white; padding: 30px 0; text-align: center; margin-top: 40px; }

        /* 弹窗样式 */
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center; }
        .modal.show { display: flex; }
        .modal-content { background: white; padding: 30px; border-radius: 10px; max-width: 400px; width: 90%; text-align: center; }
        .modal-title { font-size: 20px; font-weight: bold; margin-bottom: 15px; color: #333; }
        .modal-text { color: #666; margin-bottom: 20px; line-height: 1.6; }
        .modal-balance { font-size: 18px; color: #667eea; font-weight: bold; margin: 15px 0; }
        .modal-buttons { display: flex; gap: 15px; justify-content: center; }
        .modal-btn { padding: 12px 30px; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; text-decoration: none; display: inline-block; }
        .modal-btn-primary { background: #667eea; color: white; }
        .modal-btn-primary:hover { background: #5568d3; }
        .modal-btn-secondary { background: #e0e0e0; color: #333; }
        .modal-btn-secondary:hover { background: #d0d0d0; }
        .modal-btn-danger { background: #e74c3c; color: white; }
        .modal-btn-danger:hover { background: #c0392b; }
        .modal-btn-link { background: #2ecc71; color: white; }
        .modal-btn-link:hover { background: #27ae60; }

        /* 提示消息样式 */
        .alert { padding: 15px 20px; border-radius: 5px; margin-bottom: 20px; text-align: center; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
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

    <div class="container">
        <c:if test="${param.success == 'purchased'}">
            <div class="alert alert-success">✓ 购买成功！您现在可以阅读本书了。</div>
        </c:if>
        <c:if test="${param.error == 'insufficient'}">
            <div class="alert alert-error">⚠️ 余额不足，无法购买此书。请先充值后再试。</div>
        </c:if>
        <c:if test="${param.error == 'not_purchased'}">
            <div class="alert alert-error">⚠️ 您还没有购买此书，无法阅读付费内容。请先购买后再试。</div>
        </c:if>

        <div class="book-detail">
            <div class="book-cover-large">
                <c:choose>
                    <c:when test="${not empty book.coverImage}">
                        <img src="${book.coverImage}" alt="${book.title}" onerror="this.parentElement.innerHTML='<span style=font-size:64px;text-align:center;display:flex;align-items:center;justify-content:center;height:100%;>📖</span>'">
                    </c:when>
                    <c:otherwise>
                        <span style="font-size:64px;text-align:center;display:flex;align-items:center;justify-content:center;height:100%;">📖</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="book-info">
                <h1 class="book-title">${book.title}</h1>
                <div class="book-meta">
                    <span>作者：${book.author}</span>
                    <span>分类：${book.categoryName}</span>
                    <span>状态：<c:if test="${book.status == 1}">连载中</c:if><c:if test="${book.status == 2}">已完结</c:if></span>
                </div>
                <div class="book-description">
                    <strong>内容简介：</strong><br>${book.description}
                </div>
                <div class="book-stats">
                    <div class="stat-item">
                        <div class="stat-value">${book.viewCount}</div>
                        <div class="stat-label">阅读量</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">${book.favoriteCount}</div>
                        <div class="stat-label">收藏数</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">${book.rating}</div>
                        <div class="stat-label">评分</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">${book.chapterCount}</div>
                        <div class="stat-label">章节数</div>
                    </div>
                </div>
                <div class="action-bar">
                    <c:choose>
                        <c:when test="${book.isFree == 1}">
                            <a href="/books/read/${book.id}" class="action-btn action-btn-primary">
                                📖 立即阅读
                            </a>
                        </c:when>
                        <c:when test="${hasPurchased || isAuthor}">
                            <a href="/books/read/${book.id}" class="action-btn action-btn-primary">
                                📖 立即阅读
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button onclick="showPurchaseConfirm()" class="action-btn action-btn-primary">
                                📖 立即阅读
                            </button>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${userId != null}">
                        <a href="/user/toggle-favorite/${book.id}" class="action-btn action-btn-secondary">
                            ${isFavorited ? '❤️ 已收藏' : '🤍 收藏'}
                        </a>
                    </c:if>
                    <c:if test="${book.isFree != 1 && userId != null && !hasPurchased && !isAuthor}">
                        <button onclick="showPurchaseConfirm()" class="action-btn action-btn-danger">
                            💰 购买 ¥${book.price}
                        </button>
                    </c:if>
                    <c:if test="${book.isFree != 1 && userId == null}">
                        <a href="/login?redirect=/books/${book.id}" class="action-btn action-btn-danger">
                            💰 购买 ¥${book.price}
                        </a>
                    </c:if>
                </div>
                <c:if test="${userId != null}">
                    <div style="color: #666; font-size: 14px; margin-top: 10px;">
                        当前余额：¥${userBalance}
                        <c:if test="${hasPurchased == true}">
                            <span style="color: #2ecc71; margin-left: 15px;">✓ 已购买</span>
                        </c:if>
                        <c:if test="${isAuthor == true}">
                            <span style="color: #2ecc71; margin-left: 15px;">✓ 作者免费阅读</span>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="section">
            <h2 class="section-title">📑 章节列表</h2>
            <ul class="chapter-list">
                <c:forEach items="${chapters}" var="chapter">
                    <li class="chapter-item">
                        <c:choose>
                            <c:when test="${book.isFree == 1 || chapter.isFree == 1 || hasPurchased || isAuthor}">
                                <a href="/books/read/${book.id}/${chapter.id}" class="chapter-link">
                                    <span class="chapter-number">第${chapter.chapterNumber}章</span>
                                    ${chapter.title}
                                </a>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${userId != null}">
                                        <a href="javascript:void(0)" onclick="showPurchaseConfirm()" class="chapter-link chapter-locked">
                                            <span class="chapter-number">第${chapter.chapterNumber}章</span>
                                            ${chapter.title}
                                            <span style="color: #999; font-size: 12px; margin-left: 10px;">(需要购买)</span>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/login?redirect=/books/${book.id}" class="chapter-link chapter-locked">
                                            <span class="chapter-number">第${chapter.chapterNumber}章</span>
                                            ${chapter.title}
                                            <span style="color: #999; font-size: 12px; margin-left: 10px;">(需要购买)</span>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        <span>
                            <c:if test="${chapter.isFree == 1}">
                                <span class="chapter-free">免费</span>
                            </c:if>
                            <c:if test="${chapter.isFree != 1}">
                                <span class="chapter-price">¥${chapter.price}</span>
                            </c:if>
                            <c:if test="${isAuthor == true}">
                                <button onclick="deleteChapter(${chapter.id}, ${book.id})" class="chapter-delete">删除</button>
                            </c:if>
                        </span>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="section">
            <h2 class="section-title">💬 读者评论 (${commentCount})</h2>
            <c:if test="${userId != null}">
                <form action="/books/${book.id}/comment" method="post" class="comment-form">
                    <div class="rating-group">
                        <span class="rating-label">评分：</span>
                        <span class="rating-star" data-rating="1">★</span>
                        <span class="rating-star" data-rating="2">★</span>
                        <span class="rating-star" data-rating="3">★</span>
                        <span class="rating-star" data-rating="4">★</span>
                        <span class="rating-star" data-rating="5">★</span>
                        <input type="hidden" name="rating" id="rating-input" value="5">
                    </div>
                    <textarea name="content" class="comment-textarea" placeholder="写下你的评论..."></textarea>
                    <button type="submit" class="action-btn action-btn-primary" style="margin-top: 10px;">发表评论</button>
                </form>
            </c:if>
            <c:if test="${userId == null}">
                <p style="color: #999;">请先<a href="/login?redirect=/books/${book.id}">登录</a>后发表评论</p>
            </c:if>
            
            <ul class="comment-list">
                <c:forEach items="${comments}" var="comment">
                    <li class="comment-item">
                        <div class="comment-header">
                            <span class="comment-author">${comment.userNickname}</span>
                            <span class="comment-time">${comment.createTime}</span>
                        </div>
                        <div class="comment-rating">
                            <c:forEach begin="1" end="5" var="i">
                                <c:if test="${i <= comment.rating}">★</c:if>
                                <c:if test="${i > comment.rating}">☆</c:if>
                            </c:forEach>
                        </div>
                        <div class="comment-content">${comment.content}</div>
                    </li>
                </c:forEach>
            </ul>
            <c:if test="${empty comments}">
                <p style="text-align: center; color: #999; padding: 20px;">暂无评论，快来发表第一条评论吧！</p>
            </c:if>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>

    <!-- 购买确认弹窗 -->
    <div id="purchaseModal" class="modal">
        <div class="modal-content">
            <div class="modal-title">📖 购买提示</div>
            <div class="modal-text">
                您即将购买《${book.title}》
            </div>
            <div class="modal-balance">
                价格：¥${book.price}<br>
                当前余额：¥${userBalance}
            </div>
            <div class="modal-buttons">
                <a href="/books/purchase/${book.id}" class="modal-btn modal-btn-primary">确认购买</a>
                <button onclick="closeModal('purchaseModal')" class="modal-btn modal-btn-secondary">取消</button>
            </div>
        </div>
    </div>

    <!-- 余额不足弹窗 -->
    <div id="insufficientModal" class="modal">
        <div class="modal-content">
            <div class="modal-title">⚠️ 余额不足</div>
            <div class="modal-text">
                购买此书需要 ¥${book.price}<br>
                您当前的余额为 ¥${userBalance}
            </div>
            <div class="modal-balance" style="color: #e74c3c;">
                还需要：¥${book.price - userBalance}
            </div>
            <div class="modal-buttons">
                <a href="/user/recharge" class="modal-btn modal-btn-link">去充值</a>
                <button onclick="closeModal('insufficientModal')" class="modal-btn modal-btn-secondary">取消</button>
            </div>
        </div>
    </div>

    <script>
        // 显示购买确认弹窗
        function showPurchaseConfirm() {
            var bookPrice = ${book.price != null ? book.price : 0};
            var userBalance = ${userBalance != null ? userBalance : 0};

            if (typeof bookPrice === 'string') {
                bookPrice = parseFloat(bookPrice);
            }
            if (typeof userBalance === 'string') {
                userBalance = parseFloat(userBalance);
            }

            if (userBalance < bookPrice) {
                document.getElementById('insufficientModal').classList.add('show');
            } else {
                document.getElementById('purchaseModal').classList.add('show');
            }
        }

        // 关闭弹窗
        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('show');
        }

        // 点击弹窗外部关闭
        window.onclick = function(event) {
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('show');
            }
        }

        // 评分功能
        document.querySelectorAll('.rating-star').forEach(star => {
            star.addEventListener('click', function() {
                const rating = this.dataset.rating;
                document.querySelectorAll('.rating-star').forEach(s => {
                    s.classList.toggle('active', parseInt(s.dataset.rating) <= parseInt(rating));
                });
                document.getElementById('rating-input').value = rating;
            });
        });

        // 检查错误状态并显示相应弹窗
        document.addEventListener('DOMContentLoaded', function() {
            var urlParams = new URLSearchParams(window.location.search);
            var error = urlParams.get('error');

            if (error === 'insufficient') {
                document.getElementById('insufficientModal').classList.add('show');
            } else if (error === 'not_purchased') {
                // 显示未购买提示后自动显示购买确认弹窗
                setTimeout(function() {
                    showPurchaseConfirm();
                }, 100);
            }

            // 清除URL参数（保留其他参数）
            if (error) {
                urlParams.delete('error');
                urlParams.delete('success');
                var newUrl = window.location.pathname;
                if (urlParams.toString()) {
                    newUrl += '?' + urlParams.toString();
                }
                window.history.replaceState({}, document.title, newUrl);
            }
        });

        // 删除章节
        function deleteChapter(chapterId, bookId) {
            if (confirm('确定要删除该章节吗？此操作无法恢复！')) {
                window.location.href = '/user/delete-chapter/' + chapterId + '?bookId=' + bookId;
            }
        }
    </script>
</body>
</html>