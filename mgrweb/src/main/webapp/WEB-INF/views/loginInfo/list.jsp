<%--
  Created by IntelliJ IDEA.
  User: QQ
  Date: 2018/3/26
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.domain.LoginInfo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/views/loginInfo/list.js"></script>

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

<c:if test="${cmd == LoginInfo.USER_CLIENT}" scope="page" var="ui"/>
<c:if test="${cmd == LoginInfo.USER_MANAGER}" scope="page" var="mg"/>
<div class="panel panel-default">
    <div class="panel-heading">
        <c:if test="${ui}">
            <center>前台用户登陆信息管理</center>
        </c:if>
        <c:if test="${mg}">
            <center>后台用户登陆信息管理</center>
        </c:if>
    </div>
    <div class="panel-body" style="min-height: 400px;">
        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center">
                <tr>
                    <td colspan="6">
                        <form id="queryForm" action="${pageContext.request.contextPath}/getLoginInfo" method="post">
                            <%--解决输入框单击enter刷新页面的问题--%>
                            <input type="text" hidden>
                            <%-- 当前请求登陆用户信息的类型 --%>
                            <input type="hidden" name="userType" value="${requestScope.cmd}">
                            <input name="currentPage" type="hidden">
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <span class="input-group-addon">关键字</span>
                                    <input type="text" name="keyword" value="${param.keyword}"
                                           class="form-control" placeholder="用户名">
                                </div>
                            </div>
                            <c:if test="${ui}">
                                <div class="col-sm-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">实名认证</span>
                                        <select name="state" class="form-control" title="认证查询">
                                            <option value="-1">请选择</option>
                                            <option value="0" ${param.state == 0 ? 'selected' : ''}>未实名</option>
                                            <option value="1" ${param.state == 1 ? 'selected' : ''}>审核中</option>
                                            <option value="2" ${param.state == 2 ? 'selected' : ''}>已实名</option>
                                        </select>
                                    </div>
                                </div>
                            </c:if>
                            <div class="col-sm-1">
                                <a id="queryBtn" class="btn btn-default">查询</a>
                            </div>
                        </form>
                    </td>
                </tr>
                <tr class="active">
                    <td>#</td>
                    <td>用户名</td>
                    <td>最近一次登陆时间</td>
                    <c:if test="${ui}">
                        <td>手机号码</td>
                        <td>账号实名认证状态</td>
                    </c:if>
                    <td>操作</td>
                </tr>
                <c:if test="${requestScope.pageResult.rows == null}">
                    <tr>
                        <td colspan="5"><span class="text-danger text-center">好像没有你想要的信息！0.0</span></td>
                    </tr>
                </c:if>
                <c:forEach items="${requestScope.pageResult.rows}" var="user" varStatus="tr">
                    <tr>
                        <td>${tr.count}</td>
                        <td>${user.username}</td>
                        <fmt:formatDate value="${user.loginTime}" var="loginTime" scope="page"
                                        pattern="yyyy年MM月dd日 HH时mm分ss秒" timeZone="GMT+8"/>
                        <td>${loginTime}</td>
                        <c:if test="${ui}">
                            <td>${user.userInfo.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.userInfo.state == 0 || user.userInfo.state == -1}">
                                        <span class="text-danger">未实名</span>
                                    </c:when>
                                    <c:when test="${user.userInfo.state == 1}">
                                        <span class="text-info">审核中</span>
                                    </c:when>
                                    <c:when test="${user.userInfo.state == 2}">
                                        <span class="text-success">已实名</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${user.userInfo.state != 0 && user.userInfo.state != -1}">
                                    <a href="${pageContext.request.contextPath}/showUserInfo?id=${user.id}"
                                       title="查看个人信息">
                                        <span class="glyphicon glyphicon-eye-open"></span>
                                    </a>
                                </c:if>
                            </td>
                        </c:if>
                        <c:if test="${mg}">
                            <td>
                                <a href="javascript:resetPassword(${user.id})" title="密码重置">
                                    <span class="glyphicon glyphicon-cog"></span>
                                </a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="panel-footer text-center">
        <%@ include file="/WEB-INF/views/common/page.jsp" %>
        <span class="text-right">总共${requestScope.pageResult.totalCount}位用户</span>
    </div>
</div>
</body>
</html>
