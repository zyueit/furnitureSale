<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户登陆-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        .box {
            width: 400px;
            height: 400px;
            border-radius: 200px;
            background-color: white;
            padding: 35px;
            text-align: center;
        }
    </style>

    <script>
        $(function () {
            var loginForm = $("#loginForm");
            loginForm.validate({
                errorPlacement: function (error, element) {
                    $(element).prop('placeholder', error[0].innerHTML);
                },
                highlight: function (element) {
                    $(element).closest('.form-group').addClass('has-error');
                },
                unhighlight: function (element) {
                    $(element).closest('.form-group').removeClass('has-error');
                },
                rules: {
                    username: 'required',
                    password: 'required'
                },
                messages: {
                    username: '请输入账号！',
                    password: '请输入密码！'
                },
                submitHandler: function () {
                    $.ajax({
                        type: 'post',
                        data: loginForm.serialize(),
                        dataType: 'json',
                        url: '${pageContext.request.contextPath}/loginCheck',
                        success: function (data) {
                            if (data.success) {
                                window.location.href = '${pageContext.request.contextPath}/index';
                            } else {
                                layer.open({
                                    title: '温馨提示',
                                    icon: 5,
                                    content: data.msg
                                });
                            }
                        }
                    });
                }
            });
        });
    </script>
</head>
<body>
<div class="vertical-center box">
    <a href="${pageContext.request.contextPath}/index" title="首页">
        <img src="${pageContext.request.contextPath}/img/logo_sm.png" width="200" height="50" alt="logo" align="center">
    </a>
    <HR width="80%" SIZE=5>
    <p class="text-info">
        没有账号？
        <a href="${pageContext.request.contextPath}/register.jsp"><b>注册&raquo;</b></a>
        &ensp;送30天无限制<b>免费运输</b>
    </p>
    <HR width="80%" SIZE=5>
    <div class="center-block" style="width: 60%;">
        <form id="loginForm">
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-user"></span>
                    </div>
                    <input type="text" name="username" class="form-control" placeholder="用户名或手机号码">
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
                <button type="submit" class="btn btn-default">登陆</button>
                <button type="reset" class="btn btn-default">重置</button>
            </div>
        </form>
        <HR width="60%" SIZE=5>
        <a href="${pageContext.request.contextPath}/resetpassword.jsp">忘记密码？</a>
    </div>
</div>
</body>
</html>