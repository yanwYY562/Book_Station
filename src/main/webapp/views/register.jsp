<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>注册 - 悦读书城</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .register-container { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); width: 400px; }
        .logo { text-align: center; margin-bottom: 30px; }
        .logo span { font-size: 48px; }
        .logo h1 { color: #667eea; margin-top: 10px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; }
        .form-group input { width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 16px; transition: border-color 0.3s; }
        .form-group input:focus { outline: none; border-color: #667eea; }
        .error { color: #e74c3c; text-align: center; margin-bottom: 15px; }
        .register-btn { width: 100%; padding: 12px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 8px; font-size: 16px; cursor: pointer; margin-bottom: 20px; }
        .links { text-align: center; }
        .links a { color: #667eea; text-decoration: none; }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="logo">
            <span>📚</span>
            <h1>悦读书城</h1>
        </div>
        
        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>
        
        <form action="/register" method="post">
            <div class="form-group">
                <label>用户名</label>
                <input type="text" name="username" placeholder="请输入用户名" required>
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" name="password" placeholder="请输入密码" required>
            </div>
            <div class="form-group">
                <label>邮箱</label>
                <input type="email" name="email" placeholder="请输入邮箱">
            </div>
            <div class="form-group">
                <label>昵称</label>
                <input type="text" name="nickname" placeholder="请输入昵称" required>
            </div>
            <button type="submit" class="register-btn">注册</button>
        </form>
        
        <div class="links">
            <a href="/login">已有账号？立即登录</a>
        </div>
    </div>
</body>
</html>