<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品详细信息-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>
</head>

<style>
    .smImg {
        border: solid 2px #FFFFFF;
    }
</style>

<script>
    var msg = '${msg}';
    if (msg) {
        layer.open({
            title: '温馨提示',
            icon: 5,
            content: msg
        });
    }

    $(function () {
        $(".smImg").mouseover(function () {
            $(".smImg").prop('style', 'border-color: #FFFFFF;');
            this.style.borderColor = '#FF0000';
            $(".lgImg").prop('src', $(this).find('img').prop('src'));
        });
    });

    function seeActivity(id) {
        $.ajax({
            type: 'get',
            data: {id: id},
            dataType: 'json',
            url: '${pageContext.request.contextPath}/getActivityOfGoodsByAid',
            success: function (data) {
                layer.open({
                    title: '活动详情',
                    area: ['450px'],
                    shadeClose: true,
                    btn: '',
                    content: '<p>活动名称：' +
                    data.title + '</p><p>折扣：' +
                    data.discount + '折</p><p>活动时间：' +
                    data.beginTime + '&ensp;&ensp;至&ensp;&ensp;' + data.endTime + '</p><p>活动简介：<br>' +
                    data.intro + '</p>'
                });
            }
        });
    }

    function addToShopCat() {
        if (${sessionScope[UserContext.USER_IN_SESSION] == null}) {
            window.open('login.jsp');
            return;
        }
        $.ajax({
            type: 'post',
            data: $("#shoppingForm").serialize(),
            dataType: 'json',
            url: '${pageContext.request.contextPath}/user/addToShopCat',
            success: function (data) {
                layer.msg(data.msg, {time: 1000});
            }
        });
    }
</script>

<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid" style="background-color: rgb(0,0,0,.01);">
    <div class="container" style="padding: 20px 7%;">
        <div class="row" style="margin-bottom: 20px;">
            <div class="col-sm-6">
                <img class="lgImg" src="${goods.imgs.split(",")[0]}" width="100%" height="300"
                     style="margin-bottom: 10px;">
                <div style="column-count: 3;column-gap: 5px;">
                    <c:forEach items="${goods.imgs.split(',')}" var="img" varStatus="num">
                        <c:if test="${num.count lt 4}">
                            <div class="smImg" style="${num.count == 1 ? 'border-color: #FF0000;' : ''}">
                                <img src="${img}" width="100%" height="80">
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="col-sm-6">
                <b style="font-size: 16px;color: rgb(0,0,0,.6);">
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=${goods.style}">[${goods.style}]</a>
                    &ensp;<span>${goods.name}</span>&ensp;&ensp;
                    <small style="font-size: 10px;color: rgb(0,0,0,.3);">编号：${goods.sn}</small>
                </b>
                <p style="padding: 10px 0;">
                    <c:if test="${goods.activity != null}">
                        <a href="javascript:seeActivity(${goods.activity.id})" style="color: red;">
                            【${goods.activity.discount}折活动】&ensp;${goods.activity.title}&gt;&gt;&gt;
                        </a>
                    </c:if>
                </p>
                <div style="background-color: rgb(0,0,0,.05);padding: 10px;font-size: 12px;color: #adadad;">
                    <c:if test="${goods.activity == null}">
                        <c:choose>
                            <c:when test="${goods.discountPrice == null}">
                                本站价：<span style="font-size: 16px;color: red;">￥${goods.salePrice}</span>
                            </c:when>
                            <c:when test="${goods.discountPrice != null}">
                                优惠价：<span style="font-size: 16px;color: red;">￥${goods.discountPrice}</span>
                                &ensp;&ensp;&ensp;
                                本站价：<s style="color: #adadad;">￥${goods.salePrice}</s>
                            </c:when>
                        </c:choose>
                    </c:if>
                    <c:if test="${goods.activity != null}">
                        <fmt:formatNumber value="${goods.salePrice*goods.activity.discount}" var="disPrice"
                                          type="currency" scope="page"/>
                        活动价：<span style="font-size: 16px;color: red;">${pageScope.disPrice}</span>
                        &ensp;&ensp;&ensp;
                        本站价：<s style="color: #adadad;">￥${goods.salePrice}</s>
                    </c:if>
                    <div class="pull-right">|&ensp;
                        已售：<span style="color: #adadad;">${goods.saleCount}</span>
                    </div>
                </div>
                <div style="padding: 10px;font-size: 12px;color: #adadad;">
                    <p style="padding-top: 10px;">规格：${goods.size}</p>
                    <p style="padding-top: 10px;">包含件数：${goods.num}</p>
                    <c:if test="${goods.state == 0}">
                        <p style="font-size: 18px;color: red;padding-top: 20px;">该商品已下架！</p>
                    </c:if>
                    <c:if test="${goods.state == 1}">
                        <form id="shoppingForm" class="form-inline">
                            <input type="hidden" name="id" value="${goods.id}">
                            <p style="padding-top: 10px;">数量：
                                <input type="number" name="count" class="form-control input-sm" value="1" min="1"
                                       style="width: 80px;">
                            </p>
                        </form>
                        <div style="padding-top: 10px;">
                            <input type="button" class="btn btn-danger" value="加入购物车" onclick="addToShopCat()">
                        </div>
                    </c:if>
                    <p style="padding-top: 30px;">服务承诺：
                        <a href="javascript:">45天退换</a>
                        <a href="javascript:">质保一年</a>
                    </p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-3">
                <div style="background-color: rgb(0,0,0,.1);padding: 5px;border: solid 1px rgb(0,0,0,.1);">
                    <b>精品推荐</b>
                </div>
                <div style="border: solid 1px rgb(0,0,0,.1);padding: 5px 10px;border-top: none;">
                    <c:forEach items="${recommend}" var="item" varStatus="num">
                        <c:if test="${num.count < 5}">
                            <a href="${pageContext.request.contextPath}/getAllById?id=${item.id}">
                                <img src="${item.imgs.split(',')[0]}" width="100%" height="150">
                                <div style="font-size: 12px;color: red;margin-bottom: 20px;background-color: #FFFFFF;">
                                    <div title="${item.name}"
                                         style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
                                            ${item.name}
                                    </div>
                                    <c:if test="${item.discountPrice != null}">
                                        <span>￥${item.discountPrice}</span>
                                    </c:if>
                                    <c:if test="${item.discountPrice == null}">
                                        <span>￥${item.salePrice}</span>
                                    </c:if>
                                    <span style="color: #adadad;float: right;">
                                        已售：<span class="text-info">${item.saleCount}</span>
                                    </span>
                                </div>
                            </a>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="col-sm-9">
                <div style="background-color: rgb(0,0,0,.1);padding: 5px;border: solid 1px rgb(0,0,0,.1);">
                    <b>商品详情</b>
                </div>
                <div style="border: solid 1px rgb(0,0,0,.1);padding: 5px 10px;border-top: none;">
                    <div class="table-responsive" style="border: solid 1px rgb(0,0,0,.1);font-size: 12px;">
                        <table class="table">
                            <tr>
                                <td width="20%" align="center">型号</td>
                                <td>${goods.sn}</td>
                            </tr>
                            <tr>
                                <td width="20%" align="center">风格</td>
                                <td>${goods.place}</td>
                            </tr>
                            <tr>
                                <td width="20%" align="center">件数</td>
                                <td>${goods.num}</td>
                            </tr>
                            <tr>
                                <td width="20%" align="center">用料</td>
                                <td>${goods.material}</td>
                            </tr>
                            <tr>
                                <td width="20%" align="center">产地</td>
                                <td>${goods.place}</td>
                            </tr>
                            <tr>
                                <td width="20%" align="center">设计理念</td>
                                <td>${goods.intro}</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <br>
                <div style="background-color: rgb(0,0,0,.1);padding: 5px;border: solid 1px rgb(0,0,0,.1);">
                    <b>评价</b>
                </div>
                <div style="border: solid 1px rgb(0,0,0,.1);padding: 5px 10px;border-top: none;">
                    <img src="holder.js/100px390?text=详情介绍">
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>