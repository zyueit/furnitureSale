$(function () {
    var pid = $(":input[name='parent.id']").val();
    var itemForm = $("#itemForm");
    var basePath = $("#basePath").val();

    /*表单验证*/
    itemForm.validate({
        errorPlacement: function (error, element) {
            error.appendTo(element.parent().parent());
        },
        errorElement: 'span',
        errorClass: 'text-danger',
        rules: {
            name: 'required'
        },
        messages: {
            name: '明细名称不能为空！'
        },
        /*表单提交*/
        submitHandler: function () {
            var value = $(":input[name='name']");
            value.val($.trim(value.val()));
            $.ajax({
                type: 'post',
                data: itemForm.serialize(),
                url: basePath + '/saveSystemDictionaryItem',
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
                        layer.open({
                            title: '温馨提示',
                            icon: 6,
                            content: data.msg,
                            yes: myCallBack,
                            cancel: myCallBack
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

    function myCallBack(index) {
        //打开明细列表
        layer.close(index);
        window.location.href = basePath + "/querySystemDictionaryItemsByPid?id=" + pid;
    }
});