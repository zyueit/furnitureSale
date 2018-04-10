<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人中心-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>
</head>

<script>
    $(function () {
        $("#headimg").hover(function () {
            $(this).find('p').show();
        }, function () {
            $(this).find('p').hide();
        });
    });
</script>

<body>
<%@ include file="/WEB-INF/views/common/person-header.jsp" %>
<div class="container" style="padding: 0 8%;">
    <div style="border: solid 1px rgb(0,0,0,.1);width: 100%;padding: 5px 10px;">
        <ul class="list-inline pull-right" style="margin-top: 11px;font-size: 12px;">
            <li style="padding: 5px 40px;border-left: dashed 1px #f8efc0;">
                <a href="javascript:">待付款 <span class="label label-info">0</span></a>
            </li>
            <li style="padding: 5px 40px;border-left: dashed 1px #f8efc0;">
                <a href="javascript:">待发货 <span class="label label-info">0</span></a>
            </li>
            <li style="padding: 5px 40px;border-left: dashed 1px #f8efc0;">
                <a href="javascript:">待收货 <span class="label label-info">0</span></a>
            </li>
            <li style="padding: 5px 40px;border-left: dashed 1px #f8efc0;">
                <a href="javascript:">待评价 <span class="label label-info">0</span></a>
            </li>
        </ul>
        <a href="">
            <div id="headimg" style="background: url('${pageContext.request.contextPath}/img/timg.jpg') -5px -24px;
                    width: 50px;height: 50px;border-radius: 25px;opacity: .6;float: left;text-align: center;">
                <p style="width: 50px;height: 50px;border-radius: 25px;font-size: 10px;color: #FFFFFF;
                background-color: #0f0f0f;opacity: .8;padding-top: 20px;" hidden>
                    编辑资料
                </p>
            </div>
        </a>
        <div style="height: 50px;width: 200px;margin-left: 60px;padding-top: 15px;">
            <a href="">
                ${sessionScope[UserContext.USER_IN_SESSION].username}
            </a>
            <span class="label label-info">
                <c:choose>
                    <c:when test="${sessionScope[UserContext.USERINFO_IN_SESSION].state == 0 || sessionScope[UserContext.USERINFO_IN_SESSION].state == -1}">
                        <small>未实名</small>
                    </c:when>
                    <c:when test="${sessionScope[UserContext.USERINFO_IN_SESSION].state == 1}">
                        <small>实名审核中</small>
                    </c:when>
                    <c:when test="${sessionScope[UserContext.USERINFO_IN_SESSION].state == 2}">
                        <small>已实名</small>
                    </c:when>
                </c:choose>
            </span>
        </div>
    </div>

    <div style="width: 100%;padding: 5px;border: solid 1px rgb(0,0,0,.1);margin-top: 20px;background-color: rgb(0,0,0,.05);">
        <h5><b>本站精选</b>&ensp;&ensp;
            <small>猜你喜欢</small>
        </h5>
    </div>
    <div class="col-sm-12" style="padding: 1em 0; column-count: 5;">
        <c:forEach items="${recommend}" var="item">
            <a href="${pageContext.request.contextPath}/getAllById?id=${item.id}">
                <img src="${item.imgs.split(",")[0]}" height="200" width="100%">
                <div style="background-color: rgb(0,0,0,.01);padding: 10px 0;margin-bottom: 1em;font-size: 12px;">
                    <div class="goods-title" title="${item.name}"
                         style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
                            ${item.name}
                    </div>
                    <div class="text-center">
                        <c:if test="${item.discountPrice != null}">
                            <span style="font-size: 12px;color: red;">￥${item.discountPrice}</span>
                            <s style="font-size: 12px;color: #adadad;">￥${item.salePrice}</s>
                        </c:if>
                        <c:if test="${item.discountPrice == null}">
                            <span style="font-size: 12px;color: red;">￥${item.salePrice}</span>
                        </c:if>
                        <span style="font-size: 12px;color: #adadad;">|
                                    已售：<span class="text-info">${item.saleCount}</span>
                        </span>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/fixed.jsp" %>
</body>
</html>