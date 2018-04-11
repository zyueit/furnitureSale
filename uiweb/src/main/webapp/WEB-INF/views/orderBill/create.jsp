<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单确认-MingMini家具销售</title>
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
    function createBillToPay() {
        $("[name='shipId']").val($("[name='shipping']:checked").data('shipping'));
        var ids = '?';
        $.each($(".ids"), function (index, item) {
            ids = ids + 'ids=' + $(item).val() + '&';
        });
        $("#billForm")[0].action = "${pageContext.request.contextPath}/user/saveOrderBill" + ids;
        $("#billForm").submit();
    }

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

    function chooseTr(that) {
        $(that).closest("table").find("tr").removeClass("active");
        $(".myicon").hide();
        $(that).closest("tr").find(".myicon").show();
        $(that).closest("tr").addClass("active");

        var tr = $(that).closest("tr");
        showShipping(tr.find(".address").html(), tr.find(".people").html(), tr.find(".phone").html());
    }

    function showShipping(address, people, phone) {
        $("#showAddress").html(address);
        $("#showPeople").html(people);
        $("#showPhone").html(phone);
    }

    $(function () {
        var totalAmount = 0;
        $.each($(".amount"), function (index, item) {
            totalAmount += parseFloat($(item).html());
        });
        $("#totalAmount").html('￥' + totalAmount.toFixed(2));

        var tr = $("[name='shipping']:checked").closest("tr");
        showShipping(tr.find(".address").html(), tr.find(".people").html(), tr.find(".phone").html());
    });
</script>

<body>
<div style="padding: 10px 0;background-color: rgb(0,0,0,.1);">
    <div class="container" style="padding: 0 8%;font-size: 12px;">
        <a href="${pageContext.request.contextPath}/index">首页</a>&ensp;
        <a href="${pageContext.request.contextPath}/user/indexOfUserInfo" target="_blank">个人中心</a>
        <div class="pull-right" style="font-size: 12px;">
            <span>亲爱的用户&ensp;<b>[ ${sessionScope[UserContext.USER_IN_SESSION].username} ]</b>&ensp;请仔细确认订单哦！</span>&ensp;&ensp;
            <a href="javascript:logout()" style="color: #419641;">安全退出</a>
        </div>
    </div>
</div>
<div class="container" style="padding: 0 8%;font-size: 12px;">
    <div style="padding: 20px 0;min-height: 200px;">
        <div class="pull-right">
            <a href="${pageContext.request.contextPath}/user/addressOfShipping"
               class="btn btn-primary btn-xs" target="_blank">
                管理收货地址
            </a>
        </div>
        <p style="font-size: 14px;padding-left: 10px;">确认收货地址</p>
        <table class="table table-hover">
            <c:forEach items="${shippings}" var="item">
                <tr class="${item.state ? 'active':''}">
                    <td style="color: orangered;padding-left: 20px;" width="110">
                        <div class="myicon" ${item.state ? '':'hidden'}>
                            <span class="glyphicon glyphicon-map-marker"></span> 寄送至：
                        </div>
                    </td>
                    <td width="20">
                        <input name="shipping" type="radio" width="20" ${item.state ? 'checked':''}
                               onchange="chooseTr(this)" data-shipping="${item.id}">
                    </td>
                    <td>
                        <div>
                            <span class="address">${item.address}</span>&ensp;&ensp;
                            (<span class="people">${item.name}</span>&ensp;收)&ensp;
                            <b class="phone">${item.phone}</b>
                        </div>
                    </td>
                    <td width="90">
                        <c:if test="${item.state}">
                            <span class="label label-info">默认地址</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <p style="font-size: 14px;padding-left: 10px;">确认订单信息</p>
    <table class="table" style="font-size: 12px;">
        <tr align="center" style="font-size: 14px;">
            <td width="50%">商品信息</td>
            <td width="15%">单价</td>
            <td width="20%">数量</td>
            <td width="15%">总价</td>
        </tr>
        <c:forEach items="${billItems}" var="item">
            <input class="ids" type="hidden" value="${item.goods.id}">
            <tr align="center" style="background-color: rgb(0,255,255,.05);font-size: 14px;">
                <td>
                    <div class="pull-left">
                        <img src="${item.goods.imgs.split(',')[0]}" width="50" height="50">
                    </div>
                    <div class="pull-left" style="width: 250px;font-size: 12px;">
                        <a href="${pageContext.request.contextPath}/getAllById?id=${item.goods.id}"
                           target="_blank">${item.goods.name}</a>
                    </div>
                </td>
                <td>${item.salePrice}</td>
                <td>${item.num}</td>
                <td style="color: red;"><span class="amount">${item.amount}</span></td>
            </tr>
            <tr style="height: 5px;"></tr>
        </c:forEach>
        <tr style="background-color: rgb(0,255,255,.1);">
            <td rowspan="2">
                <form id="billForm" method="post">
                    <input name="shipId" type="hidden">
                    <textarea name="remark" class="pull-right"
                              style="height: 50px;width: 350px;resize: none;"></textarea>
                </form>
                <p class="text-left">给商家留言：</p>
            </td>
            <td colspan="2">运送方式：快速专递（暂未接入物流）</td>
            <td align="center" style="font-size: 14px;color: red;">0.00</td>
        </tr>
        <tr style="background-color: rgb(0,255,255,.1);">
            <td colspan="2">运费险：确认收货前退货最低可赔付50%（暂未接入）</td>
            <td align="center" style="font-size: 14px;color: red;">0.00</td>
        </tr>
    </table>
    <div class="pull-right" style="margin-bottom: 20px;text-align: right;">
        <div style="min-width: 200px;border: solid 1px orange;padding: 5px;">
            <p>实付款：<span id="totalAmount" style="font-size: 18px;color: red;">￥0.00</span></p>
            <p>寄送至：<span id="showAddress"></span></p>
            <p>收货人：<span id="showPeople"></span>&ensp;&ensp;<span id="showPhone"></span></p>
        </div>
        <a href="${pageContext.request.contextPath}/user/shopCat">返回购物车</a>
        <input type="button" class="btn btn-danger" value="创建订单" onclick="createBillToPay()">
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>