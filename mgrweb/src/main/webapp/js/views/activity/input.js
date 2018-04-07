$(function () {
    var start = laydate.render({
        type: 'datetime',
        elem: '#beginTime', //指定元素
        format: 'yyyy-MM-dd HH:mm:ss',
        btns: ['clear', 'confirm'],
        calendar: true,
        min: 1,
        done: function (value, dates) {
            end.config.min = {
                year: dates.year,
                month: dates.month - 1,//关键
                date: dates.date,
                hours: dates.hours,
                minutes: dates.minutes,
                seconds: dates.seconds
            };
        }
    });
    var end = laydate.render({
        type: 'datetime',
        elem: '#endTime', //指定元素
        format: 'yyyy-MM-dd HH:mm:ss',
        btns: ['clear', 'confirm'],
        calendar: true,
        min: 1,
        done: function (value, dates) {
            start.config.max = {
                year: dates.year,
                month: dates.month - 1,//关键
                date: dates.date,
                hours: dates.hours,
                minutes: dates.minutes,
                seconds: dates.seconds
            };
        }
    });

    var basePath = $("#basePath").val();
    var id = $(":input[name='id']").val();
    var activityForm = $("#activityForm");

    $("#submitActivity").click(function () {
        activityForm.submit();
    });

    /*表单验证*/
    activityForm.validate({
        errorPlacement: function (error, element) {
            error.appendTo(element.parent().parent());
        },
        errorElement: 'span',
        errorClass: 'text-danger',
        rules: {
            title: 'required',
            discount: {
                required: true,
                number: true,
                range: [0, 10]
            },
            beginTime: 'required',
            endTime: 'required'
        },
        messages: {
            title: '活动标题不能为空！',
            discount: {
                required: '说好的打折呢？',
                number: '只能输数字哦，且在1~10之间，如：2 2.5 3.5等！',
                range: '数值要在{0}~{1}之间哦！'
            },
            beginTime: '活动开始时间还没填啊！',
            endTime: '活动结束时间还没填啊！'
        },
        /*表单提交*/
        submitHandler: function () {
            //去除标题的前后空格
            var value = $(":input[name='title']");
            value.val($.trim(value.val()));

            var ids = $(":input[name='ids']").val();
            if (!ids) {
                layer.open({
                    title: '温馨提示',
                    icon: 5,
                    content: '还没添加活动商品呢！'
                });
                return false;
            }
            ids = ids.split(',');
            var str = '';
            $.each(ids, function (index, id) {
                str = str + '&goods[' + index + '].id=' + id;
            });
            var msg = '活动保存后，活动时间将不能更改，确定提交吗？';
            if (id) {
                msg = '确定提交吗？';
            }
            layer.confirm(msg, function () {
                $.ajax({
                    type: 'post',
                    data: activityForm.serialize() + str,
                    url: basePath + '/saveActivity',
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
            });
        }
    });

    function myCallBack(index) {
        layer.close(index);
        location.href = basePath + '/listActivities';
    }

    //打开商品选择页面
    $("#showGoods").click(function () {
        window.open(basePath + "/listForActivity", "",
            "channelmode=yes,height=500,width=900");
    });

    //移除活动商品
    $(".goods").on('click', 'a', function () {
        var ids = $(":input[name='ids']");
        var id = $(this).data('id');
        var val = ids.val();
        console.log(val);
        var index = val.search($(this).data('id'));
        if (index === 0) {
            val = val.substring(2);
        } else {
            val = val.replace(',' + id, '');
        }
        console.log(val);
        ids.val(val);
        $(this).closest('tr').remove();
        var myframe = $(window.parent.document).find("#myframe");
        myframe.height(myframe.height() - 35);
    });
});

// 活动商品选择页面传回的json数据
function handle(json) {
    var json = eval(json);
    var ids = $(":input[name='ids']");
    var id = json[0].id;
    //如果存在，表示已经是活动商品，直接跳过
    if (ids.val().search(id) !== -1) {
        return;
    }
    //将id保存到隐藏域中，便于提交时的操作
    if (ids.val()) {
        ids.val(ids.val() + ',' + id);
    } else {
        ids.val(id);
    }
    //表格添加一行显示商品信息
    $(".goods").append('<tr><td class="ids">'
        + id + '</td><td>'
        + json[0].sn + '</td><td>'
        + json[0].name + '</td><td>'
        + '<a href="javascript:" data-toggle="tooltip" data-placement="bottom" title="移除" data-id="'
        + id + '"><span class="glyphicon glyphicon-minus"></span></a></td></tr>'
    );
    var myframe = $(window.parent.document).find("#myframe");
    myframe.height(myframe.height() + 35);
}