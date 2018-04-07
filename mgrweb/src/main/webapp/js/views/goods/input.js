$(function () {
    var basePath = $("#basePath").val();
    var goodsForm = $("#goodsForm");

    //room和type的二级联动
    var room = $("select[name='room.id']");
    var type = $("select[name='type']");
    room.change(function () {
        var id = $(this).val();
        if (id) {
            $.ajax({
                type: 'get',
                data: {id: id},
                dataType: 'json',
                url: basePath + '/queryItemsByPidForGoods',
                success: function (data) {
                    var str = '<option value="无">请选择</option>';
                    for (var i = 0; i < data.length; i++) {
                        str += '<option>' + data[i].name + '</option>';
                    }
                    type.html(str);
                }
            });
        } else {
            type.html('<option value="无">请先选择房间分类</option>');
        }
    });

    //初始化图片上传控件
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

    //提交表单
    $("#submitGoods").click(function () {
        goodsForm.submit();
    });

    //表单验证及提交事件
    goodsForm.validate({
        errorPlacement: function (error, element) {
            error.appendTo(element.parent().parent());
        },
        errorElement: 'span',
        errorClass: 'text-danger',
        rules: {
            name: 'required',
            sn: 'required',
            size: 'required',
            num: {
                required: true,
                digits: true
            },
            stockCount: {
                required: true,
                digits: true
            },
            costPrice: {
                required: true,
                number: true
            },
            salePrice: {
                required: true,
                number: true
            }
        },
        messages: {
            name: '商品名称不能为空哦！',
            sn: '商品编码不能为空哦！',
            size: '商品尺寸还是填一下吧！',
            num: {
                required: '商品有多少件呢？',
                digits: '必需是数字且是整数哦！'
            },
            stockCount: {
                required: '商品库存有多少呢？',
                digits: '必需是数字且是整数哦！'
            },
            costPrice: {
                required: '成本是多少呢？',
                number: '必需是数字哦！'
            },
            salePrice: {
                required: '售价是多少呢？',
                number: '必需是数字哦？'
            }
        },

        /*表单提交*/
        submitHandler: function () {
            //去掉名字的前后空格
            var value = $(":input[name='name']");
            value.val($.trim(value.val()));
            if (!imgs.val()) {
                layer.open({
                    title: '温馨提示',
                    icon: 5,
                    content: '商品图片还没上传呢，快去上传一张吧！'
                });
                return false;
            }
            $.ajax({
                type: 'post',
                data: goodsForm.serialize(),
                url: basePath + '/saveGoods',
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

    //弹出层回调
    function myCallBack(index) {
        layer.close(index);
        location.href = basePath + "/listGoods";
    }
});

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