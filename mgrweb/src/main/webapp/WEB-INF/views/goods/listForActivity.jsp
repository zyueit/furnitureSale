<%--
  Created by IntelliJ IDEA.
  User: QQ
  Date: 2018/3/26
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品列表</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>

    <style type="text/css">
        body {
            font-family: '微软雅黑', serif;
            background: rgb(192, 192, 192, .05);
            background-size: cover;
        }
    </style>

    <script type="application/javascript">
        layer.load(0, {time: 1000});//加载层-时间1秒
        var msg = '${requestScope.msg}';
        if (msg) {
            layer.open({
                title: '温馨提示',
                icon: 0,
                content: msg
            });
        }
        $(function () {
            //单击查询，设置查询第一页，提交表单
            $("#queryBtn").click(function () {
                submitForm(1);
            });
        });

        //分页按钮单击事件
        function submitForm(currentPage) {
            $(":input[name='currentPage']").val(currentPage);
            $("#queryForm").submit();
        }

        $(function () {
            $(".search_goods").click(function () {
                window.close();
                window.opener.handle($(this).data('goods'));
            });
        });
    </script>
</head>
<body>
<%-- 解决单独的js文件获取上下文路径问题 --%>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">
<%-- 页面主体 --%>
<div class="panel panel-default">
    <div class="panel-body" style="min-height: 400px;">
        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center">
                <tr>
                    <td colspan="7">
                        <form id="queryForm" action="${pageContext.request.contextPath}/listForActivity" method="post">
                            <input type="hidden" name="currentPage">
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <span class="input-group-addon">关键字</span>
                                    <input type="text" name="keyword" value="${param.keyword}" class="form-control"
                                           placeholder="编码或名称">
                                </div>
                            </div>
                            <div class="col-xs-1">
                                <a id="queryBtn" class="btn btn-default">查询</a>
                            </div>
                        </form>
                    </td>
                </tr>
                <tr class="active">
                    <td>#</td>
                    <td>商品编码</td>
                    <td>商品名称</td>
                    <td>商品状态</td>
                    <td>操作</td>
                </tr>
                <c:if test="${requestScope.pageResult.rows == null}">
                    <tr>
                        <td colspan="7"><span class="text-danger text-center">好像没有你想要的信息！0.0</span></td>
                    </tr>
                </c:if>
                <c:forEach items="${requestScope.pageResult.rows}" var="item" varStatus="tr">
                    <tr>
                        <td>${tr.count}</td>
                        <td>${item.sn}</td>
                        <td>${item.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.state == 0}">
                                    <span class="text-active">下架啦！</span>
                                </c:when>
                                <c:when test="${item.state == 1}">
                                    <span class="text-success">在售中！</span>
                                </c:when>
                            </c:choose>
                        </td>
                        <td>
                            <a class="search_goods" href="javascript:" data-toggle="tooltip" data-placement="bottom"
                               title="添加为活动商品" data-goods="[{id:${item.id},sn:'${item.sn}',name:'${item.name}'}]">
                                <span class="glyphicon glyphicon-plus"></span>
                            </a>
                            -
                            <a href="${pageContext.request.contextPath}/showForActivity?id=${item.id}"
                               data-toggle="tooltip" data-placement="bottom" title="查看详细信息">
                                <span class="glyphicon glyphicon-eye-open"></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="panel-footer text-center">
        <%@ include file="/WEB-INF/views/common/page.jsp" %>
        <span class="text-right">总共${requestScope.pageResult.totalCount}件商品</span>
    </div>
</div>
</body>
</html>
