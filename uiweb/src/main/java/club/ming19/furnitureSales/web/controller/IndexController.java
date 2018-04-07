package club.ming19.furnitureSales.web.controller;


import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.service.IGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class IndexController {
    @Autowired
    private IGoodsService goodsService;

    @RequestMapping("/index")
    public String toIndex(HttpServletRequest request) {
        //精品推荐
        List<Goods> recommend = goodsService.listGoodsBySaleCount();
        request.setAttribute("recommend", recommend);
        //新品销售
        List<Goods> newGoods = goodsService.listGoodsByAddTime();
        request.setAttribute("newGoods", newGoods);
        return "index";
    }
}
