<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<style>
    body {
        font-family: '微软雅黑', cursive;
        font-size: 14px;
        margin: 0;
        padding: 0;
    }

    a:hover, a:link {
        text-decoration-line: none;
    }

    #header-top {
        height: 40px;
        background-color: #eee;
    }

    #header-top a:hover {
        text-decoration: none;
        color: red;
    }

    #header-md {
        height: 80px;
    }

    #header-nav {
        width: 100%;
        height: 32px;
    }

    #header-nav div div {
        width: 13%;
        display: inline-block;
    }

    #header-nav a {
        color: rgb(0, 0, 0, .6);
        padding-bottom: 10px;
    }

    #header-nav a:hover {
        padding-bottom: 10px;
        border-bottom: solid 2px rgb(0, 0, 0, .6);
    }
</style>

<script>
    $(function () {
        $("#index_search_btn").click(function () {
            $("#index_search_form").submit();
        });
    });

    function toQueryPage(sn) {
        $.ajax({
            type: 'get',
            data: {sn: sn},
            dataType: 'json',
            url: '${pageContext.request.contextPath}/getBysn',
            success: function (data) {
                if (data.id) {
                    window.location.href = '${pageContext.request.contextPath}/queryByCondition?roomId=' + data.id;
                }
            }
        });
    }

    function logout() {
        $.ajax({
            type: 'get',
            dataType: 'json',
            url: '${pageContext.request.contextPath}/logout',
            success: function (data) {
                if (data.success) {
                    window.location.reload();
                }
            }
        });
    }
</script>

<div id="header-top">
    <div class="container" style="padding: 0 7%;">
        <p class="pull-left text-info" style="padding-top: 8px;cursor: pointer;">新品销售，最低7折！</p>
        <p class="pull-right ${sessionScope[UserContext.USER_IN_SESSION] == null ? '' : 'hidden'}"
           style="font-size: 12px;padding-top: 9px;">
            <a href="${pageContext.request.contextPath}/login.jsp">你好，请登录</a>&ensp;&ensp;
            <a href="${pageContext.request.contextPath}/register.jsp" style="color: red;">免费注册&raquo;</a>
        </p>
        <p class="pull-right ${sessionScope[UserContext.USER_IN_SESSION] == null ? 'hidden' : ''}"
           style="font-size: 12px;padding-top: 9px;">
            <span>欢迎&ensp;<b>[ ${sessionScope[UserContext.USER_IN_SESSION].username} ]</b>&ensp;回来！</span>&ensp;&ensp;
            <a href="javascript:logout()" class="btn btn-default btn-xs">安全退出</a>
        </p>
    </div>
</div>
<div id="header-md">
    <div class="container" style="padding: 0 7%;">
        <div class="row" style="padding-top: 20px;">
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/index">
                    <img src="${pageContext.request.contextPath}/img/logo_sm.png" title="MingMini家具销售" alt="logo"
                         style="margin-left: -40px;">
                </a>
            </div>
            <div class="col-md-offset-1 col-md-5" style="padding: 10px;">
                <form id="index_search_form" action="${pageContext.request.contextPath}/queryByCondition" method="post">
                    <div class="form-group has-feedback">
                        <input type="text" name="keyword" value="${param.keyword}" class="form-control"
                               placeholder="关键词查询，如：家具的风格、摆放位置、用料等">
                        <span id="index_search_btn" class="glyphicon glyphicon-search form-control-feedback"
                              style="cursor: pointer;pointer-events: auto;"></span>
                    </div>
                </form>
            </div>
            <div class="col-md-offset-1 col-md-3">
                <div class="pull-right">
                    <a href="javascript:(window.open('user/shopCat'))()"
                       style="display: inline-block;padding: 10px;color: #B8B8B8;">&ensp;
                        <span class="glyphicon glyphicon-shopping-cart"></span><br>购物车
                    </a>
                    <a href="" style="display: inline-block;padding: 10px;color: #B8B8B8;">&ensp;&ensp;
                        <span class="glyphicon glyphicon-user"></span><br>个人中心
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<HR width="100%" SIZE=5 style="margin-bottom: 10px;">
<div id="header-nav">
    <div class="container" style="padding: 0 7%;">
        <div><a href="javascript:toQueryPage('livingroom')">客厅</a></div>
        <div><a href="javascript:toQueryPage('bedroom')">卧室</a></div>
        <div><a href="javascript:toQueryPage('kitchen')">餐厅</a></div>
        <div><a href="javascript:toQueryPage('boardroom')">办公</a></div>
        <div><a href="javascript:toQueryPage('entryway')">通道</a></div>
        <div style="border-right: dashed 1px #DDDDDD;"><a href="javascript:toQueryPage('courtyard')">庭院</a></div>
        <i class="pull-right" style="color: #D3D4D3;">MingMini家具销售网站</i>
    </div>
</div>