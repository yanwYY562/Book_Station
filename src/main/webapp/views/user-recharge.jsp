<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>账户充值 - 悦读书城</title>
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
        
        .balance-info { background: linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%); padding: 20px; border-radius: 10px; margin-bottom: 30px; }
        .balance-label { color: #999; font-size: 14px; margin-bottom: 5px; }
        .balance-amount { font-size: 36px; font-weight: bold; color: #ff9800; }
        
        .recharge-form { max-width: 500px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #666; font-weight: bold; }
        .amount-options { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; }
        .amount-btn { padding: 15px; border: 2px solid #ddd; border-radius: 8px; background: white; cursor: pointer; transition: all 0.3s; font-size: 16px; }
        .amount-btn:hover { border-color: #667eea; }
        .amount-btn.selected { border-color: #667eea; background: #e8f5e9; color: #667eea; }
        .custom-amount { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 16px; }
        
        .recharge-btn { width: 100%; padding: 15px; background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%); color: white; border: none; border-radius: 8px; font-size: 18px; font-weight: bold; cursor: pointer; }
        .recharge-btn:hover { opacity: 0.9; }
        
        .tips { background: #e3f2fd; padding: 15px; border-radius: 8px; margin-top: 20px; color: #1976d2; font-size: 14px; }

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
                    <li><a href="/user/profile">👤 个人资料</a></li>
                    <li><a href="/user/recharge" class="active">💰 账户充值</a></li>
                    <li><a href="/user/favorites">❤️ 我的收藏</a></li>
                    <li><a href="/user/reading-history">📖 阅读记录</a></li>
                    <li><a href="/user/comments">💬 我的评论</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="page-title">💰 账户充值</div>
                
                <c:if test="${showMessage != null}">
                    <div style="background: #fff3e0; padding: 15px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                        <div style="font-size: 24px; margin-bottom: 10px;">⚠️</div>
                        <div style="color: #ff9800; font-weight: bold;">充值提示</div>
                        <div style="color: #666; margin-top: 5px;">您请求充值 ¥${rechargeAmount}</div>
                        <div style="color: #999; font-size: 14px; margin-top: 5px;">当前充值功能暂未开通，实际余额需由管理员在后台进行修改。</div>
                    </div>
                </c:if>
                
                <div class="balance-info">
                    <div class="balance-label">当前账户余额</div>
                    <div class="balance-amount">¥${user.balance}</div>
                </div>
                
                <form class="recharge-form" action="/user/recharge/submit" method="post">
                    <div class="form-group">
                        <label>选择充值金额</label>
                        <div class="amount-options">
                            <button type="button" class="amount-btn" onclick="selectAmount(10)">¥10</button>
                            <button type="button" class="amount-btn" onclick="selectAmount(20)">¥20</button>
                            <button type="button" class="amount-btn" onclick="selectAmount(50)">¥50</button>
                            <button type="button" class="amount-btn" onclick="selectAmount(100)">¥100</button>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>自定义金额</label>
                        <input type="number" class="custom-amount" name="amount" id="customAmount" placeholder="请输入充值金额（元）" min="1">
                    </div>
                    
                    <button type="submit" class="recharge-btn">立即充值</button>
                </form>
                
                <div class="tips">
                    <strong>温馨提示：</strong>当前充值功能仅为演示，实际余额需由管理员在后台进行修改。如有充值需求，请联系客服。
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 悦读书城 - 让阅读成为一种习惯</p>
    </footer>

    <script>
        function selectAmount(amount) {
            document.getElementById('customAmount').value = amount;
            document.querySelectorAll('.amount-btn').forEach(btn => btn.classList.remove('selected'));
            event.target.classList.add('selected');
        }
    </script>
</body>
</html>