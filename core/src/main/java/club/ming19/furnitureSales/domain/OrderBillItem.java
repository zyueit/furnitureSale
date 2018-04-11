package club.ming19.furnitureSales.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.math.BigDecimal;
import java.util.List;

/**
 * 订单明细
 */
@Setter
@Getter
@Alias("OrderBillItem")
public class OrderBillItem extends BaseDomain {
    private Goods goods;//商品
    private BigDecimal num;//购买数量
    private BigDecimal salePrice;//单价
    private BigDecimal amount;//小计

    private Evaluation evals;//用户评价
}
