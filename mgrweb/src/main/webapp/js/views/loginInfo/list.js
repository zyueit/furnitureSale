$(function () {
    //单击查询，设置查询第一页，提交表单
    $("#queryBtn").click(function () {
        submitForm(1);
    });
});

//分页按钮单击事件
function submitForm(currentPage) {
    $(":input[name='currentPage']").val(currentPage);
    $("#queryForm").submit();
}

function resetPassword(id) {
    layer.confirm('确定重置该员工密码?', {icon: 3, title: '温馨提示'}, function (index) {
        layer.close(index);
        $.ajax({
            type: 'get',
            data: {id: id},
            dataType: 'json',
            url: $("#basePath").val() + '/resetPassword',
            success: function (data) {
                if (data.success) {
                    layer.open({
                        title: '温馨提示',
                        icon: 6,
                        content: data.msg
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
    });
}