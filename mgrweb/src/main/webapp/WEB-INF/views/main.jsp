<%--
  Created by IntelliJ IDEA.
  User: QQ
  Date: 2018/3/24
  Time: 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ page import="club.ming19.furnitureSales.domain.LoginInfo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MingMini家具后台管理系统</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>

    <style type="text/css">
        body {
            font-family: '微软雅黑', serif;
            background: rgb(192, 192, 192, .3);
            background-size: cover;
        }

        #mynav li {
            background-color: rgb(0, 0, 0, .05);
            cursor: pointer;
        }
    </style>

    <script type="application/javascript">
        $(function () {
            $("#mynav").on('click', 'li', function () {
                $("#mynav li").removeClass("active");
                $(this).addClass("active");
                $("#myframe").prop('src', '${pageContext.request.contextPath}' + $(this).data("page"));
            });

            //让iframe的高度随子页面的高度变化
            $("#myframe").load(function () {
                var mainheight = $(this).contents().find("body").height();
                mainheight = mainheight < 400 ? 400 : mainheight + 100;
                $(this).height(mainheight);
            });
        });
    </script>
</head>
<body>
<div class="container">
    <%-- 页头 --%>
    <img src="${pageContext.request.contextPath}/img/logo_sm.png" alt="logo">
    <span style="font-size: 20px;color: rgb(0,0,0,.5)">家具销售后台管理系统登录</span>
    <div style="display: inline-block;float: right;padding-top: 40px;">
        当前用户：<span
            style="color: #3c763d;"><%= ((LoginInfo) session.getAttribute(UserContext.USER_IN_SESSION)).getUsername() %></span>
        &ensp;&ensp;
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-success">安全退出</a>
    </div>
    <HR width="100%" style="border-color: rgb(0,0,0,.1)" SIZE=5>

    <%-- 导航列表组 --%>
    <div class="row">
        <div id="mynav" class="col-md-2">
            <ul class="list-group">
                <li class="list-group-item" data-page="/getLoginInfo?userType=<%= LoginInfo.USER_CLIENT %>">
                    前台用户管理<span class="badge">&raquo;</span>
                </li>
                <li class="list-group-item" data-page="/getLoginInfo?userType=<%= LoginInfo.USER_MANAGER %>">
                    后台用户管理<span class="badge">&raquo;</span>
                </li>
                <li class="list-group-item" data-page="/listRealNameCheck">
                    前台实名认证<span class="badge">&raquo;</span>
                </li>
                <li class="list-group-item" data-page="/listSystemDictionary">
                    数据字典管理<span class="badge">&raquo;</span>
                </li>
                <li class="list-group-item" data-page="/listGoods">
                    商品管理<span class="badge">&raquo;</span>
                </li>
                <li class="list-group-item" data-page="/ui_loginInfo">
                    订单管理<span class="badge">&raquo;</span>
                </li>
                <li class="list-group-item" data-page="/ui_loginInfo">
                    售后管理<span class="badge">&raquo;</span>
                </li>
                <li class="list-group-item" data-page="/listActivities">
                    活动管理<span class="badge">&raquo;</span>
                </li>
            </ul>
        </div>

        <%-- 管理页面 --%>
        <div class="col-md-10">
            <iframe id="myframe" frameborder="no" scrolling="no" width="100%" allowtransparency="true" height="400"
                    src="${pageContext.request.contextPath}/getLoginInfo?userType=<%= LoginInfo.USER_CLIENT %>"></iframe>
        </div>
    </div>

    <HR width="100%" style="border-color: rgb(0,0,0,.1)" SIZE=5>
    <%-- 页底 --%>
    <div style="color: rgb(0,0,0,.3);margin-bottom: 50px;">
        <center>Copyright © 2004 - 2018 MingMini家具 ming19.club 版权所有</center>
        <br>
        <center>联系管理员：tel-4006067733 | qq-835644640</center>
    </div>
</div>
</body>
</html>
