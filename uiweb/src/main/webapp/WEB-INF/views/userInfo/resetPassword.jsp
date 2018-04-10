<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改密码-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
</head>

<script>
    $(function () {
        var basePath = $("#basePath").val();
        var resetPasswordForm = $("#resetPasswordForm");
        resetPasswordForm.validate({
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
                oldpassword: 'required',
                newpassword: 'required',
                repasswd: {
                    required: true,
                    equalTo: '#password'
                }
            },
            messages: {
                oldpassword: '该项必填！',
                newpassword: '该项必填！',
                repasswd: '新密码两次输入不一致！'
            },
            submitHandler: function () {
                $.ajax({
                    type: 'post',
                    data: resetPasswordForm.serialize(),
                    dataType: 'json',
                    url: basePath + '/user/resetPassword',
                    success: function (data) {
                        if (data.success) {
                            layer.open({
                                title: '温馨提示',
                                icon: 6,
                                content: data.msg,
                                btn: '重新登陆',
                                yes: toLogin,
                                cancel: toLogin
                            });
                        } else {
                            layer.open({
                                title: '温馨提示',
                                icon: 5,
                                content: data.msg
                            });
                        }
                    },
                    error: function () {
                        window.open(basePath + "/login.jsp");
                    }
                });
            }
        });

        function toLogin(index) {
            layer.close(index);
            location.reload();
        }
    });
</script>

<body>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">

<%@ include file="/WEB-INF/views/common/person-header.jsp" %>
<div class="container" style="padding: 0 8%;">
    <div class="row" style="margin: 20px 0;">
        <div class="col-sm-offset-2 col-sm-8" style="padding: 10px 15px;">
            <div class="col-sm-12">
                <fieldset>
                    <legend style="font-size: 14px;padding-left: 10px;">修改密码</legend>
                    <div style="margin-left: 110px;">
                        <form id="resetPasswordForm">
                            <input type="hidden" name="id" value="${sessionScope[UserContext.USERINFO_IN_SESSION].id}">
                            <div class="form-group row">
                                <div class="col-sm-3">
                                    <label class="control-label">原来密码</label>
                                </div>
                                <div class="col-sm-5" style="padding-left: 0;">
                                    <input name="oldpassword" type="password" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3">
                                    <label class="control-label">新密码</label>
                                </div>
                                <div class="col-sm-5" style="padding-left: 0;">
                                    <input id="password" name="newpassword" type="password" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3">
                                    <label class="control-label">确认新密码</label>
                                </div>
                                <div class="col-sm-5" style="padding-left: 0;">
                                    <input name="repasswd" type="password" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-offset-3">
                                    <button type="submit" class="btn btn-default">确认修改</button>
                                    <button type="reset" class="btn btn-default">重置</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<div style="width: 100%;position: absolute;bottom: 0;left: 0;">
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
</html>