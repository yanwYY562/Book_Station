<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改用户余额 - 悦读书城管理后台</title>
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

        .form-container { max-width: 500px; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #666; font-weight: bold; }
        .form-group input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 16px; }
        .form-group .info { color: #999; font-size: 14px; margin-top: 5px; }
        .form-group .current-balance { font-size: 24px; color: #f39c12; font-weight: bold; }

        .btn-group { display: flex; gap: 15px; margin-top: 30px; }
        .submit-btn { flex: 1; padding: 12px; background: #667eea; color: white; border: none; border-radius: 8px; font-size: 16px; cursor: pointer; }
        .submit-btn:hover { background: #5a6fd6; }
        .cancel-btn { padding: 12px 30px; background: #ddd; color: #333; border: none; border-radius: 8px; cursor: pointer; }
        .cancel-btn:hover { background: #ccc; }

        .success-msg { background: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px; }

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
                <h1 class="page-title">💰 修改用户余额</h1>
                <a href="/admin/users" class="back-link">← 返回用户列表</a>
            </div>

            <div class="form-container">
                <c:if test="${success != null}">
                    <div class="success-msg">✓ 余额修改成功！</div>
                </c:if>
                
                <form action="/admin/users/balance/${user.id}/update" method="post">
                    <div class="form-group">
                        <label>用户信息</label>
                        <div style="padding: 12px; background: #f8f9fa; border-radius: 8px;">
                            <div>用户名：${user.username}</div>
                            <div>昵称：${user.nickname}</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>当前余额</label>
                        <div class="current-balance">¥${user.balance}</div>
                    </div>

                    <div class="form-group">
                        <label>新余额</label>
                        <input type="number" name="balance" value="${user.balance}" step="0.01" required>
                        <div class="info">请输入新的余额金额（保留两位小数）</div>
                    </div>

                    <div class="btn-group">
                        <button type="submit" class="submit-btn">确认修改</button>
                        <a href="/admin/users" class="cancel-btn">取消</a>
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