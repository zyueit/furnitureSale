<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>收货地址-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
</head>

<style>
    dt, dd {
        font-size: 12px;
    }
</style>

<script>
    $(function () {
        var basePath = $("#basePath").val();
        var shippingForm = $("#shippingForm");
        shippingForm.validate({
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
                phone: 'required',
                address: 'required'
            },
            messages: {
                name: '该项必填！',
                phone: '该项必填！',
                address: '该项必填！'
            },
            submitHandler: function () {
                $.ajax({
                    type: 'post',
                    data: shippingForm.serialize(),
                    dataType: 'json',
                    url: basePath + '/user/saveShipping',
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

    function removeShipping(id) {
        $.ajax({
            type: 'get',
            data: {id: id},
            dataType: 'json',
            url: '${pageContext.request.contextPath}/user/removeShipping',
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
                window.open("${pageContext.request.contextPath}/login.jsp");
            }
        });
    }

    function setDefault(id) {
        $.ajax({
            type: 'get',
            data: {id: id},
            dataType: 'json',
            url: '${pageContext.request.contextPath}/user/setDefaultShipping',
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
                window.open("${pageContext.request.contextPath}/login.jsp");
            }
        });
    }

    function showNew() {
        $(".old").hide();
        $(".new").show();
    }

    function hideNew() {
        $("#shippingForm")[0].reset();
        $(".new").hide();
        $(".old").show();
    }
</script>

<body>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">

<%@ include file="/WEB-INF/views/common/person-header.jsp" %>
<div class="container" style="padding: 0 8%;">
    <div class="row" style="margin: 20px 0;">
        <div class="col-sm-3" style="padding: 0;">
            <div style="background-color: rgb(0,0,0,.1);padding-left: 10px;border: solid 1px rgb(0,0,0,.1);">
                <h5><b>新品发售</b>&ensp;
                    <small>快去抢购吧</small>
                </h5>
            </div>
            <div style="border: solid 1px rgb(0,0,0,.1);padding: 5px 10px;border-top: none;">
                <c:forEach items="${newGoods}" var="item" varStatus="num">
                    <c:if test="${num.count < 5}">
                        <a href="${pageContext.request.contextPath}/getAllById?id=${item.id}">
                            <img src="${item.imgs.split(',')[0]}" width="100%" height="150">
                            <div style="font-size: 12px;margin-bottom: 20px;background-color: rgb(0,0,0,.01);">
                                <div title="${item.name}"
                                     style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
                                        ${item.name}
                                </div>
                                <div class="text-center">
                                    <span style="color: red;padding: 0 20px;background-color: rgb(0,0,0,.01);border: solid 1px rgb(0,0,0,.03);">
                                <c:if test="${item.discountPrice != null}">
                                    ￥${item.discountPrice}
                                </c:if>
                                <c:if test="${item.discountPrice == null}">
                                    ￥${item.salePrice}
                                </c:if>
                                    </span>
                                </div>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="col-sm-9" style="padding: 10px 15px;">
            <c:if test="${sessionScope[UserContext.USERINFO_IN_SESSION].shippings.size() == 0}">
                <p class="text-center text-danger" style="margin: 30px 0;">您好像还没添加收货地址！快去添加一条吧...</p>
            </c:if>
            <c:forEach items="${sessionScope[UserContext.USERINFO_IN_SESSION].shippings}" var="item" varStatus="num">
                <div class="col-sm-12">
                    <fieldset>
                        <legend style="font-size: 12px;padding-left: 10px;">地址${num.count}&ensp;
                            <c:if test="${item.state}">
                                <small class="label label-info">默认</small>
                            </c:if>
                            <div class="pull-right">
                                <button type="button" class="btn btn-default btn-xs"
                                        onclick="removeShipping(${item.id})">
                                    删除
                                </button>
                                <c:if test="${!item.state}">
                                    <button type="button" class="btn btn-info btn-xs" onclick="setDefault(${item.id})">
                                        设为默认
                                    </button>
                                </c:if>
                            </div>
                        </legend>
                        <dl class="dl-horizontal">
                            <dt>收货人</dt>
                            <dd>${item.name}</dd>
                            <br>
                            <dt>收货人电话</dt>
                            <dd>${item.phone}</dd>
                            <br>
                            <dt>收货地址</dt>
                            <dd>${item.address}</dd>
                            <br>
                        </dl>
                    </fieldset>
                </div>
                <c:set value="${num.count}" var="count" scope="page"/>
            </c:forEach>
            <c:if test="${pageScope.count < 5}">
                <div class="col-sm-offset-3 old">
                    <input type="button" class="btn btn-default" value="添加新地址" onclick="showNew()">
                    <p style="color: rgb(0,0,0,.3);margin-top: 5px;">最多添加5条收货地址</p>
                </div>
            </c:if>
            <div class="col-sm-12 new" hidden>
                <fieldset>
                    <legend style="font-size: 12px;padding-left: 10px;">添加新地址</legend>
                    <div style="margin-left: 110px;">
                        <form id="shippingForm">
                            <input type="hidden" name="id" value="${sessionScope[UserContext.USERINFO_IN_SESSION].id}">
                            <div class="form-group row">
                                <div class="col-sm-3">
                                    <label class="control-label">收货人名字</label>
                                </div>
                                <div class="col-sm-4" style="padding-left: 0;">
                                    <input name="name" type="text" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3">
                                    <label class="control-label">收货人电话</label>
                                </div>
                                <div class="col-sm-4" style="padding-left: 0;">
                                    <input name="phone" type="text" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3">
                                    <label class="control-label">收货地址</label>
                                </div>
                                <div class="col-sm-6" style="padding-left: 0;">
                                    <input name="address" type="text" class="form-control" placeholder="详细地址">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-offset-3">
                                    <input type="submit" class="btn btn-default" value="确认添加">
                                    <input type="button" class="btn btn-default" value="取消" onclick="hideNew()">
                                </div>
                            </div>
                        </form>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>