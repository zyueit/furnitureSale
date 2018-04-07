package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.Activity;
import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.domain.SystemDictionary;
import club.ming19.furnitureSales.domain.SystemDictionaryItem;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.GoodsQueryObject;
import club.ming19.furnitureSales.service.IActivityService;
import club.ming19.furnitureSales.service.IGoodsService;
import club.ming19.furnitureSales.service.ISystemDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class GoodsController {
    @Autowired
    private IGoodsService goodsService;
    @Autowired
    private ISystemDictionaryService systemDictionaryService;
    @Autowired
    private IActivityService activityService;

    @RequestMapping("/queryByCondition")
    public String queryByCondition(HttpServletRequest request, GoodsQueryObject qo) {
        querySystemDictionary(request);

        qo.setPageSize(15);//显示15条

        if (qo.getRoomId() != null) {
            List<SystemDictionaryItem> type = systemDictionaryService.querySystemDictionaryItemsByPid(qo.getRoomId());
            request.setAttribute("type", type);
        }
        //新品销售
        List<Goods> newGoods = goodsService.listGoodsByAddTime();
        request.setAttribute("newGoods", newGoods);

        PageResult<Goods> pageResult = goodsService.queryByCondition(qo);
        request.setAttribute("pageResult", pageResult);
        return "querylist";
    }

    private void querySystemDictionary(HttpServletRequest request) {
        List<SystemDictionaryItem> style = systemDictionaryService.querySystemDictionaryItemsByPsn("style");
        request.setAttribute("style", style);
        List<SystemDictionaryItem> material = systemDictionaryService.querySystemDictionaryItemsByPsn("material");
        request.setAttribute("material", material);
        List<SystemDictionary> room = systemDictionaryService.querySystemDictionariesByPsn("room");
        request.setAttribute("room", room);
    }


    @RequestMapping("/getBysn")
    @ResponseBody
    public SystemDictionary getBysn(String sn) {
        return systemDictionaryService.getBysn(sn);
    }

    @RequestMapping("/getAllById")
    public String getGoodsByid(HttpServletRequest request, Long id) {
        List<Goods> recommend = goodsService.listGoodsBySaleCount();
        request.setAttribute("recommend", recommend);

        Goods goods = goodsService.getAllById(id);
        if (goods == null) {
            request.setAttribute("msg", "没有该商品！");
        }
        request.setAttribute("goods", goods);
        return "show";
    }

    @RequestMapping("/getActivityOfGoodsByAid")
    @ResponseBody
    public Activity getActivityOfGoodsByAid(Long id) {
        return activityService.getActivityById(id);
    }
}
