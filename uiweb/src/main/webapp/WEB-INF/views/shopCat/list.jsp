<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>购物车-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
</head>

<style>
    a {
        color: #0f0f0f;
        text-decoration-line: none;
    }

    a:hover {
        color: red;
        text-decoration-line: none;
    }
</style>

<script>
    $(function () {
        var index;
        $(".xs_img img").hover(function () {
            index = layer.tips('<img src="' + this.src + '" width="200" height="200">', this, {
                tips: ['2', '#FFFFFF'],
                area: ['230px', '220px']
            });
        }, function () {
            layer.close(index);
        });

        $(".chooseAll").click(function () {
            $(".prebox").prop('checked', this.checked);
            reTotalCount();
        });
    });

    function logout() {
        $.ajax({
            type: 'get',
            dataType: 'json',
            url: '${pageContext.request.contextPath}/logout',
            success: function (data) {
                if (data.success) {
                    window.location.reload();
                }
            }
        });
    }

    function reCountPrice(that, num, salePrice, item_id) {
        $(that).closest('td').find('.countPrice').html('￥' + (num * salePrice).toFixed(2));
        reTotalCount();
        $.ajax({
            type: 'get',
            data: {id: item_id, num: num},
            dataType: 'json',
            url: '${pageContext.request.contextPath}/user/updateNumOfItem',
            error: function () {
                window.open("${pageContext.request.contextPath}/login.jsp");
            }
        });
    }

    function deleteItem(that, num, item_id) {
        $(that).closest('tr').remove();
        reTotalCount();
        $.ajax({
            type: 'get',
            data: {id: item_id, num: num},
            dataType: 'json',
            url: '${pageContext.request.contextPath}/user/updateNumOfItem',
            error: function () {
                window.open("${pageContext.request.contextPath}/login.jsp");
            }
        });
    }

    function reTotalCount() {
        var totalCount = 0;
        $.each($(".prebox:checked"), function (index, item) {
            var countPrice = $(item).closest('td').find('.countPrice').html();
            countPrice = parseFloat(countPrice.substring(1).replace(',', ''));
            totalCount += countPrice;
        });
        $("#totalCount").html('￥' + totalCount.toFixed(2));
    }

    function toPayOfOrder() {
        $.each($(".prebox:checked"), function (index, item) {
            console.log($(item).data('item'));
        });
    }
</script>

<body>
<div style="padding: 10px 0;background-color: rgb(0,0,0,.1);">
    <div class="container" style="padding: 0 8%;font-size: 12px;">
        <a href="${pageContext.request.contextPath}/index">首页</a>&ensp;
        <a href="${pageContext.request.contextPath}/user/indexOfUserInfo">个人中心</a>
        <div class="pull-right" style="font-size: 12px;">
            <span>用户&ensp;<b>[ ${sessionScope[UserContext.USER_IN_SESSION].username} ]</b>&ensp;的购物车！</span>&ensp;&ensp;
            <a href="javascript:logout()" style="color: #419641;">安全退出</a>
        </div>
    </div>
</div>
<div class="container" style="padding: 10px 8%;font-size: 12px;">
    <div style="border: solid 1px rgb(0,0,0,.1);padding: 5px;min-height: 500px;">
        <div class="table-responsive">
            <table class="table">
                <tr align="center">
                    <td width="50%">
                        <div class="pull-left">
                            <input id="all" type="checkbox" class="btn-xs chooseAll"> <label for="all">全选</label>
                        </div>
                        商品信息
                    </td>
                    <td width="10%">单价</td>
                    <td width="15%">数量</td>
                    <td width="10%">总价</td>
                    <td width="15%">操作</td>
                </tr>
                <c:if test="${sessionScope[UserContext.SHOPCAT_IN_SESSION].size() == 0}">
                    <tr>
                        <td colspan="5"><p class="text-center text-danger">购物车还空空的呢！0.0</p></td>
                    </tr>
                </c:if>
                <c:forEach items="${sessionScope[UserContext.SHOPCAT_IN_SESSION]}" var="item">
                    <c:if test="${item.goods.activity == null || item.goods.activity.state != 1}">
                        <c:if test="${item.goods.discountPrice == null}">
                            <c:set value="${item.goods.salePrice}" var="salePrice" scope="page"/>
                        </c:if>
                        <c:if test="${item.goods.discountPrice != null}">
                            <c:set value="${item.goods.discountPrice}" var="salePrice" scope="page"/>
                        </c:if>
                    </c:if>
                    ${goods.activity.state}
                    <c:if test="${item.goods.activity != null && item.goods.activity.state == 1}">
                        <c:set value="${item.goods.salePrice*item.goods.activity.discount/10}" var="salePrice"
                               scope="page"/>
                    </c:if>
                    <fmt:formatNumber value="${pageScope.salePrice*item.num}" var="countPrice" scope="page"
                                      type="currency"/>
                    <fmt:formatNumber value="${pageScope.salePrice}" var="reSalePrice" scope="page" type="currency"/>
                    <tr>
                        <td colspan="5">
                            <div style="background-color:  ${item.goods.state == 0 ? '#fcf8e3':'#FFFFFF'};border: solid 1px rgb(0,0,0,.1);padding: 5px 0;">
                                <div class="xs_img" style="width: 50%;display: inline-block;margin-left: 10px;">
                                    <input type="checkbox" class="btn-xs ${item.goods.state == 0 ? '':'prebox'}"
                                           style="margin-right: 5px;" ${item.goods.state == 0 ? 'disabled':''}
                                           onchange="reTotalCount()" data-item="${item.id}">
                                    <img src="${item.goods.imgs.split(',')[0]}" width="80" height="80">
                                    <div style="width: 200px;display: inline-block;">
                                        <a href="${pageContext.request.contextPath}/getAllById?id=${item.goods.id}"
                                           target="_blank">${item.goods.name}</a>
                                    </div>
                                    <c:if test="${item.goods.state == 0}">
                                        <div style="display: inline-block;font-size: 14px;">
                                            <b class="text-danger">该商品下架了！</b>
                                        </div>
                                    </c:if>
                                </div>
                                <div style="width: 10%;display: inline-block;text-align: center;">
                                    <b style="color: red;">${pageScope.reSalePrice}</b>
                                </div>
                                <div style="width: 15%;display: inline-block;text-align: center;">
                                    <input type="number" value="${item.num}" ${item.goods.state == 0 ? 'disabled':''}
                                           style="width: 50px;text-align: center;" min="1"
                                           onchange="reCountPrice(this,this.value,${pageScope.salePrice},${item.id})">
                                </div>
                                <div style="width: 10%;display: inline-block;text-align: center;">
                                    <b class="countPrice" style="color: red;">${pageScope.countPrice}</b>
                                </div>
                                <div style="width: 10%;display: inline-block;text-align: center;">
                                    <a href="javascript:" onclick="deleteItem(this,0,${item.id})">
                                        <span class="glyphicon glyphicon-remove text-danger"></span> 删除
                                    </a>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div style="border: solid 1px rgb(0,0,0,.1);padding: 5px 10px;margin: 10px 0;background-color: rgb(0,0,0,.03);">
        <input type="checkbox" class="btn-xs chooseAll"> <label for="all">全选</label>
        <p class="pull-right">总计：<b id="totalCount" style="color: red;font-size: 14px;">￥0.00</b>&ensp;&ensp;
            <button type="button" class="btn btn-danger btn-xs" onclick="toPayOfOrder()">去结算</button>
        </p>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>