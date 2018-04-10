function resetForm() {
    $("#userInfoForm")[0].reset();
    $(":input[name='imgs']").val('');
}

function submitForm() {
    $("#userInfoForm").submit();
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
        minFileCount: 2,
        maxFileCount: 2,
        enctype: 'multipart/form-data',
        showAjaxErrorDetails: false,
        layoutTemplates: {
            actionUpload: ''
        }
    })
}

$(function () {
    var basePath = $("#basePath").val();
    initFileInput("ID_img", basePath + "/user/imgsUploadOfIdcard");
    var id_img = $("#ID_img");
    var imgs = $(":input[name='imgs']");
    id_img.on("fileuploaded", function (even, data) {
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

    var userInfoForm = $("#userInfoForm");
    userInfoForm.validate({
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
            name: 'required',
            IDcard: 'required',
            address: 'required'
        },
        messages: {
            name: '该项必填！',
            IDcard: '该项必填！',
            address: '该项必填！'
        },
        submitHandler: function () {
            if (imgs.val().split(',').length !== 2) {
                layer.open({
                    title: '温馨提示',
                    icon: 5,
                    content: '请按规定上传两张照片！'
                });
                return false;
            }
            $.ajax({
                type: 'post',
                data: userInfoForm.serialize(),
                dataType: 'json',
                url: basePath + '/user/updateUserInfo',
                success: function (data) {
                    if (data.success) {
                        location.reload();
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
});