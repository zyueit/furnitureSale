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
    <title>查看活动信息</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/views/activity/common.js"></script>


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

        //提交活动评估
        function submitEstimate() {
            if ($("#estimateForm [name='estimate']").val() < -1) {
                layer.open({
                    title: '温馨提示',
                    icon: 5,
                    content: '活动评估等级还没选呢！赶快去选一项吧...'
                });
            } else if (!$("#estimateForm [name='esIntro']").val().trim()) {
                layer.open({
                    title: '温馨提示',
                    icon: 5,
                    content: '活动评估说明必须填哦！'
                });
            } else {
                $.ajax({
                    type: 'post',
                    data: $("#estimateForm").serialize(),
                    dataType: 'json',
                    url: $("#basePath").val() + '/updateEstimate',
                    success: function (data) {
                        if (data.success) {
                            layer.open({
                                title: '温馨提示',
                                icon: 6,
                                content: data.msg,
                                yes: reloadPg,
                                cancel: reloadPg
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
        }

        function reloadPg(index) {
            layer.close(index);
            location.reload();
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
            <a href="javascript:history.back()" class="btn btn-default btn-xs" data-toggle="tooltip"
               data-placement="bottom" title="返回">
                <span class="glyphicon glyphicon-menu-left"></span>
            </a>
            <a href="javascript:location.reload()" class="btn btn-default btn-xs" data-toggle="tooltip"
               data-placement="bottom" title="刷新">
                <span class="glyphicon glyphicon-repeat"></span>
            </a>
        </div>
        <c:if test="${activity.state == Activity.MOTION}">
            <a href="javascript:forceEnd(${activity.id})" class="btn btn-default btn-xs pull-right"
               data-toggle="tooltip"
               data-placement="bottom" title="强制撤销活动">
                <span class="glyphicon glyphicon-minus"></span>
            </a>
        </c:if>
        <center>活动详情</center>
    </div>
    <div class="panel-body">
        <div style="width: 70%;margin-left: 15%;">
            <div class="form-group row">
                <div class="col-sm-4">
                    <span class="control-label">活动标题:</span>
                    <p class="form-control-static">${activity.title}</p>
                </div>
                <div class="col-sm-4">
                    <span class="control-label">活动折扣:</span>
                    <p class="form-control-static">${activity.discount}</p>
                </div>
                <div class="col-sm-4">
                    <span class="control-label">状态:</span>
                    <p class="form-control-static">
                        <c:choose>
                            <c:when test="${activity.state  == Activity.COMING}">
                                <span class="text-danger">即将开始</span>
                            </c:when>
                            <c:when test="${activity.state  == Activity.MOTION}">
                                <span class="text-info">进行中</span>
                            </c:when>
                            <c:when test="${activity.state  == Activity.END}">
                                <span class="text-success">正常结束</span>
                            </c:when>
                            <c:when test="${activity.state  == Activity.FORCE_END}">
                                <span class="text-active">强制结束</span>
                            </c:when>
                        </c:choose>
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <fmt:formatDate value="${activity.beginTime}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="GMT+8"
                                var="beginTime" scope="page"/>
                <fmt:formatDate value="${activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="GMT+8"
                                var="endTime" scope="page"/>
                <div class="col-sm-6">
                    <span class="control-label">活动开始时间:</span>
                    <p class="form-control-static">${beginTime}</p>
                </div>
                <div class="col-sm-6">
                    <span class="control-label">活动结束时间:</span>
                    <p class="form-control-static">${endTime}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-12">
                    <span class="control-label">活动简介:</span>
                    <p class="form-control-static">${activity.intro}</p>
                </div>
            </div>
            <div style="position: relative;">
                <p style="color: rgb(0,0,0,.3);position: absolute;top: -10px;left: 48%;">参与活动的商品</p>
                <HR width="80%" SIZE=5>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-hover text-center">
                    <tr>
                        <td>#</td>
                        <td>商品编码</td>
                        <td>商品名称（标题）</td>
                        <td>操作</td>
                    </tr>
                    <c:if test="${activity.goods.size() == 0}">
                        <tr>
                            <td colspan="4"><span class="text-danger">没有商品参与的活动-0.0</span></td>
                        </tr>
                    </c:if>
                    <c:forEach items="${activity.goods}" var="goods">
                        <tr>
                            <td>${goods.id}</td>
                            <td>${goods.sn}</td>
                            <td>${goods.name}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/showGoods?id=${goods.id}"
                                   data-toggle="tooltip" data-placement="bottom" title="查看商品信息">
                                    <span class="glyphicon glyphicon-eye-open"></span>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <c:if test="${activity.state == Activity.END || activity.state == Activity.FORCE_END}">
                <div style="position: relative;">
                    <p style="color: rgb(0,0,0,.3);position: absolute;top: -10px;left: 48%;">活动评估</p>
                    <HR width="80%" SIZE=5>
                </div>
                <c:if test="${activity.esState}">
                    <div class="form-group row">
                        <div class="col-sm-3">
                            <span class="control-label">活动评估等级:</span>
                        </div>
                        <div class="col-sm-9">
                            <c:choose>
                                <c:when test="${activity.estimate  == Activity.FAILURE}">
                                    <span class="text-danger">失败的活动</span>
                                </c:when>
                                <c:when test="${activity.estimate  == Activity.MEDIUM}">
                                    <span class="text-info">一般的活动</span>
                                </c:when>
                                <c:when test="${activity.estimate  == Activity.SUCCESS}">
                                    <span class="text-success">成功的活动</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-3">
                            <span class="control-label">活动评估说明:</span>
                        </div>
                        <div class="col-sm-9">
                            <p>${activity.esIntro}</p>
                        </div>
                    </div>
                </c:if>
                <c:if test="${!activity.esState}">
                    <form id="estimateForm">
                        <input type="hidden" name="id" value="${activity.id}">
                        <div class="form-group row">
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <span class="input-group-addon">活动评估等级</span>
                                    <select name="estimate" class="form-control">
                                        <option value="-2">请选择</option>
                                        <option value="${Activity.FAILURE}">失败的活动</option>
                                        <option value="${Activity.MEDIUM}">一般的活动</option>
                                        <option value="${Activity.SUCCESS}">成功的活动</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-2 pull-right">
                                <input type="button" class="btn btn-default" value="提交评估" onclick="submitEstimate()">
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-addon">活动评估说明</span>
                                    <textarea name="esIntro" class="form-control"
                                              style="width: 100%;height: 100px;resize: none;"></textarea>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
