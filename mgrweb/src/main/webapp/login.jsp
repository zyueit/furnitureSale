<%--
  Created by IntelliJ IDEA.
  User: QQ
  Date: 2018/3/24
  Time: 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MingMini家具后台管理系统登录</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/views/login.js"></script>

    <style type="text/css">
        body {
            font-family: '微软雅黑', serif;
            background: rgb(192, 192, 192, .3);
            background-size: cover;
        }

        /* 水平居中 */
        .vertical-center {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -70%);
        }
    </style>
</head>
<body>
<%-- 解决单独的js文件获取上下文路径问题 --%>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">

<div class="vertical-center" style="width: 470px;text-align: center;border: solid 1px rgb(0,0,0,.1);">
    <img src="${pageContext.request.contextPath}/img/logo_sm.png" alt="logo">
    <span style="font-size: 20px;color: rgb(0,0,0,.5)">家具销售后台管理系统登录</span>
    <HR width="100%" style="border-color: rgb(0,0,0,.1)" SIZE=5>
    <span id="msg" style="display: none;"></span>
    <div style="width: 60%;margin: 40px 0 0 20%;text-align: center;">
        <form id="loginForm">
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
                        <span class="glyphicon glyphicon-eye-close"></span>
                    </div>
                    <input type="password" name="password" class="form-control" placeholder="密码">
                </div>
            </div>
            <div class="form-group">
                <input type="submit" id="login_btn" class="btn btn-info" value="登录"/>
                <input type="reset" class="btn btn-info" value="重置">
            </div>
        </form>
    </div>
</div>
</body>
</html>