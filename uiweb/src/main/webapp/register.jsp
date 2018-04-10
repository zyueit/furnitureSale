<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户注册-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <script src="${pageContext.request.contextPath}/js/views/register.js"></script>
    <style>
        .box {
            width: 500px;
            height: 500px;
            border-radius: 250px;
            background-color: white;
            padding: 35px;
            text-align: center;
        }
    </style>
</head>
<body>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">

<div class="vertical-center box">
    <a href="${pageContext.request.contextPath}/index" title="首页">
        <img src="${pageContext.request.contextPath}/img/logo_sm.png" width="200" height="50" alt="logo" align="center">
    </a>
    <HR width="80%" SIZE=5>
    <div class="center-block" style="width: 60%;">
        <form id="registerForm">
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-user"></span>
                    </div>
                    <input type="text" name="username" class="form-control" placeholder="用户名">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-phone"></span>
                    </div>
                    <input type="text" name="phone" class="form-control" placeholder="手机号码验证">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-wrench"></span>
                    </div>
                    <input type="text" name="code" class="form-control" placeholder="验证码">
                    <span class="input-group-btn">
						<button type="button" class="btn btn-info">获取验证码</button>
					</span>
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-eye-close"></span>
                    </div>
                    <input type="password" id="password" name="password" autocomplete="off" class="form-control"
                           placeholder="密码">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-eye-close"></span>
                    </div>
                    <input type="password" name="repasswd" autocomplete="off" class="form-control" placeholder="确认密码">
                </div>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-default" value="注册">
                <input type="reset" class="btn btn-default" value="重置">
            </div>
        </form>
        <HR width="60%" SIZE=5>
        已有账号？<a href="${pageContext.request.contextPath}/login.jsp">请登录</a>
    </div>
</div>
</body>
</html>
