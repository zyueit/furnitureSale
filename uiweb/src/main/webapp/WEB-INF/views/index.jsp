<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>
</head>
<style>
    #myCarousel p a {
        color: #FFFFFF;
    }

    .static div div {
        background-color: #FFFFFF;
        padding: 10px 0;
    }

    .static-height div img {
        height: 200px;
    }

    .column img {
        width: 100%;
        padding-top: 1em;
    }

    #recommend a {
        text-decoration-line: none;
        color: rgb(0, 0, 0, .8);
        font-size: 12px;
    }

    #newGoods a {
        text-decoration-line: none;
        color: rgb(0, 0, 0, .8);
        font-size: 14px;
    }

    .goods-title:hover {
        color: red;
    }
</style>

<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid" style="background-color: rgb(0,0,0,.02);padding-bottom: 30px;">
    <div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin: 0 -15px;">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
            <li data-target="#myCarousel" data-slide-to="3"></li>
            <li data-target="#myCarousel" data-slide-to="4"></li>
        </ol>
        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <img src="${pageContext.request.contextPath}/img/carousel_one.jpg" style="width: 100%;height: 400px;"
                     alt="carousel_one.jpg">
                <div class="carousel-caption">
                    <p><a href="${pageContext.request.contextPath}/getAllById?id=1">前去购买</a>&raquo;</p>
                </div>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/img/carousel_two.jpg" style="width: 100%;height: 400px;"
                     alt="carousel_two.jpg">
                <div class="carousel-caption">
                    <p><a href="${pageContext.request.contextPath}/getAllById?id=2">前去购买</a>&raquo;</p>
                </div>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/img/carousel_three.jpg" style="width: 100%;height: 400px;"
                     alt="carousel_three.jpg">
                <div class="carousel-caption">
                    <p><a href="${pageContext.request.contextPath}/getAllById?id=3">前去购买</a>&raquo;</p>
                </div>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/img/carousel_four.jpg" style="width: 100%;height: 400px;"
                     alt="carousel_four.jpg">
                <div class="carousel-caption">
                    <p><a href="${pageContext.request.contextPath}/getAllById?id=4">前去购买</a>&raquo;</p>
                </div>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/img/carousel_five.jpg" style="width: 100%;height: 400px;"
                     alt="carousel_five.jpg">
                <div class="carousel-caption">
                    <p><a href="${pageContext.request.contextPath}/getAllById?id=5">前去购买</a>&raquo;</p>
                </div>
            </div>
        </div>
        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>
    <div class="container">
        <div style="margin: 0 8%;">
            <div style="padding-top: 40px;position: relative;">
                <p style="color: rgb(0,0,0,.5);position: absolute;top: 30px;left: 47.5%;">风格多样</p>
                <HR width="60%" SIZE=5>
            </div>
            <div class="column static static-height" style="column-count: 4;">
                <div>
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=中式家具" title="中式家具">
                        <img src="${pageContext.request.contextPath}/img/style_one.jpg" alt="中式家具">
                        <div>中式家具</div>
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=欧式家具" title="欧式家具">
                        <img src="${pageContext.request.contextPath}/img/style_two.jpg" alt="欧式家具">
                        <div>欧式家具</div>
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=现代家具" title="现代家具">
                        <img src="${pageContext.request.contextPath}/img/style_three.jpg" alt="现代家具">
                        <div>现代家具</div>
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=美式家具" title="美式家具">
                        <img src="${pageContext.request.contextPath}/img/style_four.jpg" alt="美式家具">
                        <div>美式家具</div>
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=韩式家具" title="韩式家具">
                        <img src="${pageContext.request.contextPath}/img/style_five.jpg" alt="韩式家具">
                        <div>韩式家具</div>
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=古典家具" title="古典家具">
                        <img src="${pageContext.request.contextPath}/img/style_six.jpg" alt="古典家具">
                        <div>古典家具</div>
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=法式家具" title="法式家具">
                        <img src="${pageContext.request.contextPath}/img/style_seven.jpg" alt="法式家具">
                        <div>法式家具</div>
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/queryByCondition?style=地中海家具" title="地中海家具">
                        <img src="${pageContext.request.contextPath}/img/style_eight.jpg" alt="地中海家具">
                        <div>地中海家具</div>
                    </a>
                </div>
            </div>
            <div style="padding-top: 40px;position: relative;">
                <p style="color: rgb(0,0,0,.5);position: absolute;top: 30px;left: 47.5%;">新品热卖</p>
                <HR width="60%" SIZE=5>
            </div>
            <div id="newGoods" class="column" style="column-count: 3;">
                <c:forEach items="${newGoods}" var="item">
                    <a href="${pageContext.request.contextPath}/getAllById?id=${item.id}">
                        <img src="${item.imgs.split(",")[0]}" height="220" alt="新品热卖">
                        <div style="background-color:#FFFFFF;padding: 20px 0;">
                            <div title="${item.name}"
                                 style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
                                    ${item.name}
                            </div>
                            <div class="text-center">
                                <br>
                                <span style="padding: 5px 60px;background-color: rgb(0,0,0,.01);border: solid 1px rgb(0,0,0,.03);">
                                <c:if test="${item.discountPrice != null}">
                                    <span style="color: red;">￥${item.discountPrice}</span>
                                </c:if>
                                <c:if test="${item.discountPrice == null}">
                                    <span style="color: red;">￥${item.salePrice}</span>
                                </c:if>
                            </span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
            <div style="padding-top: 40px;position: relative;">
                <p style="color: rgb(0,0,0,.5);position: absolute;top: 30px;left: 47.5%;">精品推荐</p>
                <HR width="60%" SIZE=5>
            </div>
            <div id="recommend" class="column" style="column-count: 5;">
                <c:forEach items="${recommend}" var="item">
                    <div style="height: 240px;">
                        <a href="${pageContext.request.contextPath}/getAllById?id=${item.id}">
                            <img src="${item.imgs.split(",")[0]}" alt="精品推荐" height="180">
                            <div style="background-color:#FFFFFF;padding: 10px 0;">

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
                    </div>
                </c:forEach>
            </div>
            <div style="padding-top: 40px;position: relative;">
                <p style="color: rgb(0,0,0,.5);position: absolute;top: 30px;left: 47.5%;">按位置分类</p>
                <HR width="60%" SIZE=5>
            </div>
            <div class="column static" style="column-count: 6;">
                <div>
                    <a href="javascript:toQueryPage('livingroom')" title="客厅家具">
                        <img src="${pageContext.request.contextPath}/img/room_one.jpg" alt="客厅家具">
                        <div>客厅</div>
                    </a>
                </div>
                <div>
                    <a href="javascript:toQueryPage('bedroom')" title="卧室家具">
                        <img src="${pageContext.request.contextPath}/img/room_two.jpg" alt="卧室家具">
                        <div>卧室</div>
                    </a>
                </div>
                <div>
                    <a href="javascript:toQueryPage('kitchen')" title="餐厅/厨房家具">
                        <img src="${pageContext.request.contextPath}/img/room_three.jpg" alt="餐厅/厨房家具">
                        <div>厨房</div>
                    </a>
                </div>
                <div>
                    <a href="javascript:toQueryPage('courtyard')" title="庭院家具">
                        <img src="${pageContext.request.contextPath}/img/room_four.jpg" alt="庭院家具">
                        <div>庭院</div>
                    </a>
                </div>
                <div>
                    <a href="javascript:toQueryPage('entryway')" title="入口通道家具">
                        <img src="${pageContext.request.contextPath}/img/room_five.jpg" alt="入口通道家具">
                        <div>入口</div>
                    </a>
                </div>
                <div>
                    <a href="javascript:toQueryPage('boardroom')" title="书房家具">
                        <img src="${pageContext.request.contextPath}/img/room_six.jpg" alt="书房家具">
                        <div>书房</div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/fixed.jsp" %>
</body>
</html>