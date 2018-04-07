//添加库存
function addStock(id) {
    layer.prompt({
        formType: 0,
        title: '添加库存数量',
        area: ['100px', '100px']
    }, function (value, index) {
        layer.close(index);
        $.ajax({
            type: 'post',
            data: {id: id, stock: value},
            dataType: 'json',
            url: $("#basePath").val() + '/addStockCount',
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
    });
}

//上架
function putaway(id, bool) {
    if (!bool) {
        bool = false;
    }
    $.ajax({
        type: 'post',
        data: {id: id, state: bool},
        dataType: 'json',
        url: $("#basePath").val() + '/updateGoodsState',
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
}

//下架
function soldout(id) {
    putaway(id, true)
}

//回调，刷新页面
function reloadPg(index) {
    layer.close(index);
    location.reload()
}

//初始化图片上传控件的方法
function initFileInput(ctrlName, uploadUrl) {
    var control = $('#' + ctrlName);
    control.fileinput({
        language: 'zh', //设置语言
        uploadUrl: uploadUrl,
        showClose: false,
        showRemove: false,
        removeFromPreviewOnError: true,
        browseClass: "btn btn-info", //按钮样式
        allowedPreviewTypes: ['image'],
        allowedFileTypes: ['image'],
        allowedFileExtensions: ['jpg', 'png', 'gif'],
        maxFileSize: 5120,//5M
        minFileCount: 1,
        maxFileCount: 3,
        enctype: 'multipart/form-data'
    })
}

$(function () {
    var basePath = $("#basePath").val();
    initFileInput("goodsImg", basePath + "/imgUpload");
    var goodsImg = $("#goodsImg");
    var imgs = $(":input[name='imgs']");
    goodsImg.on("fileuploaded", function (even, data) {
        if (data.response.success) {
            if (imgs.val()) {
                imgs.val(imgs.val() + "," + data.response.url);
            } else {
                imgs.val(data.response.url);
            }
        } else {
            layer.open({
                icon: 5,
                title: '温馨提示',
                content: data.response.msg
            });
        }
    });
});

//隐藏图片和更换按钮
function hideOld() {
    $(".old").hide();
    $(".new").show();
}

//显示图片和更换按钮
function showOld() {
    $(".old").show();
    $(".new").hide();
}

//更换图片
function changeImgs(id) {
    var imgs = $(":input[name='imgs']");
    if (!imgs.val()) {
        layer.open({
            icon: 5,
            title: '温馨提示',
            content: '那就上传一张图片吧！'
        });
        return false;
    }
    $.ajax({
        type: 'post',
        data: {id: id, imgs: imgs.val()},
        dataType: 'json',
        url: $("#basePath").val() + '/updateImgs',
        success: function (data) {
            if (data.success) {
                layer.open({
                    icon: 6,
                    title: '温馨提示',
                    content: data.msg,
                    yes: reloadPg,
                    cancel: reloadPg
                });
            } else {
                layer.open({
                    icon: 5,
                    title: '温馨提示',
                    content: data.msg
                });
            }
        }
    });
}