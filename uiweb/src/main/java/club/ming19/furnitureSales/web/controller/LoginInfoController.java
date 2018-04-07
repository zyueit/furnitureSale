package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.LoginInfo;
import club.ming19.furnitureSales.domain.ShopCatItem;
import club.ming19.furnitureSales.domain.UserInfo;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.service.ILoginInfoService;
import club.ming19.furnitureSales.service.IShopCatService;
import club.ming19.furnitureSales.service.IUserInfoService;
import club.ming19.furnitureSales.util.MD5;
import club.ming19.furnitureSales.util.SmsUtil;
import club.ming19.furnitureSales.util.UserContext;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class LoginInfoController {
    @Autowired
    private ILoginInfoService loginInfoService;
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IShopCatService shopCatService;

    @RequestMapping("/checkUserExist")
    @ResponseBody
    public Boolean checkUserExist(String info) {//检验用户名或手机号码
        Long line = userInfoService.checkUserExist(info);
        return line == 0;
    }

    @RequestMapping("/getCheckCode")
    @ResponseBody
    public AjaxResult getCheckCode(String phone) {
        AjaxResult ajax;
        try {
            //发送验证码，返回响应json字符串
            String json = SmsUtil.sendCode(phone);
            //获得回执状态码
            int statusCode = (int) new ObjectMapper().readValue(json, Map.class).get("code");
            if (statusCode == 200) {
                ajax = new AjaxResult(true, "验证码发送成功！");
            } else {
                ajax = new AjaxResult("验证码发送失败！请稍后再试...");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("验证码发送异常！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/doCheckCode")
    @ResponseBody
    public AjaxResult doCheckCode(String phone, String code) {
        AjaxResult ajax;
        try {
            //校验验证码，返回响应json字符串
            String json = SmsUtil.checkCode(phone, code);
            //获得回执状态码
            int statusCode = (int) new ObjectMapper().readValue(json, Map.class).get("code");
            if (statusCode == 200) {
                ajax = new AjaxResult(true, "验证码校验成功！");
            } else {
                ajax = new AjaxResult("校验失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("验证码校验异常！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/register")
    @ResponseBody
    public AjaxResult register(LoginInfo loginInfo, String phone) {
        AjaxResult ajax;
        try {
            loginInfo.setUserType(LoginInfo.USER_CLIENT);
            loginInfo.setPassword(MD5.encode(loginInfo.getPassword()));//密码加密
            int line = loginInfoService.saveLoginInfo(loginInfo);

            UserInfo userInfo = new UserInfo();
            userInfo.setId(loginInfo.getId());//主键 外键关联登陆信息
            userInfo.setPhone(phone);
            userInfoService.saveUserInfo(userInfo);
            if (line == 0) {
                ajax = new AjaxResult("注册失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "注册成功！赶快去登陆吧...");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("注册异常！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/loginCheck")
    @ResponseBody
    public AjaxResult loginCheck(HttpSession session, String username, String password) {
        AjaxResult ajax;
        try {
            LoginInfo user = loginInfoService.getForLoginCheck(username, MD5.encode(password), LoginInfo.USER_CLIENT);
            if (user == null) {//账号或密码错误
                ajax = new AjaxResult("用户名或密码错误！请重新输入...");
            } else {//登录成功
                session.setAttribute(UserContext.USER_IN_SESSION, user);
                //控制用户只能在一个地方登陆
                String login_id = UUID.randomUUID().toString();
                session.setAttribute(UserContext.LOGIN_ID_IN_SESSION, login_id);
                //保存登陆的时间和本次登陆的唯一标识
                loginInfoService.updateLoginTimeAndIdById(new Date(), login_id, user.getId());
                //查询用户购物车里的明细
                List<ShopCatItem> items = shopCatService.listShopCatItem(user.getId());
                session.setAttribute(UserContext.SHOPCAT_IN_SESSION, items);
                ajax = new AjaxResult(true, "登录成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("系统繁忙！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/logout")
    @ResponseBody
    public AjaxResult logout(HttpSession session) {
        session.invalidate();
        return new AjaxResult(true, "安全退出！");
    }
}
