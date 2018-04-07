function deleteItem(id) {
    layer.confirm('确定删除该字典明细吗?', {icon: 3, title: '温馨提示'}, function (index) {
        layer.close(index);
        $.ajax({
            type: 'get',
            data: {id: id},
            dataType: 'json',
            url: $("#basePath").val() + '/deleteSystemDictionaryItemById',
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
    });

    function myCallBack(index) {
        layer.close(index);
        location.reload();
    }
}