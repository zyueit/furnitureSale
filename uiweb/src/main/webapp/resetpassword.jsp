<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>密码重置-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        .box {
            width: 400px;
            height: 400px;
            border-radius: 240px;
            background-color: white;
            padding-top: 35px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="vertical-center box">
    <a href="${pageContext.request.contextPath}/index" title="首页">
        <img src="${pageContext.request.contextPath}/img/logo_sm.png" width="200" height="50" alt="logo" align="center">
    </a>
    <HR width="80%" SIZE=5>
    <div class="center-block" style="width: 60%;">
        <form action="">
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-user"></span>
                    </div>
                    <input type="text" class="form-control" placeholder="用户名">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-phone"></span>
                    </div>
                    <input type="text" class="form-control" placeholder="手机号码验证">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-wrench"></span>
                    </div>
                    <input type="text" class="form-control" placeholder="验证码">
                    <span class="input-group-btn">
						<button class="btn btn-info">获取验证码</button>
					</span>
                </div>
            </div>
            <div class="form-group">
                <button class="btn btn-default">密码重置</button>
            </div>
        </form>
        <HR width="60%" SIZE=5>
        <a href="javascript:history.back()">返回登录</a>
    </div>
</div>
</body>
</html>