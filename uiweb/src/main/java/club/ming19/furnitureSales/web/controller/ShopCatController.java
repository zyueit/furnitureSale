package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.domain.ShopCatItem;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.service.IGoodsService;
import club.ming19.furnitureSales.service.IShopCatService;
import club.ming19.furnitureSales.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/user")
public class ShopCatController {
    @Autowired
    private IShopCatService shopCatService;
    @Autowired
    private IGoodsService goodsService;

    @RequestMapping("/shopCat")
    public String toShopCat(HttpSession session) {
        List<ShopCatItem> items = (List<ShopCatItem>) session.getAttribute(UserContext.SHOPCAT_IN_SESSION);
        //查询每一条明细所指的商品
        for (ShopCatItem item : items) {
            item.setGoods(goodsService.getAllById(item.getGoods().getId()));
        }
        return "shopCat/list";
    }

    @RequestMapping("/addToShopCat")
    @ResponseBody
    public AjaxResult addToShopCat(HttpSession session, Long id, BigDecimal count) {
        List<ShopCatItem> items = (List<ShopCatItem>) session.getAttribute(UserContext.SHOPCAT_IN_SESSION);
        for (ShopCatItem item : items) {
            //如果购物车里有该明细，只加新增的数量
            if (id.equals(item.getGoods().getId())) {
                item.setNum(item.getNum().add(count));
                return new AjaxResult(true, "添加成功！");
            }
        }
        //购物车里没有改商品的明细，新增一条
        ShopCatItem item = new ShopCatItem();
        item.setNum(count);
        Goods goods = new Goods();
        goods.setId(id);
        item.setGoods(goods);
        items.add(item);
        //session.setAttribute(UserContext.SHOPCAT_IN_SESSION, items);
        return new AjaxResult(true, "添加成功！");
    }

    @RequestMapping("/updateNumOfItem")
    @ResponseBody
    public Boolean updateNumOfItem(HttpSession session, Long id, BigDecimal num) {
        List<ShopCatItem> items = (List<ShopCatItem>) session.getAttribute(UserContext.SHOPCAT_IN_SESSION);
        if (num.compareTo(BigDecimal.ZERO) == 0) {
            for (Iterator<ShopCatItem> iterator = items.iterator(); iterator.hasNext(); ) {
                ShopCatItem item = iterator.next();
                if (item.getId().equals(id)) {
                    iterator.remove();
                    break;
                }
            }
        } else {
            for (ShopCatItem item : items) {
                //如果购物车里有该明细，只加新增的数量
                if (id.equals(item.getId())) {
                    item.setNum(num);
                    break;
                }
            }
        }
        return true;
    }
}
