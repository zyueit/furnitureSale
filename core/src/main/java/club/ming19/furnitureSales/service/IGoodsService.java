package club.ming19.furnitureSales.service;

import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.GoodsQueryObject;

import java.util.List;

public interface IGoodsService {
    PageResult<Goods> listGoods(GoodsQueryObject qo);

    Goods getGoodsById(Long id);

    int saveGoods(Goods goods);

    int addStockCount(Long id, int stock);

    int updateState(Long id, boolean state);

    int updateImgs(Long id, String imgs);

    PageResult<Goods> listForActivity(GoodsQueryObject qo);

    Goods getByIdForActivity(Long id);

    List<Goods> listGoodsBySaleCount();

    List<Goods> listGoodsByAddTime();

    PageResult<Goods> queryByCondition(GoodsQueryObject qo);

    Goods getAllById(Long id);
}
