<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>用户中心 - 悦读书城</title>
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
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .info-item { padding: 15px; background: #f8f9fa; border-radius: 8px; }
        .info-label { color: #999; font-size: 14px; margin-bottom: 5px; }
        .info-value { color: #333; font-size: 16px; }

        .edit-btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; float: right; }
        .edit-btn:hover { background: #5a6fd6; }
        .save-btn { padding: 12px 30px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .save-btn:hover { background: #5a6fd6; }
        .cancel-btn { padding: 12px 30px; background: #ddd; color: #333; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px; }
        .cancel-btn:hover { background: #ccc; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #666; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .success-msg { color: #2e7d32; margin-bottom: 20px; padding: 10px; background: #e8f5e9; border-radius: 5px; }

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
                    <div class="username">${user.nickname}</div>
                </div>
                <ul class="user-menu">
                    <li><a href="/user/profile" class="active">👤 个人资料</a></li>
                    <li><a href="/user/my-books">📚 我的作品</a></li>
                    <li><a href="/user/my-books">📤 上传图书</a></li>
                    <li><a href="/user/my-books">📝 上传章节</a></li>
                    <li><a href="/user/recharge">💰 账户充值</a></li>
                    <li><a href="/user/favorites">❤️ 我的收藏</a></li>
                    <li><a href="/user/reading-history">📖 阅读记录</a></li>
                    <li><a href="/user/comments">💬 我的评论</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="page-title">👤 个人资料 <button class="edit-btn" onclick="showEditForm()">编辑资料</button></div>
                
                <c:if test="${success != null}">
                    <div class="success-msg">✓ 修改成功！</div>
                </c:if>
                
                <div id="viewMode">
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">用户名</div>
                            <div class="info-value">${user.username}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">昵称</div>
                            <div class="info-value">${user.nickname}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">邮箱</div>
                            <div class="info-value">${user.email}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">手机号</div>
                            <div class="info-value">${user.phone}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">用户角色</div>
                            <div class="info-value">${user.role == 'admin' ? '管理员' : '普通用户'}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">会员等级</div>
                            <div class="info-value">${user.vipLevel == 0 ? '普通会员' : 'VIP会员'}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">账户余额</div>
                            <div class="info-value">¥${user.balance}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">注册时间</div>
                            <div class="info-value">
                                <c:if test="${user.createTime != null}">
                                    <fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id="editMode" style="display: none;">
                    <form action="/user/profile/update" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label>昵称</label>
                                <input type="text" name="nickname" value="${user.nickname}" required>
                            </div>
                            <div class="form-group">
                                <label>邮箱</label>
                                <input type="email" name="email" value="${user.email}" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>手机号</label>
                                <input type="tel" name="phone" value="${user.phone}">
                            </div>
                            <div class="form-group">
                                <label>新密码（不填则不修改）</label>
                                <input type="password" name="password" placeholder="请输入新密码">
                            </div>
                        </div>
                        <div style="text-align: right; margin-top: 20px;">
                            <button type="button" class="cancel-btn" onclick="hideEditForm()">取消</button>
                            <button type="submit" class="save-btn">保存修改</button>
                        </div>
                    </form>
                </div>
            </div>
            
            <script>
                function showEditForm() {
                    document.getElementById('viewMode').style.display = 'none';
                    document.getElementById('editMode').style.display = 'block';
                }
                function hideEditForm() {
                    document.getElementById('editMode').style.display = 'none';
                    document.getElementById('viewMode').style.display = 'grid';
                }
            </script>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>
</body>
</html>