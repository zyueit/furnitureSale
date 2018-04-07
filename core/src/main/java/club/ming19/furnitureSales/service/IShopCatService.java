package club.ming19.furnitureSales.service;

import club.ming19.furnitureSales.domain.ShopCatItem;

import java.util.List;

public interface IShopCatService {
    List<ShopCatItem> listShopCatItem(Long id);

    int deleteItems(Long id);

    int saveShopCatItem(ShopCatItem item, Long id);
}
