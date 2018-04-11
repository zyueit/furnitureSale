package club.ming19.furnitureSales.mapper;

import club.ming19.furnitureSales.domain.OrderBill;
import club.ming19.furnitureSales.domain.OrderBillItem;
import club.ming19.furnitureSales.query.OrderBillQueryObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderBillMapper {
    int saveOrderBill(OrderBill bill);

    int saveOrderBillItem(@Param("item") OrderBillItem billItem, @Param("bill_id") Long billId);

    int updateStateToCancelBill(@Param("id") Long id, @Param("state") int state);

    Long getCountOfState(@Param("id") Long id, @Param("state") int state);

    Long queryBillsCountByStateAndUid(OrderBillQueryObject qo);

    List<OrderBill> queryBillsByStateAndUid(OrderBillQueryObject qo);
}
