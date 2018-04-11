package club.ming19.furnitureSales.query;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class OrderBillQueryObject extends QueryObject {
    private Long id;//当前用户主键id
    private Integer state;//订单的状态
}
