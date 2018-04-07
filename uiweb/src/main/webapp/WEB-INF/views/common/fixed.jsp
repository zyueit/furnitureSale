<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #server {
        background: url('${pageContext.request.contextPath}/img/fixed.png') 0 -439px;
        width: 72px;
        height: 79px;
    }

    #cat {
        background: url('${pageContext.request.contextPath}/img/fixed.png') 0 -806px;
        width: 72px;
        height: 71px;
    }

    #toTop {
        background: url('${pageContext.request.contextPath}/img/fixed.png') 0 -950px;
        width: 72px;
        height: 71px;
    }

    #server:hover {
        background: url('${pageContext.request.contextPath}/img/fixed.png') 0 -360px;
    }

    #cat:hover {
        background: url('${pageContext.request.contextPath}/img/fixed.png') 0 -144px;
    }

    #toTop:hover {
        background: url('${pageContext.request.contextPath}/img/fixed.png') 0 -878px;
    }
</style>
<script>
    $(function () {
        $(window).scroll(function () {
            if ($(window).scrollTop() > 500) {
                $("#toTop,#cat").show();
            } else {
                $("#toTop,#cat").hide();
            }
        });

        var index;
        $("#server,#cat,#toTop").hover(function () {
            index = layer.tips($(this).data('title'), this, {tips: 4});
        }, function () {
            layer.close(index);
        });

        $("#toTop").click(function () {
            scrollTo(0, 0);
        });
    });
</script>
<div style="position: fixed;top: 500px;right: 30px;">
    <div id="server" data-title="客服：185-0704-0205"></div>
    <div id="cat" hidden data-title="查看购物车" onclick="window.open('user/shopCat')"></div>
    <div id="toTop" hidden data-title="回到顶部"></div>
</div>