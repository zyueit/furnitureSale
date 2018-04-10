<%--
  Created by IntelliJ IDEA.
  User: QQ
  Date: 2018/3/26
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>查看商品信息</title>
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

        p {
            color: rgb(0, 0, 0, .5);
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

        function approveUserInfo(bool) {
            $.ajax({
                type: 'get',
                data: {id:${userInfo.id}, bool: bool},
                dataType: 'json',
                url: "${pageContext.request.contextPath}/approveUserInfo",
                success: function (data) {
                    if (data.success) {
                        layer.open({
                            title: '温馨提示',
                            icon: 6,
                            content: data.msg,
                            yes: toList,
                            cancel: toList
                        });
                    } else {
                        layer.open({
                            title: '温馨提示',
                            icon: 5,
                            content: data.msg
                        });
                    }
                }
            });
        }

        function toList(index) {
            layer.close(index);
            location.href = '${pageContext.request.contextPath}/listRealNameCheck';
        }
    </script>
</head>
<body>
<%-- 解决单独的js文件获取上下文路径问题 --%>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">

<%-- 页面主体内容 --%>
<div class="panel panel-default">
    <div class="panel-heading">
        <div class="pull-left">
            <a href="javascript:history.back()" class="btn btn-default btn-xs" title="返回">
                <span class="glyphicon glyphicon-menu-left"></span>
            </a>
            <a href="javascript:location.reload()" class="btn btn-default btn-xs" title="刷新">
                <span class="glyphicon glyphicon-repeat"></span>
            </a>
        </div>
        <c:if test="${userInfo.state == 1}">
            <div class="pull-right">
                <a href="javascript:approveUserInfo(false)"
                   class="btn btn-default btn-xs" title="认证失败">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
                <a href="javascript:approveUserInfo(true)"
                   class="btn btn-default btn-xs" title="认证成功">
                    <span class="glyphicon glyphicon-ok"></span>
                </a>
            </div>
        </c:if>
        <center>用户实名认证材料</center>
    </div>
    <div class="panel-body" style="min-height: 400px;">
        <div style="width: 80%;margin-left: 10%;">
            <c:if test="${userInfo.state == 1 || userInfo.state == 2}">
                <dl class="dl-horizontal">
                    <dt>真实名字</dt>
                    <dd>${userInfo.name}</dd>
                    <br>
                    <dt>性别</dt>
                    <dd>
                        <c:choose>
                            <c:when test="${userInfo.sex == 0}">
                                <span>女</span>
                            </c:when>
                            <c:when test="${userInfo.sex == 1}">
                                <span>男</span>
                            </c:when>
                            <c:otherwise>
                                <span>保密</span>
                            </c:otherwise>
                        </c:choose></dd>
                    <br>
                    <dt>身份证号码</dt>
                    <dd>${userInfo.IDcard}</dd>
                    <br>
                    <dt>现住地址</dt>
                    <dd>${userInfo.address}</dd>
                    <br>
                    <dt>手机号码</dt>
                    <dd>${userInfo.phone}</dd>
                    <br>
                    <dt>提交时间</dt>
                    <fmt:formatDate value="${userInfo.time}" var="time" scope="page"
                                    pattern="yyyy年MM月dd日 HH时mm分ss秒"
                                    timeZone="GMT+8"/>
                    <dd>${time}</dd>
                    <br>
                    <dt>证件图片</dt>
                    <dd>
                        <img src="${userInfo.imgs.split(',')[0]}"
                             width="40%" height="150">
                        <img src="${userInfo.imgs.split(',')[1]}"
                             width="40%" height="150">
                    </dd>
                </dl>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
