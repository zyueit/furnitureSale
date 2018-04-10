package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.UserInfo;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.service.IUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class UserInfoController {
    @Autowired
    private IUserInfoService userInfoService;

    @RequestMapping("/listRealNameCheck")
    public String listRealNameCheck(HttpServletRequest request) {
        try {
            List<UserInfo> userInfos = userInfoService.listRealNameCheck();
            request.setAttribute("userInfos", userInfos);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "页面加载异常！请稍后再试或联系管理员...");
        }
        return "userInfo/list";
    }

    @RequestMapping("/showUserInfo")
    public String showUserInfo(HttpServletRequest request, Long id) {
        try {
            UserInfo userInfo = userInfoService.getUserInfo(id);
            request.setAttribute("userInfo", userInfo);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "页面加载异常！请稍后再试或联系管理员...");
        }
        return "userInfo/show";
    }

    @RequestMapping("/approveUserInfo")
    @ResponseBody
    public AjaxResult approveUserInfo(Long id, boolean bool) {
        AjaxResult ajax;
        try {
            int line;
            if (bool) {
                line = userInfoService.updateStateOfUserInfo(id, UserInfo.REAL);
            } else {
                line = userInfoService.updateStateOfUserInfo(id, UserInfo.AUDIT_FAILED);
            }
            if (line == 0) {
                ajax = new AjaxResult("操作失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "操作成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("操作异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }
}
