<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>用户管理 - 悦读书城管理后台</title>
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

        .table-container { background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); overflow: hidden; }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        .data-table th { background: #f8f9fa; font-weight: bold; color: #333; }
        .data-table tr:hover { background: #f8f9fa; }

        .action-links { display: flex; gap: 10px; }
        .action-link { padding: 5px 12px; text-decoration: none; border-radius: 4px; font-size: 13px; }
        .action-link.edit { background: #3498db; color: white; }
        .action-link.delete { background: #e74c3c; color: white; }
        .action-link.balance { background: #f39c12; color: white; }

        .status-badge { padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }

        .role-admin { color: #e74c3c; font-weight: bold; }
        .role-user { color: #3498db; }

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
                <li><a href="/admin/users" class="active"><span class="menu-icon">👥</span> 用户管理</a></li>
                <li><a href="/admin/comments"><span class="menu-icon">💬</span> 评论管理</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">👥 用户管理</h1>
                <a href="/admin/users/add" class="add-btn">+ 添加用户</a>
            </div>

            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>昵称</th>
                            <th>邮箱</th>
                            <th>角色</th>
                            <th>会员等级</th>
                            <th>余额</th>
                            <th>状态</th>
                            <th>注册时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.nickname}</td>
                                <td>${user.email}</td>
                                <td>
                                    <span class="${user.role == 'admin' ? 'role-admin' : 'role-user'}">
                                        ${user.role == 'admin' ? '管理员' : '普通用户'}
                                    </span>
                                </td>
                                <td>${user.vipLevel == 0 ? '普通' : 'VIP'}</td>
                                <td style="color: #f39c12; font-weight: bold;">¥${user.balance}</td>
                                <td>
                                    <span class="status-badge ${user.status == 1 ? 'status-active' : 'status-inactive'}">
                                        ${user.status == 1 ? '正常' : '禁用'}
                                    </span>
                                </td>
                                <td>
                                    <c:if test="${user.createTime != null}">
                                        <fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd"/>
                                    </c:if>
                                </td>
                                <td>
                                    <div class="action-links">
                                        <a href="/admin/users/edit/${user.id}" class="action-link edit">编辑</a>
                                        <a href="/admin/users/balance/${user.id}" class="action-link balance">修改余额</a>
                                        <a href="/admin/users/delete/${user.id}" class="action-link delete" onclick="return confirm('确定删除该用户吗？')">删除</a>
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