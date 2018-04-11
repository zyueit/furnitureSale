package club.ming19.furnitureSales.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 购物车里的明细
 */
@Setter
@Getter
@Alias("ShopCatItem")
public class ShopCatItem extends BaseDomain implements Serializable {
    private Goods goods;//哪一个商品
    private BigDecimal num;//数量
}
