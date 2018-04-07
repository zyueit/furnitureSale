package club.ming19.furnitureSales.service.impl;

import club.ming19.furnitureSales.domain.ShopCatItem;
import club.ming19.furnitureSales.mapper.ShopCatMapper;
import club.ming19.furnitureSales.service.IShopCatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShopCatServiceImpl implements IShopCatService {
    @Autowired
    private ShopCatMapper shopCatMapper;

    @Override
    public List<ShopCatItem> listShopCatItem(Long id) {
        return shopCatMapper.listShopCatItem(id);
    }

    @Override
    public int deleteItems(Long id) {
        return shopCatMapper.deleteItems(id);
    }

    @Override
    public int saveShopCatItem(ShopCatItem item, Long id) {
        return shopCatMapper.saveShopCatItem(item, id);
    }
}
