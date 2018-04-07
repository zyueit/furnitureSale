package club.ming19.furnitureSales.web.interceptor;

import club.ming19.furnitureSales.domain.LoginInfo;
import club.ming19.furnitureSales.service.ILoginInfoService;
import club.ming19.furnitureSales.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private ILoginInfoService loginInfoService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (handler instanceof HandlerMethod) {
            String basePath = request.getContextPath();
            HttpSession session = request.getSession();
            //是否登陆了
            LoginInfo user = (LoginInfo) session.getAttribute(UserContext.USER_IN_SESSION);
            if (user == null) {//没有登陆
                response.sendRedirect(basePath + "/login.jsp");
                return false;
            }
            //到这里，登陆了，判断是否有同时异地登陆
            String loginId = (String) session.getAttribute(UserContext.LOGIN_ID_IN_SESSION);
            String login_id = loginInfoService.getLoginIdById(user.getId());
            if (!loginId.equals(login_id)) {//在别的地方登陆了
                session.invalidate();
                response.sendRedirect(basePath + "/forcedOffline.jsp");
                return false;
            }
            //到这里，当前用户只在当前位置登陆了，放行
        }
        return true;
    }
}
