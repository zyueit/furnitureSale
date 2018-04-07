package club.ming19.furnitureSales.listener;

import club.ming19.furnitureSales.domain.LoginInfo;
import club.ming19.furnitureSales.domain.ShopCatItem;
import club.ming19.furnitureSales.service.IShopCatService;
import club.ming19.furnitureSales.util.SpringUtil;
import club.ming19.furnitureSales.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.List;

/**
 * 监听session销毁事件，将session中用户的购物车明细持久化到数据库
 */
public class MySessionListener implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent se) {
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();//session
        LoginInfo user = (LoginInfo) session.getAttribute(UserContext.USER_IN_SESSION);//当前session的user
        ApplicationContext context = SpringUtil.getContext();
        IShopCatService shopCatService = context.getBean(IShopCatService.class);//shopCatService
        try {
            shopCatService.deleteItems(user.getId());//删除之前用户购物车里的明细
            List<ShopCatItem> items = (List<ShopCatItem>) session.getAttribute(UserContext.SHOPCAT_IN_SESSION);
            for (ShopCatItem item : items) {
                shopCatService.saveShopCatItem(item, user.getId());//保存现有的
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
