package club.ming19.furnitureSales.mapper;

import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.query.GoodsQueryObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsMapper {
    Long listGoodsCount(GoodsQueryObject qo);

    List<Goods> listGoods(GoodsQueryObject qo);

    int saveGoods(Goods goods);

    Goods getGoodsById(Long id);

    int addStockCount(@Param("id") Long id, @Param("stock") int stock);

    int updateState(@Param("id") Long id, @Param("state") boolean state);

    int updateImgs(@Param("id") Long id, @Param("imgs") String imgs);

    List<Goods> listForActivity(GoodsQueryObject qo);

    Long listForActivityCount(GoodsQueryObject qo);

    Goods getByIdForActivity(Long id);

    List<Goods> listGoodsBySaleCount();

    List<Goods> listGoodsByAddTime();

    Long queryCountByCondition(GoodsQueryObject qo);

    List<Goods> queryByCondition(GoodsQueryObject qo);

    Goods getAllById(Long id);
}
