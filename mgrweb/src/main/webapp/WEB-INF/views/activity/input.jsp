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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>活动详情</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/laydate/laydate.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/views/activity/input.js"></script>
    <script src="${pageContext.request.contextPath}/js/views/activity/common.js"></script>

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
<%-- 页面主体内容 --%>
<div class="panel panel-default">
    <div class="panel-heading">
        <a href="javascript:history.back()" class="btn btn-default btn-xs pull-left" data-toggle="tooltip"
           data-placement="bottom" title="返回">
            <span class="glyphicon glyphicon-menu-left"></span>
        </a>
        <c:if test="${param.id == null}">
            <center>新增活动</center>
        </c:if>
        <c:if test="${param.id != null}">
            <a href="javascript:forceEnd(${param.id})"
               class="btn btn-default pull-right btn-xs" data-toggle="tooltip" data-placement="bottom" title="撤销活动">
                <span class="glyphicon glyphicon-minus"></span>
            </a>
            <center>活动详情</center>
        </c:if>
    </div>
    <div class="panel-body" style="min-height: 450px;">
        <div style="width: 70%;margin-left: 15%;">
            <form id="activityForm">
                <%--解决输入框单击enter刷新页面的问题--%>
                <input type="text" hidden>
                <c:if test="${param.id != null}">
                    <input type="hidden" name="id" value="${param.id}">
                </c:if>
                <div class="form-group row">
                    <div class="col-sm-8">
                        <div class="input-group">
                            <span class="input-group-addon">活动标题</span>
                            <input type="text" name="title" value="${activity.title}" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <span class="input-group-addon">活动折扣</span>
                            <input type="number" name="discount" min="0" max="10" step="0.5"
                                   value="${activity.discount}" class="form-control">
                        </div>
                    </div>
                </div>
                <c:if test="${param.id == null}">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon">活动时间</span>
                            <input type="text" id="beginTime" name="beginTime" value="${activity.beginTime}"
                                   class="form-control" placeholder="开始时间">
                            <span class="input-group-addon">-</span>
                            <input type="text" id="endTime" name="endTime" class="form-control" placeholder="结束时间">
                        </div>
                    </div>
                </c:if>
                <c:if test="${param.id != null}">
                    <fmt:formatDate value="${activity.beginTime}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="GMT+8"
                                    var="beginTime" scope="page"/>
                    <fmt:formatDate value="${activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="GMT+8"
                                    var="endTime" scope="page"/>
                    <div class="form-group row">
                        <div class="col-sm-2">
                            <span class="control-label">活动时间:</span>
                        </div>
                        <div class="col-sm-4">
                            <p>${beginTime}</p>
                        </div>
                        <div class="col-sm-1">
                            <span class="control-label">至</span>
                        </div>
                        <div class="col-sm-4">
                            <p>${endTime}</p>
                        </div>
                    </div>
                </c:if>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">活动说明</span>
                        <textarea class="form-control" name="intro"
                                  style="height: 150px;width: 560px;resize: none;">${activity.intro}</textarea>
                    </div>
                </div>
            </form>
            <div style="position: relative;">
                <p style="color: rgb(0,0,0,.3);position: absolute;top: -10px;left: 40%;">参与该活动的商品</p>
                <HR width="80%" SIZE=5>
            </div>
            <div class="table-responsive">
                <input type="hidden" name="ids" value="${ids}">
                <table class="table table-bordered table-hover text-center goods">
                    <tr class="active">
                        <td>#</td>
                        <td>商品编码</td>
                        <td>商品名称</td>
                        <td>操作</td>
                    </tr>
                    <c:if test="${param.id != null}">
                        <c:forEach items="${activity.goods}" var="goods">
                            <tr>
                                <td>${goods.id}</td>
                                <td>${goods.sn}</td>
                                <td>${goods.name}</td>
                                <td>
                                    <a href="javascript:" data-toggle="tooltip" data-placement="bottom" title="移除"
                                       data-id="${goods.id}">
                                        <span class="glyphicon glyphicon-minus"></span>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-6">
                    <input id="showGoods" type="button" class="btn btn-default form-control" value="添加活动商品">
                </div>
                <div class="col-sm-6">
                    <c:if test="${param.id == null || activity.state == Activity.COMING}">
                        <input id="submitActivity" type="button" value="保存活动信息" class="btn btn-info form-control">
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
