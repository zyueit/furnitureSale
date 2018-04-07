<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #foot p {
        width: 50px;
        height: 50px;
        margin: 0 auto;
    }

    #foot center {
        margin: 5px auto;
        color: rgb(0, 0, 0, .3);
    }

    #footer a {
        color: #777777;
    }
</style>
<div class="container-fluid" style="background-color: rgb(0,0,0,.03);">
    <div id="foot" class="container">
        <div class="row" style="padding: 30px 8%;">
            <a href="javascript:" class="col-sm-2">
                <p style="background: url('${pageContext.request.contextPath}/img/site.png') 0 -350px;"></p>
                <center>100%正品</center>
            </a>
            <a href="javascript:" class="col-sm-2">
                <p style="background: url('${pageContext.request.contextPath}/img/site.png') 0 -300px;"></p>
                <center>双重质检</center>
            </a>
            <a href="javascript:" class="col-sm-2">
                <p style="background: url('${pageContext.request.contextPath}/img/site.png') 0 0;"></p>
                <center>无理由退货</center>
            </a>
            <a href="javascript:" class="col-sm-2">
                <p style="background: url('${pageContext.request.contextPath}/img/site.png') 0 -200px;"></p>
                <center>售后保障</center>
            </a>
            <a href="javascript:" class="col-sm-2">
                <p style="background: url('${pageContext.request.contextPath}/img/site.png') 0 -100px;;"></p>
                <center>万千口碑</center>
            </a>
            <a href="javascript:" class="col-sm-2">
                <p style="background: url('${pageContext.request.contextPath}/img/site.png') 0 -150px;"></p>
                <center>贵了就赔</center>
            </a>
        </div>
    </div>
    <div style="background-color:rgb(0,0,0,.88);margin: 0 -15px;padding: 20px 0;">
        <div id="footer" class="container" style="padding: 0 7%;color: #777777;font-size: 12px;">
            <div class="col-sm-8">
                <a href="javascript:">隐私政策</a>
                <a href="javascript:">使用条款</a>
                <a href="javascript:">关于我们</a>
                <a href="javascript:">友情链接</a>
                <a href="javascript:">更多&raquo;</a>
                <p> © 2005-2016 MingMini 版权所有，并保留所有权利。ICP备案证书号：鄂ICP备05006830号 </p>
            </div>
            <div class="col-sm-4" style="height: 60px;column-count: 3;padding-top: 5px;">
                <a href="javascript:">
                    <p style="background: url('${pageContext.request.contextPath}/img/footer.png') 0 0;width: 27px;height: 22px;display: inline-block;"></p>
                    <p style="display: inline-block;position: relative;top: -16px;">示范企业</p>
                </a>
                <a href="javascript:">
                    <p style="background: url('${pageContext.request.contextPath}/img/footer.png') 0 -44px;width: 27px;height: 22px;display: inline-block;"></p>
                    <p style="display: inline-block;position: relative;top: -16px;">信用评价</p>
                </a>
                <a href="javascript:">
                    <p style="background: url('${pageContext.request.contextPath}/img/footer.png') 0 -22px;width: 27px;height: 22px;display: inline-block;"></p>
                    <p style="display: inline-block;position: relative;top: -16px;">备案信息</p>
                </a>
            </div>
        </div>
    </div>
</div>