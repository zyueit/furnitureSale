function forceEnd(id) {
    layer.prompt({
        formType: 2,
        title: '撤销活动备注',
        area: ['400px', '200px'] //自定义文本域宽高
    }, function (value, index) {
        $.ajax({
            type: 'post',
            data: {id: id, esIntro: value},
            dataType: 'json',
            url: $("#basePath").val() + '/updateActivityState',
            success: function (data) {
                if (data.success) {
                    layer.open({
                        title: '温馨提示',
                        icon: 6,
                        content: data.msg,
                        yes: reloadPg,
                        cancel: reloadPg
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
        layer.close(index);
    });

    function reloadPg(index) {
        layer.close(index);
        location.reload();
    }
}