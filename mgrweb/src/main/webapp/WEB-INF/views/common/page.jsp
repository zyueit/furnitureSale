<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="btn-group" style="width: 45%;">
    <a href="javascript:submitForm(1)" class="btn btn-default">首页</a>
    <a href="javascript:submitForm(${requestScope.pageResult.prevPage})" class="btn btn-default">上一页</a>
    <a class="btn btn-default disabled">当前${requestScope.pageResult.currentPage}页/总共${requestScope.pageResult.totalPage}页</a>
    <a href="javascript:submitForm(${requestScope.pageResult.nextPage})" class="btn btn-default">下一页</a>
    <a href="javascript:submitForm(${requestScope.pageResult.totalPage})" class="btn btn-default">尾页</a>
</div>
