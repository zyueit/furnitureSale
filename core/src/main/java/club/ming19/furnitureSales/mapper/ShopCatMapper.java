package club.ming19.furnitureSales.mapper;

import club.ming19.furnitureSales.domain.ShopCatItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShopCatMapper {
    List<ShopCatItem> listShopCatItem(Long id);

    int deleteItems(Long id);

    int saveShopCatItem(@Param("item") ShopCatItem item, @Param("id") Long id);
}
