<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>已购买的商品-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>
</head>

<style>
    .myactive {
        font-weight: bold;
        font-size: 14px;
    }
</style>

<body>
<%@ include file="/WEB-INF/views/common/person-header.jsp" %>
<div class="container" style="padding: 0 8%;min-height: 420px;">
    <div style="border: solid 1px rgb(0,0,0,.1);width: 100%;padding: 5px 10px;margin-bottom: 10px;">
        <ul class="list-inline" style="font-size: 12px;padding-top: 10px;">
            <li class="${param.state == null || param.state > 3 || param.state < 0 ? 'myactive':''}"
                style="padding: 5px 40px;">
                <a href="${pageContext.request.contextPath}/user/toHistoryOfBill">所有订单</a>
            </li>
            <li class="${param.state == 0 ? 'myactive':''}"
                style="padding: 5px 40px;border-left: dashed 1px #f8efc0;">
                <a href="${pageContext.request.contextPath}/user/toHistoryOfBill?state=0">待付款
                    <span class="label label-info">${requestScope.wait_to_pay}</span>
                </a>
            </li>
            <li class="${param.state == 1 ? 'myactive':''}"
                style="padding: 5px 40px;border-left: dashed 1px #f8efc0;">
                <a href="${pageContext.request.contextPath}/user/toHistoryOfBill?state=1">待发货
                    <span class="label label-info">${requestScope.wait_to_send}</span>
                </a>
            </li>
            <li class="${param.state == 2 ? 'myactive':''}"
                style="padding: 5px 40px;border-left: dashed 1px #f8efc0;">
                <a href="${pageContext.request.contextPath}/user/toHistoryOfBill?state=2">待收货
                    <span class="label label-info">${requestScope.wait_to_take}</span>
                </a>
            </li>
            <li class="${param.state == 3 ? 'myactive':''}"
                style="padding: 5px 40px;border-left: dashed 1px #f8efc0;">
                <a href="${pageContext.request.contextPath}/user/toHistoryOfBill?state=3">待评价
                    <span class="label label-info">${requestScope.wait_to_eval}</span>
                </a>
            </li>
        </ul>
    </div>
    <div style="padding: 10px 0;margin-bottom: 20px;">
        <c:if test="${requestScope.pageResult.rows.size() == 0}">
            <div class="text-center" style="border: solid 1px rgb(0,0,0,.1);padding: 20px 10px;">
                <span style="color: red;">诶，还没购买过商品呢...</span>
            </div>
        </c:if>
        <c:forEach items="${requestScope.pageResult.rows}" var="bill">
            <fmt:formatDate value="${bill.createTime}" var="createTime" scope="page" timeZone="GMT+8"
                            pattern="yyyy-MM-dd HH:mm:ss"/>
            <table class="table table-bordered" style="font-size: 12px;">
                <tr>
                    <td>
                        订单编号：${bill.sn}
                        &ensp;&ensp;
                        创建时间：${createTime}
                        &ensp;&ensp;
                        <c:if test="${bill.state == 3 || bill.state == 4}">
                            <fmt:formatDate value="${bill.takeTime}" var="takeTime" scope="page" timeZone="GMT+8"
                                            pattern="yyyy-MM-dd HH:mm:ss"/>
                            交易完成时间：${takeTime}
                        </c:if>
                        <div class="pull-right" style="padding-right: 20px;">
                            订单状态：
                            <c:choose>
                                <c:when test="${bill.state == -1}">
                                    <b>订单取消</b>
                                </c:when>
                                <c:when test="${bill.state == 0}">
                                    <b class="text-danger">待付款</b>
                                </c:when>
                                <c:when test="${bill.state == 1}">
                                    <b class="text-success">待发货</b>
                                </c:when>
                                <c:when test="${bill.state == 2}">
                                    <b class="text-success">待收货</b>
                                </c:when>
                                <c:when test="${bill.state == 3}">
                                    <b class="text-success">待评价</b>
                                </c:when>
                                <c:otherwise>
                                    <b class="text-primary">交易完成</b>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <ul class="list-inline" style="margin-bottom: 0;">
                            <li style="width: 50%;"><i>商品信息</i></li>
                            <li style="width: 15%;"><i>单价</i></li>
                            <li style="width: 18%;"><i>数量</i></li>
                            <li style="width: 15%;"><i>总价</i></li>
                        </ul>
                    </td>
                </tr>
                <c:forEach items="${bill.items}" var="item">
                    <tr align="center">
                        <td>
                            <ul class="list-inline" style="margin-bottom: 0;">
                                <li style="width: 50%;">
                                    <div class="pull-left">
                                        <img src="${item.goods.imgs.split(',')[0]}" width="50" height="50">
                                    </div>
                                    <div class="pull-left" style="width: 300px;padding-left: 10px;">
                                        <a href="${pageContext.request.contextPath}/getAllById?id=${item.goods.id}"
                                           target="_blank">${item.goods.name}</a>
                                    </div>
                                </li>
                                <li style="width: 15%;">${item.salePrice}</li>
                                <li style="width: 18%;">${item.num}</li>
                                <li style="width: 15%;color: red;">${item.amount}</li>
                            </ul>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td>
                        <ul class="list-inline" style="margin-bottom: 0;">
                            <li style="width: 83%;">
                                <button type="button" class="btn-link">查看详情</button>
                                <button type="button" class="btn-link">删除订单</button>
                                <div class="pull-right">
                                    <c:choose>
                                        <c:when test="${bill.state == 0}">
                                            <button type="button" class="btn btn-danger btn-xs">去付款</button>
                                        </c:when>
                                        <c:when test="${bill.state == 1}">
                                            <button type="button" class="btn-link">提醒发货</button>
                                        </c:when>
                                        <c:when test="${bill.state == 2}">
                                            <button type="button" class="btn-link">查看物流</button>
                                            <button type="button" class="btn btn-danger btn-xs">确认收货</button>
                                        </c:when>
                                        <c:when test="${bill.state == 3}">
                                            <button type="button" class="btn-link">交易评价</button>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </li>
                            <li style="width: 15%;">实付款：
                                <b style="color: red;font-size: 16px;">￥${bill.totalAmount}</b>
                            </li>
                        </ul>
                    </td>
                </tr>
            </table>
        </c:forEach>
        <div style="padding: 0 10px;font-size: 12px;">
            <i class="pull-left">共${pageResult.totalCount}条记录</i>
            <div class="pull-right">
                <a href="${pageContext.request.contextPath}/user/toHistoryOfBill?currentPage=${pageResult.prevPage}&state=${param.state}"
                   class="btn-link">上一页</a>&ensp;&ensp;
                <a href="${pageContext.request.contextPath}/user/toHistoryOfBill?currentPage=${pageResult.nextPage}&state=${param.state}"
                   class="btn-link">下一页</a>
            </div>
            <p class="text-center">
                <i>
                    第${pageResult.currentPage}页
                    /
                    共${pageResult.totalPage}页
                </i>
            </p>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/fixed.jsp" %>
</body>
</html>