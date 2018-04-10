<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人资料-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/js/plugin/bootstrap-fileinput/css/fileinput.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap-fileinput/js/locales/zh.js"></script>

    <script src="${pageContext.request.contextPath}/js/views/userInfo/personalInfo.js"></script>
</head>

<style>
    dd {
        font-size: 12px;
    }
</style>

<script>
    if (${sessionScope[UserContext.USERINFO_IN_SESSION].state == -1}) {
        layer.open({
            title: '温馨提示',
            icon: 6,
            content: '上次提交的实名认证材料认证失败！请重新提交有效材料...'
        });
    }
</script>

<body>
<input type="hidden" id="basePath" value="${pageContext.request.contextPath}">

<%@ include file="/WEB-INF/views/common/person-header.jsp" %>
<div class="container" style="padding: 0 8%;">
    <div class="row" style="margin: 20px 0;">
        <div class="col-sm-3" style="padding: 0;">
            <div style="background-color: rgb(0,0,0,.1);padding-left: 10px;border: solid 1px rgb(0,0,0,.1);">
                <h5><b>新品发售</b>&ensp;
                    <small>快去抢购吧</small>
                </h5>
            </div>
            <div style="border: solid 1px rgb(0,0,0,.1);padding: 5px 10px;border-top: none;">
                <c:forEach items="${newGoods}" var="item" varStatus="num">
                    <c:if test="${num.count < 5}">
                        <a href="${pageContext.request.contextPath}/getAllById?id=${item.id}">
                            <img src="${item.imgs.split(',')[0]}" width="100%" height="150">
                            <div style="font-size: 12px;margin-bottom: 20px;background-color: rgb(0,0,0,.01);">
                                <div title="${item.name}"
                                     style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
                                        ${item.name}
                                </div>
                                <div class="text-center">
                                    <span style="color: red;padding: 0 20px;background-color: rgb(0,0,0,.01);border: solid 1px rgb(0,0,0,.03);">
                                <c:if test="${item.discountPrice != null}">
                                    ￥${item.discountPrice}
                                </c:if>
                                <c:if test="${item.discountPrice == null}">
                                    ￥${item.salePrice}
                                </c:if>
                                    </span>
                                </div>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="col-sm-9" style="padding: 10px 15px;">
            <div class="col-sm-12">
                <fieldset>
                    <legend style="font-size: 14px;padding-left: 10px;">用户基本信息</legend>
                    <dl class="dl-horizontal">
                        <dt>用户名称</dt>
                        <dd>${sessionScope[UserContext.USER_IN_SESSION].username}</dd>
                        <br>
                        <c:if test="${sessionScope[UserContext.USERINFO_IN_SESSION].state != 2}">
                            <dt>真是名字</dt>
                            <dd><span class="text-danger">未实名</span></dd>
                            <br>
                            <dt>性别</dt>
                            <dd><span class="text-danger">未知</span></dd>
                            <br>
                            <dt>证件号码</dt>
                            <dd><span class="text-danger">未实名</span></dd>
                            <br>
                            <dt>现住住址</dt>
                            <dd><span class="text-danger">未知</span></dd>
                        </c:if>
                        <c:if test="${sessionScope[UserContext.USERINFO_IN_SESSION].state == 2}">
                            <dt>真是名字</dt>
                            <dd>${sessionScope[UserContext.USERINFO_IN_SESSION].name}</dd>
                            <br>
                            <dt>性别</dt>
                            <dd>
                                <c:choose>
                                    <c:when test="${sessionScope[UserContext.USERINFO_IN_SESSION].sex == 0}">
                                        <span>女</span>
                                    </c:when>
                                    <c:when test="${sessionScope[UserContext.USERINFO_IN_SESSION].sex == 1}">
                                        <span>男</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>保密</span>
                                    </c:otherwise>
                                </c:choose></dd>
                            <br>
                            <dt>证件号码</dt>
                            <dd>${sessionScope[UserContext.USERINFO_IN_SESSION].IDcard}</dd>
                            <br>
                            <dt>现住住址</dt>
                            <dd>${sessionScope[UserContext.USERINFO_IN_SESSION].address}</dd>
                        </c:if>
                        <br>
                        <dt>手机号码</dt>
                        <dd>${sessionScope[UserContext.USERINFO_IN_SESSION].phone}</dd>
                    </dl>
                </fieldset>
            </div>
            <div class="col-sm-12">
                <fieldset>
                    <c:if test="${sessionScope[UserContext.USERINFO_IN_SESSION].state == 0 || sessionScope[UserContext.USERINFO_IN_SESSION].state == -1}">
                        <legend style="font-size: 14px;padding-left: 10px;padding-top: 20px;">实名认证&ensp;
                            <small class="label label-info">未实名</small>
                        </legend>
                        <div style="margin-left: 110px;">
                            <form id="userInfoForm">
                                <input type="hidden" name="imgs">
                                <input type="hidden" name="id"
                                       value="${sessionScope[UserContext.USERINFO_IN_SESSION].id}">
                                <div class="form-group row">
                                    <div class="col-sm-2">
                                        <label class="control-label">真实名字</label>
                                    </div>
                                    <div class="col-sm-4" style="padding-left: 0;">
                                        <input name="name" type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-2">
                                        <label class="control-label">性别</label>
                                    </div>
                                    <div class="col-sm-3" style="padding-left: 0;">
                                        <select name="sex" type="text" class="form-control">
                                            <option value="-1">请选择</option>
                                            <option value="0">女</option>
                                            <option value="1">男</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-2">
                                        <label class="control-label">身份证号</label>
                                    </div>
                                    <div class="col-sm-5" style="padding-left: 0;">
                                        <input name="IDcard" type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-2">
                                        <label class="control-label">现住地址</label>
                                    </div>
                                    <div class="col-sm-5" style="padding-left: 0;">
                                        <input name="address" type="text" class="form-control">
                                    </div>
                                </div>
                            </form>
                            <div class="form-group row">
                                <small>-------</small>
                                证件照片
                                <small>-------</small>
                            </div>
                            <div class="form-group row">
                                <input type="file" class="file-uploading" name="pic" id="ID_img" multiple>
                                <p class="text-center" style="color: rgb(0,0,0,.3);">
                                    请上传身份证正反两面的照片，支持后缀jpg, png, gif，单张照片限制5M
                                </p>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-offset-2">
                                    <input type="button" value="提交材料" class="btn btn-default" onclick="submitForm()">
                                    <input type="button" value="重置" class="btn btn-default" onclick="resetForm()">
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${sessionScope[UserContext.USERINFO_IN_SESSION].state == 1}">
                        <legend style="font-size: 14px;padding-left: 10px;padding-top: 20px;">实名认证&ensp;
                            <small class="label label-info">审核中</small>
                        </legend>
                        <dl class="dl-horizontal">
                            <dt>真是名字</dt>
                            <dd>${sessionScope[UserContext.USERINFO_IN_SESSION].name}</dd>
                            <br>
                            <dt>性别</dt>
                            <dd>
                                <c:choose>
                                    <c:when test="${sessionScope[UserContext.USERINFO_IN_SESSION].sex == 0}">
                                        <span>女</span>
                                    </c:when>
                                    <c:when test="${sessionScope[UserContext.USERINFO_IN_SESSION].sex == 1}">
                                        <span>男</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>保密</span>
                                    </c:otherwise>
                                </c:choose>
                            </dd>
                            <br>
                            <dt>证件号码</dt>
                            <dd>${sessionScope[UserContext.USERINFO_IN_SESSION].IDcard}</dd>
                            <br>
                            <dt>现住住址</dt>
                            <dd>${sessionScope[UserContext.USERINFO_IN_SESSION].address}</dd>
                            <br>
                            <dt>证件图片</dt>
                            <dd>
                                <img src="${sessionScope[UserContext.USERINFO_IN_SESSION].imgs.split(',')[0]}"
                                     width="40%" height="130">
                                <img src="${sessionScope[UserContext.USERINFO_IN_SESSION].imgs.split(',')[1]}"
                                     width="40%" height="130">
                            </dd>
                            <br>
                            <fmt:formatDate value="${sessionScope[UserContext.USERINFO_IN_SESSION].time}" var="time"
                                            scope="page" pattern="yyyy年MM月dd日 HH时mm分ss秒" timeZone="GMT+8"/>
                            <dt>提交时间</dt>
                            <dd>${time}</dd>
                        </dl>
                    </c:if>
                    <c:if test="${sessionScope[UserContext.USERINFO_IN_SESSION].state == 2}">
                        <legend style="font-size: 14px;padding-left: 10px;padding-top: 20px;">证件材料&ensp;
                            <small class="label label-info">已实名</small>
                        </legend>
                        <dl class="dl-horizontal">
                            <dt>证件图片</dt>
                            <dd>
                                <img src="${sessionScope[UserContext.USERINFO_IN_SESSION].imgs.split(',')[0]}"
                                     width="40%" height="130">
                                <img src="${sessionScope[UserContext.USERINFO_IN_SESSION].imgs.split(',')[1]}"
                                     width="40%" height="130">
                            </dd>
                            <br>
                            <fmt:formatDate value="${sessionScope[UserContext.USERINFO_IN_SESSION].time}" var="time"
                                            scope="page" pattern="yyyy年MM月dd日 HH时mm分ss秒" timeZone="GMT+8"/>
                            <dt>提交时间</dt>
                            <dd>${time}</dd>
                        </dl>
                    </c:if>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/fixed.jsp" %>
</body>
</html>