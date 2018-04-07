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
    <title>编辑商品</title>
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

    <script src="${pageContext.request.contextPath}/js/views/goods/input.js"></script>

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
        <button id="submitGoods" type="button" class="btn btn-default btn-xs pull-right" data-toggle="tooltip"
                data-placement="bottom" title="保存编辑">
            <span class="glyphicon glyphicon-floppy-save"></span>
        </button>
        <center>新增商品</center>
    </div>
    <div class="panel-body" style="min-height: 300px;">
        <div style="width: 90%;margin-left: 5%;">
            <form id="goodsForm">
                <input name="imgs" type="hidden">
                <div class="form-group row">
                    <div class="col-sm-8">
                        <div class="input-group">
                            <span class="input-group-addon">商品名称(标题)</span>
                            <input type="text" name="name" class="form-control"
                                   placeholder="尽量描述家具">
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <span class="input-group-addon">商品编码</span>
                            <input type="text" name="sn" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-3">
                        <div class="input-group">
                            <span class="input-group-addon">产地</span>
                            <select name="place" class="form-control">
                                <option value="无">请选择</option>
                                <c:forEach items="${places}" var="place">
                                    <option>${place.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="input-group">
                            <span class="input-group-addon">尺寸</span>
                            <input type="text" name="size" class="form-control"
                                   placeholder="长*宽*高">
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="input-group">
                            <span class="input-group-addon">包含件数</span>
                            <input type="text" name="num" class="form-control" placeholder="如：2">
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="input-group">
                            <span class="input-group-addon">库存数量</span>
                            <input type="text" name="stockCount" class="form-control"
                                   placeholder="如：200">
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-3">
                        <div class="input-group">
                            <span class="input-group-addon">材料</span>
                            <select name="material" class="form-control">
                                <option value="无">请选择</option>
                                <c:forEach items="${materials}" var="material">
                                    <option>${material.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="input-group">
                            <span class="input-group-addon">风格</span>
                            <select name="style" class="form-control">
                                <option value="无">请选择</option>
                                <c:forEach items="${styles}" var="style">
                                    <option>${style.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="input-group">
                            <span class="input-group-addon">摆放房间</span>
                            <select name="room.id" class="form-control">
                                <option value="">请选择</option>
                                <c:forEach items="${rooms}" var="room">
                                    <option value="${room.id}">${room.name}</option>
                                </c:forEach>
                            </select>
                            <span class="input-group-addon">分类</span>
                            <select name="type" class="form-control">
                                <option value="无">请先选择房间分类</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-3">
                        <div class="input-group">
                        <span class="input-group-addon">
                            成本价
                            <span class="glyphicon glyphicon-yen"></span>
                        </span>
                            <input type="text" name="costPrice" class="form-control"
                                   placeholder="如：100.00">
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="input-group">
                        <span class="input-group-addon">
                            销售价
                            <span class="glyphicon glyphicon-yen"></span>
                        </span>
                            <input type="text" name="salePrice" class="form-control"
                                   placeholder="如：100.00">
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                        <span class="input-group-addon">
                            优惠价
                            <span class="glyphicon glyphicon-yen"></span>
                        </span>
                            <input type="text" name="discountPrice" class="form-control"
                                   placeholder="不优惠就算了￣へ￣">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">介绍(设计理念)</span>
                        <textarea class="form-control" name="intro"
                                  style="height: 150px;width: 700px;resize: none;"></textarea>
                    </div>
                </div>
            </form>
            <div style="position: relative;">
                <p style="color: rgb(0,0,0,.3);position: absolute;top: -10px;left: 48%;">商品图片</p>
                <HR width="80%" SIZE=5>
            </div>
            <input type="file" class="file-uploading" name="pic" id="goodsImg" multiple>
            <p class="text-center" style="color: rgb(0,0,0,.3)">支持上传jpg, png, gif后缀的图片，单张图片限制最大5M,最多同时上传3张图片</p>
        </div>
    </div>
</div>
</body>
</html>
