package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.LoginInfo;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.LoginInfoQueryObject;
import club.ming19.furnitureSales.service.ILoginInfoService;
import club.ming19.furnitureSales.util.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class LoginInfoMgController {
    @Autowired
    private ILoginInfoService loginInfoService;

    /* 用户登陆信息 */
    @RequestMapping("/getLoginInfo")
    public String MgUiLoginInfo(HttpServletRequest request, LoginInfoQueryObject qo) {
        int userType = qo.getUserType();
        if (userType != LoginInfo.USER_CLIENT && userType != LoginInfo.USER_MANAGER) {
            request.setAttribute("msg", "非法请求！你想干嘛？");
        }
        //请求的是前台还是后台
        request.setAttribute("cmd", userType);
        try {
            //查询用户登陆信息
            PageResult<LoginInfo> pageResult = loginInfoService.listLoginInfo(qo);
            request.setAttribute("pageResult", pageResult);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "加载异常！请稍后再试或联系管理员...");
        }
        return "loginInfo/list";
    }

    //后台用户密码重置
    @RequestMapping("/resetPassword")
    @ResponseBody
    public AjaxResult resetPassword(Long id) {
        AjaxResult ajax;
        if (id != null) {
            try {
                //密码重置为88888888
                int line = loginInfoService.resetPassword(id, MD5.encode(LoginInfo.MANAGER_PASSWORD));
                if (line == 0) {
                    ajax = new AjaxResult("密码重置失败！请稍后再试...");
                } else {
                    ajax = new AjaxResult(true, "密码重置成功！密码重置为:" + LoginInfo.MANAGER_PASSWORD);
                }
            } catch (Exception e) {
                e.printStackTrace();
                ajax = new AjaxResult("密码重置异常！请稍后再试或联系管理员...");
            }
        } else {
            ajax = new AjaxResult("找打？");
        }
        return ajax;
    }
}
