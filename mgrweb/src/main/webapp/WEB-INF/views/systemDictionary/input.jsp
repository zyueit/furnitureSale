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
    <title>编辑数据字典明细</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/views/systemDictionary/input.js"></script>

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
            var bool = false;//解决在提交表单后，按enter重复提交表单的问题
            $("#submit").click(function () {
                if (bool) {
                    return;
                }
                bool = true;
                $("#itemForm").submit();
            });
        });
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
            <center>新增数据字典明细</center>
        </c:if>
        <c:if test="${param.id != null}">
            <center>编辑数据字典明细</center>
        </c:if>
    </div>
    <div class="panel-body" style="min-height: 300px;">
        <div style="width: 50%;margin-left: 25%;">
            <form id="itemForm">
                <%--解决输入框单击enter刷新页面的问题--%>
                <input type="text" hidden>
                <input type="hidden" name="parent.id" value="${param.pid}">
                <c:if test="${param.id != null}">
                    <input type="hidden" name="id" value="${param.id}">
                </c:if>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">明细名称</span>
                        <input type="text" name="name" value="${item.name}" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">明细说明</span>
                        <textarea class="form-control" name="intro"
                                  style="height: 150px;width: 380px;resize: none;">${item.intro}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <input id="submit" type="button" value="保存" class="btn btn-default form-control">
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
