/* 如果登陆窗口不是顶级窗口，改变地址栏 */
if (window != top) {
    top.location.href = location.href;
}

$(function () {
    var loginForm = $("#loginForm");
    var msg = $("#msg");
    var basePath = $("#basePath").val();

    /*表单验证*/
    loginForm.validate({
        errorPlacement: function (error, element) {
            error.appendTo(element.parent().parent());
        },
        errorElement: 'span',
        errorClass: 'text-danger',
        rules: {
            username: 'required',
            password: 'required'
        },
        messages: {
            username: '用户名不能为空！',
            password: '密码不能为空！'
        },
        /*表单提交*/
        submitHandler: function () {
            $.ajax({
                type: 'post',
                data: loginForm.serialize(),
                url: basePath + '/login',
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
                        window.location.href = basePath + "/main";
                        msg.prop('class', 'alert alert-success');
                    } else {
                        msg.prop('class', 'alert alert-danger');
                    }
                    msg.html(data.msg).show();
                }
            });
        }
    });
});
    