package club.ming19.furnitureSales.service.impl;

import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.mapper.GoodsMapper;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.GoodsQueryObject;
import club.ming19.furnitureSales.service.IGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsServiceImpl implements IGoodsService {
    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public PageResult<Goods> listGoods(GoodsQueryObject qo) {
        int totalCount = goodsMapper.listGoodsCount(qo).intValue();
        if (totalCount == 0) {
            return PageResult.empty(qo.getPageSize());
        }
        List<Goods> rows = goodsMapper.listGoods(qo);
        return new PageResult<>(rows, totalCount, qo.getCurrentPage(), qo.getPageSize());
    }

    @Override
    public Goods getGoodsById(Long id) {
        return goodsMapper.getGoodsById(id);
    }

    @Override
    public int saveGoods(Goods goods) {
        return goodsMapper.saveGoods(goods);
    }

    @Override
    public int addStockCount(Long id, int stock) {
        return goodsMapper.addStockCount(id, stock);
    }

    @Override
    public int updateState(Long id, boolean state) {
        return goodsMapper.updateState(id, state);
    }

    @Override
    public int updateImgs(Long id, String imgs) {
        return goodsMapper.updateImgs(id, imgs);
    }

    @Override
    public PageResult<Goods> listForActivity(GoodsQueryObject qo) {
        int totalCount = goodsMapper.listForActivityCount(qo).intValue();
        if (totalCount == 0) {
            return PageResult.empty(qo.getPageSize());
        }
        List<Goods> rows = goodsMapper.listForActivity(qo);
        return new PageResult<>(rows, totalCount, qo.getCurrentPage(), qo.getPageSize());
    }

    @Override
    public Goods getByIdForActivity(Long id) {
        return goodsMapper.getByIdForActivity(id);
    }

    @Override
    public List<Goods> listGoodsBySaleCount() {
        return goodsMapper.listGoodsBySaleCount();
    }

    @Override
    public List<Goods> listGoodsByAddTime() {
        return goodsMapper.listGoodsByAddTime();
    }

    @Override
    public PageResult<Goods> queryByCondition(GoodsQueryObject qo) {
        int totalCount = goodsMapper.queryCountByCondition(qo).intValue();
        if (totalCount == 0) {
            return PageResult.empty(qo.getPageSize());
        }
        List<Goods> rows = goodsMapper.queryByCondition(qo);
        return new PageResult<>(rows, totalCount, qo.getCurrentPage(), qo.getPageSize());
    }

    @Override
    public Goods getAllById(Long id) {
        return goodsMapper.getAllById(id);
    }
}
