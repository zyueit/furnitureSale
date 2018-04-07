<%--
  Created by IntelliJ IDEA.
  User: QQ
  Date: 2018/3/26
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.domain.Activity" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>活动管理</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>

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
    </script>
</head>
<body>
<%-- 解决单独的js文件获取上下文路径问题 --%>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">
<%-- 页面主体 --%>
<div class="panel panel-default">
    <div class="panel-heading">
        <a href="${pageContext.request.contextPath}/editActivity"
           class="btn btn-default pull-right btn-xs" data-toggle="tooltip" data-placement="bottom" title="新增活动">
            <span class="glyphicon glyphicon-plus"></span>
        </a>
        <center>系统活动管理</center>
    </div>
    <div class="panel-body" style="min-height: 400px;">
        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center">
                <tr class="active">
                    <td>#</td>
                    <td width="20%">活动标题</td>
                    <td width="40%">活动说明</td>
                    <td>活动状态</td>
                    <td>操作</td>
                </tr>
                <c:if test="${requestScope.list == null}">
                    <tr>
                        <td colspan="5"><span class="text-danger text-center">好像没有你想要的信息！0.0</span></td>
                    </tr>
                </c:if>
                <c:forEach items="${requestScope.list}" var="item" varStatus="tr">
                    <tr>
                        <td>${tr.count}</td>
                        <td>${item.title}</td>
                        <td>${item.intro}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.state  == Activity.COMING}">
                                    <span class="text-danger">即将开始</span>
                                </c:when>
                                <c:when test="${item.state  == Activity.MOTION}">
                                    <span class="text-info">进行中</span>
                                </c:when>
                                <c:when test="${item.state  == Activity.END}">
                                    <span class="text-success">正常结束</span>
                                </c:when>
                                <c:when test="${item.state  == Activity.FORCE_END}">
                                    <span class="text-active">强制结束</span>
                                </c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.state  == Activity.COMING}">
                                    <a href="${pageContext.request.contextPath}/editActivity?id=${item.id}"
                                       data-toggle="tooltip" data-placement="bottom" title="编辑">
                                        <span class="glyphicon glyphicon-edit"></span>
                                    </a>
                                </c:when>
                                <c:when test="${item.esState == true || item.state  == Activity.MOTION}">
                                    <a href="${pageContext.request.contextPath}/editActivity?id=${item.id}"
                                       data-toggle="tooltip" data-placement="bottom" title="查看详细信息">
                                        <span class="glyphicon glyphicon-eye-open"></span>
                                    </a>
                                </c:when>
                                <c:when test="${item.esState == false}">
                                    <a href="${pageContext.request.contextPath}/editActivity?id=${item.id}"
                                       data-toggle="tooltip" data-placement="bottom" title="活动评估">
                                        <span class="glyphicon glyphicon-comment"></span>
                                    </a>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>
