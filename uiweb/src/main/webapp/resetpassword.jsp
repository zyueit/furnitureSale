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
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>

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

    <script>
        $(function () {
            var basePath = $("#basePath").val();
            var resetPasswordForm = $("#resetPasswordForm");

            <!--自定义校验规则-->
            $.validator.addMethod("phone", function (value, element) {
                var length = value.length;
                var mobile = /^[1][3,4,5,7,8][0-9]{9}$/;
                return this.optional(element) || (length === 11 && mobile.test(value));
            }, "请正确填写您的手机号码");

            function toLogin(index) {
                layer.close(index);
                window.location.href = basePath + '/login.jsp';
            }

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
                    phone: {
                        required: true,
                        phone: true
                    },
                    code: 'required'
                },
                messages: {
                    phone: {
                        required: '手机号码不能为空！',
                        phone: '请正确填写您的手机号码！'
                    },
                    code: '必填！'
                },
                submitHandler: function () {
                    $.ajax({
                        type: 'get',
                        data: resetPasswordForm.serialize(),
                        dataType: 'json',
                        url: basePath + '/resetPassword',
                        success: function (data) {
                            if (data.success) {
                                layer.open({
                                    title: '温馨提示',
                                    icon: 6,
                                    content: data.msg,
                                    btn: '去登陆！',
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
                        }
                    });
                }
            });

            $("button").click(function () {
                var that = this;//保存当前按钮的jQuery对象

                //检查是否填写了手机号码
                var phone = $(":input[name='phone']").val();
                if (!phone) {
                    layer.open({
                        title: '温馨提示',
                        icon: 5,
                        content: '请先填写手机号码！'
                    });
                    return;
                }
                //发送验证码
                $.ajax({
                    type: 'get',
                    data: {phone: phone},
                    dataType: 'json',
                    url: basePath + '/getCheckCode',
                    success: function (data) {
                        if (data.success) {
                            setTime(that);
                        } else {
                            layer.open({
                                title: '温馨提示',
                                icon: 5,
                                content: data.msg
                            });
                        }
                    }
                });
            });
        });

        //设置获取验证码为60秒一次
        var countdown = 60;

        function setTime(element) {
            if (countdown === 0) {
                element.removeAttribute("disabled");
                element.innerHTML = "获取验证码";
                countdown = 60;
                return;
            } else {
                element.setAttribute("disabled", true);
                element.innerHTML = "重新发送(" + countdown + ")";
                countdown--;
            }
            setTimeout(function () {
                setTime(element)
            }, 1000)
        }
    </script>
</head>
<body>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">

<div class="vertical-center box">
    <a href="${pageContext.request.contextPath}/index" title="首页">
        <img src="${pageContext.request.contextPath}/img/logo_sm.png" width="200" height="50" alt="logo" align="center">
    </a>
    <HR width="80%" SIZE=5>
    <div class="center-block" style="width: 60%;padding-top: 20px;">
        <form id="resetPasswordForm">
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-phone"></span>
                    </div>
                    <input name="phone" type="text" class="form-control" placeholder="手机号码验证">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-wrench"></span>
                    </div>
                    <input name="code" type="text" class="form-control" placeholder="验证码">
                    <span class="input-group-btn">
						<button type="button" class="btn btn-info">获取验证码</button>
					</span>
                </div>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-default" value="密码重置">
            </div>
        </form>
        <HR width="60%" SIZE=5>
        <a href="javascript:history.back()">返回登录</a>
    </div>
</div>
</body>
</html>