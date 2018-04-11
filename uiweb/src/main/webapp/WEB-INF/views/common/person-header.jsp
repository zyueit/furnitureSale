<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    a {
        color: #0f0f0f;
        text-decoration-line: none;
    }

    #nav a {
        color: #FFFFFF;
        text-decoration-line: none;
    }

    a:hover {
        color: orange;
        text-decoration-line: none;
    }
</style>

<script>
    $(function () {
        $($(".mycaret")[${cmd}]).show();
    });

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

<div style="padding: 10px 0;background-color: #eee;">
    <div class="container" style="padding: 0 8%;font-size: 12px;">
        <a href="${pageContext.request.contextPath}/index">家具网首页</a>&ensp;&ensp;
        <a href="${pageContext.request.contextPath}/user/shopCat">购物车</a>&ensp;&ensp;
        <div class="pull-right" style="font-size: 12px;">
            <span>亲爱的用户&ensp;<b>[ ${sessionScope[UserContext.USER_IN_SESSION].username} ]</b>&ensp;欢迎回来！</span>&ensp;&ensp;
            <a href="javascript:logout()" style="color: #419641;">安全退出</a>
        </div>
    </div>
</div>
<div style="padding-top: 10px;margin-bottom: 10px;" class="bg-primary">
    <div id="nav" class="container" style="padding: 0 8%;font-size: 12px;">
        <ul class="list-inline">
            <li style="margin-right: 50px;">
                <a href="${pageContext.request.contextPath}/user/indexOfUserInfo"><b
                        style="color: #FFFFFF;font-size: 20px;">我的个人中心</b></a>
            </li>
            <li style="margin-right: 50px;">
                <a href="${pageContext.request.contextPath}/user/indexOfUserInfo">首页</a>
                <div class="mycaret" style="position: absolute;top: 74px;" hidden>
                    <span class="glyphicon glyphicon-triangle-top"></span>
                </div>
            </li>
            <li style="margin-right: 50px;">
                <a href="${pageContext.request.contextPath}/user/personalUserInfo">个人资料</a>
                <div class="mycaret" style="position: absolute;top: 74px;" hidden>
                    <span class="glyphicon glyphicon-triangle-top"></span>
                </div>
            </li>
            <li style="margin-right: 50px;">
                <a href="${pageContext.request.contextPath}/user/toHistoryOfBill">已购买的商品</a>
                <div class="mycaret" style="position: absolute;top: 74px;" hidden>
                    <span class="glyphicon glyphicon-triangle-top"></span>
                </div>
            </li>
            <li style="margin-right: 50px;">
                <a href="${pageContext.request.contextPath}/user/addressOfShipping">收货地址</a>
                <div class="mycaret" style="position: absolute;top: 74px;" hidden>
                    <span class="glyphicon glyphicon-triangle-top"></span>
                </div>
            </li>
            <li style="margin-right: 50px;">
                <a href="${pageContext.request.contextPath}/user/shopCat">我的购物车</a>
                <div class="mycaret" style="position: absolute;top: 74px;" hidden>
                    <span class="glyphicon glyphicon-triangle-top"></span>
                </div>
            </li>
            <li style="margin-right: 50px;">
                <a href="javascript:">评价管理</a>
                <div class="mycaret" style="position: absolute;top: 74px;" hidden>
                    <span class="glyphicon glyphicon-triangle-top"></span>
                </div>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/user/toResetPassword">修改密码</a>
                <div class="mycaret" style="position: absolute;top: 74px;" hidden>
                    <span class="glyphicon glyphicon-triangle-top"></span>
                </div>
            </li>
        </ul>
    </div>
</div>
