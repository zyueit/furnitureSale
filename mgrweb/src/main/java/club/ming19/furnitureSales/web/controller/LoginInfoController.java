package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.LoginInfo;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.LoginInfoQueryObject;
import club.ming19.furnitureSales.service.ILoginInfoService;
import club.ming19.furnitureSales.util.MD5;
import club.ming19.furnitureSales.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
public class LoginInfoController {
    @Autowired
    private ILoginInfoService loginInfoService;

    @RequestMapping("/login")
    @ResponseBody
    public AjaxResult loginCheck(HttpSession session, String username, String password) {
        AjaxResult ajax;
        try {
            LoginInfo user = loginInfoService.getForLoginCheck(username, MD5.encode(password), LoginInfo.USER_MANAGER);
            if (user == null) {
                ajax = new AjaxResult("用户名或密码错误！请重新输入...");
            } else {
                session.setAttribute(UserContext.USER_IN_SESSION, user);
                //控制用户只能在一个地方登陆
                String login_id = UUID.randomUUID().toString();
                session.setAttribute(UserContext.LOGIN_ID_IN_SESSION, login_id);
                //保存登陆的时间和本次登陆的唯一标识
                loginInfoService.updateLoginTimeAndIdById(new Date(), login_id, user.getId());
                ajax = new AjaxResult(true, "登陆成功！正在跳转...");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("系统繁忙！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login.jsp";
    }

    @RequestMapping("/main")
    public String toIndex() {
        return "main";
    }

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
