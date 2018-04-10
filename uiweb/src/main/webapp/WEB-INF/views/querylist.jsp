<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品浏览-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>
</head>

<script>
    $(function () {
        $("#conditionsForm").on('change', 'select,input', function () {
            submitForm(1);
        });
    });

    //分页按钮单击事件
    function submitForm(currentPage) {
        var conditionsForm = $("#conditionsForm");
        var keyword = $(":input[name='keyword']").val();
        conditionsForm.prop('action', '${pageContext.request.contextPath}/queryByCondition?keyword=' + keyword);
        $(":input[name='currentPage']").val(currentPage);
        conditionsForm.submit();
    }

    function sortGoods(index) {
        $(":input[name='sort']").val(index);
        submitForm(1);
    }
</script>

<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid" style="background-color: rgb(0,0,0,.02);">
    <div class="container">
        <div class="row" style="margin: 20px 7%;border: solid 1px rgb(0,0,0,.1);">
            <div style="background-color: rgb(0,0,0,.05);width: 100%;padding: 5px 10px;margin-bottom: 5px;font-size: 12px;">
                <span>按条件查询：</span>
            </div>
            <div style="width: 100%;padding: 5px 10px;font-size: 12px;">
                <form id="conditionsForm" method="post" class="form-inline">
                    <input type="hidden" name="currentPage">
                    <input type="hidden" name="sort" value="${param.sort}">
                    <div class="form-group">
                        <span class="control-label">风格:</span>
                        <select name="style" class="form-control input-sm">
                            <option value="">请选择</option>
                            <c:forEach items="${style}" var="item">
                                <option ${param.style eq item.name ? 'selected':''}>${item.name}</option>
                            </c:forEach>
                        </select>
                    </div>&ensp;
                    <div class="form-group">
                        <span class="control-label">用料:</span>
                        <select name="material" class="form-control input-sm">
                            <option value="">请选择</option>
                            <c:forEach items="${material}" var="item">
                                <option ${param.material eq item.name ? 'selected':''}>${item.name}</option>
                            </c:forEach>
                        </select>
                    </div>&ensp;
                    <div class="form-group">
                        <span class="control-label">摆放位置:</span>
                        <select name="roomId" class="form-control input-sm">
                            <option value="">请选择</option>
                            <c:forEach items="${room}" var="item">
                                <option value="${item.id}" ${param.roomId eq item.id ? 'selected':''}>${item.name}</option>
                            </c:forEach>
                        </select>
                    </div>&ensp;
                    <c:if test='${param.roomId != null && param.roomId != ""}'>
                        <div class="form-group">
                            <span class="control-label">种类:</span>
                            <select name="type" class="form-control input-sm">
                                <option value="">请选择</option>
                                <c:forEach items="${type}" var="item">
                                    <option ${param.type eq item.name ? 'selected':''}>${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        &ensp;
                    </c:if>
                    <div class="form-group">
                        <span class="control-label">价格区间:</span>
                        <input type="number" name="lowMoney" value="${param.lowMoney}" class="form-control input-sm"
                               style="width: 100px;">
                        -
                        <input type="number" name="highMoney" value="${param.highMoney}" class="form-control input-sm"
                               style="width: 100px;">
                    </div>
                </form>
            </div>
        </div>
        <div class="row" style="margin: 20px 7%;border: solid 1px rgb(0,0,0,.1);padding-bottom: 20px;">
            <div style="background-color: rgb(0,0,0,.05);width: 100%;padding: 5px 10px;margin-bottom: 5px;">
                <div id="sort" class="pull-left">
                    <span style="font-size: 12px;">排序：</span>
                    <a href="javascript:sortGoods(-1)" title="销量降序"
                       class="btn btn-default btn-xs ${param.sort != 2 && param.sort != 1 ? 'active' : ''}">销量</a>
                    <a href="javascript:sortGoods(2)" title="价格从低到高"
                       class="btn btn-default btn-xs ${param.sort == 2 ? 'active' : ''}">价格</a>
                    <a href="javascript:sortGoods(1)" title="最新"
                       class="btn btn-default btn-xs ${param.sort == 1 ? 'active' : ''}">发布时间</a>
                </div>
                <p class="text-right" style="font-size: 12px;padding-top: 3px;">共找到${pageResult.totalCount}条记录</p>
            </div>
            <c:if test="${pageResult.totalCount == 0}">
                <div class="col-sm-12 text-center" style="margin: 30px 0;">
                    <span style="color: red;">没有找到相关的家具商品呢！0.0</span>
                </div>
            </c:if>
            <c:forEach items="${pageResult.rows}" var="item">
                <div class="col-sm-4" style="margin: 15px 0;">
                    <a href="${pageContext.request.contextPath}/getAllById?id=${item.id}">
                        <img src="${item.imgs.split(",")[0]}" height="200" width="100%">
                        <div style="padding: 10px 10px;background-color: #FFFFFF;">
                            <div title="${item.name}"
                                 style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
                                    ${item.name}
                            </div>
                            <div class="text-center">
                                <c:if test="${item.discountPrice != null}">
                                    <span style="font-size: 16px;color: red;">￥${item.discountPrice}</span>
                                    <s style="font-size: 16px;color: #adadad;">￥${item.salePrice}</s>
                                </c:if>
                                <c:if test="${item.discountPrice == null}">
                                    <span style="font-size: 16px;color: red;">￥${item.salePrice}</span>
                                </c:if>
                                <span style="font-size: 12px;color: #adadad;">|
                                    已售：<span class="text-info">${item.saleCount}</span>
                                </span>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
            <div class="col-sm-12 text-center">
                <a href="javascript:submitForm(1)" class="btn btn-default">首页</a>
                <a href="javascript:submitForm(${pageResult.prevPage})" class="btn btn-default">上一页</a>
                <span>当前${pageResult.currentPage}页/总共${pageResult.totalPage}页</span>
                <a href="javascript:submitForm(${pageResult.nextPage})" class="btn btn-default">下一页</a>
                <a href="javascript:submitForm(${pageResult.totalPage})" class="btn btn-default">尾页</a>
            </div>
        </div>
        <div class="row" style="margin: 20px 7%;">
            <div style="background-color: rgb(0,0,0,.05);width: 100%;padding: 5px 10px;margin-bottom:10px;">
                <b style="font-size: 16px;">新品销售</b>
            </div>
            <div id="newGoods" class="column" style="column-count: 6;">
                <c:forEach items="${newGoods}" var="item" varStatus="num">
                    <c:if test="${num.count < 7}">
                        <a href="${pageContext.request.contextPath}/getAllById?id=${item.id}">
                            <img src="${item.imgs.split(",")[0]}" height="120" width="100%">
                            <div style="background-color:#FFFFFF;height: 45px;">
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
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/fixed.jsp" %>
</body>
</html>