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
    <title>查看商品信息</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/js/plugin/bootstrap-fileinput/css/fileinput.min.css">

    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap-fileinput/js/locales/zh.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/holder.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/views/goods/show.js"></script>

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
        <div class="pull-right">
            <c:if test="${goods.state == 0}">
                <a href="javascript:putaway(${goods.id})" class="btn btn-default btn-xs" data-toggle="tooltip"
                   data-placement="bottom" title="上架">
                    <span class="glyphicon glyphicon-arrow-up"></span>
                </a>
            </c:if>
            <c:if test="${goods.state == 1}">
                <a href="javascript:soldout(${goods.id})" class="btn btn-default btn-xs" data-toggle="tooltip"
                   data-placement="bottom" title="下架">
                    <span class="glyphicon glyphicon-arrow-down"></span>
                </a>
            </c:if>
            <a href="javascript:addStock(${goods.id})" class="btn btn-default btn-xs" data-toggle="tooltip"
               data-placement="bottom" title="增加库存">
                <span class="glyphicon glyphicon-plus"></span>
            </a>
        </div>
        <center>商品信息</center>
    </div>
    <div class="panel-body" style="min-height: 750px;">
        <div style="width: 85%;margin-left: 7.5%;">
            <form id="goodsForm">
                <div class="form-group row">
                    <div class="col-sm-7">
                        <span class="control-label">商品名称(标题):</span>
                        <p class="form-control-static">${goods.name}</p>
                    </div>
                    <div class="col-sm-3">
                        <span class="control-label">商品编码:</span>
                        <p class="form-control-static">${goods.sn}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">状态:</span>
                        <p class="form-control-static">
                            <c:if test="${goods.state == 0}">
                                <span class="text-danger">下架啦</span>
                            </c:if>
                            <c:if test="${goods.state == 1}">
                                <span class="text-success">在售中</span>
                            </c:if>
                        </p>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2">
                        <span class="control-label">产地:</span>
                        <p class="form-control-static">${goods.place}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">家具用料:</span>
                        <p class="form-control-static">${goods.material}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">风格:</span>
                        <p class="form-control-static">${goods.style}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">分类:</span>
                        <p class="form-control-static">${goods.type}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">尺寸:</span>
                        <p class="form-control-static">${goods.size}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">包含件数:</span>
                        <p class="form-control-static">${goods.num}</p>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2">
                        <span class="control-label">库存数量:</span>
                        <p class="form-control-static">${goods.stockCount}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">成本:</span>
                        <p class="form-control-static">${goods.costPrice}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">售价:</span>
                        <p class="form-control-static">${goods.salePrice}</p>
                    </div>
                    <div class="col-sm-2">
                        <span class="control-label">优惠价:</span>
                        <p class="form-control-static">${goods.discountPrice == null ? '无':goods.discountPrice}</p>
                    </div>
                </div>
                <div class="form-group">
                    <span class="control-label">介绍(设计理念):</span>
                    <p class="form-control-static">${goods.intro}</p>
                </div>
            </form>
            <div style="position: relative;">
                <p style="color: rgb(0,0,0,.3);position: absolute;top: -10px;left: 48%;">商品图片</p>
                <HR width="80%" SIZE=5>
            </div>
            <div class="form-group">
                <div class="row old">
                    <c:forEach items="${goods.imgs.split(',')}" var="img">
                        <img src="${img}" alt="goods-img" class="col-sm-4">
                    </c:forEach>
                </div>
                <div class="row new" hidden>
                    <input type="file" class="file-uploading" name="pic" id="goodsImg" multiple>
                    <p class="text-center" style="color: rgb(0,0,0,.3)">支持上传jpg, png,
                        gif后缀的图片，单张图片限制最大5M,最多上传3张图片</p>
                </div>
                <div class="new" hidden>
                    <div class="col-sm-6">
                        <input type="hidden" name="imgs" autocomplete="off">
                        <input type="button" class="btn btn-default form-control" value="确认更换"
                               onclick="changeImgs(${goods.id})">
                    </div>
                    <div class="col-sm-6">
                        <input type="button" class="btn btn-default form-control" value="取消" onclick="showOld()">
                    </div>
                </div>
            </div>
            <div class="form-group  old">
                <div class="container">
                    <input type="button" class="btn btn-default form-control" value="更换商品图片" onclick="hideOld()">
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>
