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
    <title>数据字典管理</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/views/systemDictionary/list.js"></script>

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
<%-- 是数据字典目录还是字典明细 --%>
<c:if test="${cmd == 0}" scope="page" var="parent"/>
<c:if test="${cmd == 1}" scope="page" var="child"/>
<%-- 页面主体 --%>
<div class="panel panel-default">
    <div class="panel-heading">
        <c:if test="${parent}">
            <center>数据字典目录</center>
        </c:if>
        <c:if test="${child}">
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
            <a href="${pageContext.request.contextPath}/editSystemDictionaryItem?pid=${param.id}"
               class="btn btn-default pull-right btn-xs" data-toggle="tooltip" data-placement="bottom" title="新增明细">
                <span class="glyphicon glyphicon-plus"></span>
            </a>
            <center>数据字典明细</center>
        </c:if>
    </div>
    <div class="panel-body" style="min-height: 400px;">
        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center">
                <tr class="active">
                    <td>#</td>
                    <c:if test="${parent}">
                        <td>目录编码</td>
                    </c:if>
                    <td>
                        <c:if test="${parent}">
                            目录
                        </c:if>
                        <c:if test="${child}">
                            字典明细
                        </c:if>
                        名称
                    </td>
                    <td>简要说明</td>
                    <td>操作</td>
                </tr>
                <c:if test="${requestScope.list.size() == 0}">
                    <tr>
                        <td colspan="4"><span class="text-danger text-center">好像没有你想要的信息！0.0</span></td>
                    </tr>
                </c:if>
                <c:forEach items="${requestScope.list}" var="item" varStatus="tr">
                    <tr>
                        <td>${tr.count}</td>
                        <c:if test="${parent}">
                            <td>${item.sn}</td>
                        </c:if>
                        <td>${item.name}</td>
                        <td width="60%">${item.intro}</td>
                        <c:if test="${parent}">
                            <td>
                                <a href="${pageContext.request.contextPath}/querySystemDictionaryItemsByPid?id=${item.id}"
                                   data-toggle="tooltip" data-placement="bottom" title="查看字典明细">
                                    <span class="glyphicon glyphicon-eye-open"></span>
                                </a>
                            </td>
                        </c:if>
                        <c:if test="${child}">
                            <td>
                                <a href="${pageContext.request.contextPath}/editSystemDictionaryItem?pid=${param.id}&id=${item.id}"
                                   data-toggle="tooltip" data-placement="bottom" title="编辑明细">
                                    <span class="glyphicon glyphicon-edit"></span>
                                </a>
                                -
                                <a href="javascript:deleteItem(${item.id})"
                                   data-toggle="tooltip" data-placement="bottom" title="删除明细">
                                    <span class="glyphicon glyphicon-remove"></span>
                                </a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>
