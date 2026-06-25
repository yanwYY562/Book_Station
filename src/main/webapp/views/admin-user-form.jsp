<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${user != null ? '编辑用户' : '添加用户'} - 悦读书城管理后台</title>
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

        .form-container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); max-width: 600px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
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
                <h1 class="page-title">👥 ${user != null ? '编辑用户' : '添加用户'}</h1>
                <a href="/admin/users" class="back-link">← 返回列表</a>
            </div>

            <div class="form-container">
                <form action="${user != null ? '/admin/users/update' : '/admin/users/save'}" method="post">
                    <input type="hidden" name="id" value="${user != null ? user.id : ''}">
                    
                    <div class="form-group">
                        <label>用户名 *</label>
                        <input type="text" name="username" value="${user != null ? user.username : ''}" required>
                    </div>

                    <c:if test="${user == null}">
                        <div class="form-group">
                            <label>密码 *</label>
                            <input type="password" name="password" required>
                        </div>
                    </c:if>

                    <div class="form-row">
                        <div class="form-group">
                            <label>昵称</label>
                            <input type="text" name="nickname" value="${user != null ? user.nickname : ''}">
                        </div>
                        <div class="form-group">
                            <label>邮箱</label>
                            <input type="email" name="email" value="${user != null ? user.email : ''}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>手机号</label>
                        <input type="tel" name="phone" value="${user != null ? user.phone : ''}">
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>角色</label>
                            <select name="role">
                                <option value="user" ${user != null && user.role == 'user' ? 'selected' : ''}>普通用户</option>
                                <option value="admin" ${user != null && user.role == 'admin' ? 'selected' : ''}>管理员</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>状态</label>
                            <select name="status">
                                <option value="1" ${user != null && user.status == 1 ? 'selected' : ''}>正常</option>
                                <option value="0" ${user != null && user.status == 0 ? 'selected' : ''}>禁用</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="submit-btn">保存</button>
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