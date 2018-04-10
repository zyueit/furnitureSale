$(function () {
    var basePath = $("#basePath").val();

    <!--自定义校验规则-->
    $.validator.addMethod("phone", function (value, element) {
        var length = value.length;
        var mobile = /^[1][3,4,5,7,8][0-9]{9}$/;
        return this.optional(element) || (length === 11 && mobile.test(value));
    }, "请正确填写您的手机号码");

    var phoneEl = $(":input[name='phone']");
    var registerForm = $("#registerForm");

    function toLogin(index) {
        layer.close(index);
        window.location.href = basePath + '/login.jsp';
    }

    registerForm.validate({
        onkeyup: false,
        errorPlacement: function (error, element) {
            $(element).val('');
            $(element).prop('placeholder', error[0].innerHTML);
        },
        highlight: function (element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        rules: {
            username: {
                required: true,
                remote: {
                    url: basePath + "/checkUserExist",
                    type: "get",
                    dataType: "json",
                    data: {
                        info: function () {
                            return $(":input[name='username']").val();
                        }
                    }
                }
            },
            phone: {
                required: true,
                phone: true,
                remote: {
                    url: basePath + "/checkUserExist",
                    type: "get",
                    dataType: "json",
                    data: {
                        info: function () {
                            return $(":input[name='phone']").val();
                        }
                    }
                }
            },
            code: 'required',
            password: 'required',
            repasswd: {
                required: true,
                equalTo: '#password'
            }
        },
        messages: {
            username: {
                required: '用户名还是空的呢！',
                remote: '用户名已被注册！'
            },
            phone: {
                required: '手机号码不能为空！',
                phone: '请正确填写您的手机号码！',
                remote: '号码已被绑定！'
            },
            code: '必填！',
            password: '密码还没设置呢！',
            repasswd: '两次密码输入不一致！'
        },
        submitHandler: function () {
            $.ajax({
                type: 'post',
                data: registerForm.serialize(),
                dataType: 'json',
                url: basePath + '/register',
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
        var phone = phoneEl.val();
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