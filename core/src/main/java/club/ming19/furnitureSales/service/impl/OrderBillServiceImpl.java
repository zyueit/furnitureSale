package club.ming19.furnitureSales.service.impl;

import club.ming19.furnitureSales.domain.OrderBill;
import club.ming19.furnitureSales.domain.OrderBillItem;
import club.ming19.furnitureSales.mapper.OrderBillMapper;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.OrderBillQueryObject;
import club.ming19.furnitureSales.service.IOrderBillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderBillServiceImpl implements IOrderBillService {
    @Autowired
    private OrderBillMapper orderBillMapper;

    @Override
    public int saveOrderBill(OrderBill bill) {
        int line = orderBillMapper.saveOrderBill(bill);
        if (line != 0) {
            //保存订单明细
            for (OrderBillItem billItem : bill.getItems()) {
                orderBillMapper.saveOrderBillItem(billItem, bill.getId());
            }
        }
        return line;
    }

    @Override
    public int updateStateToCancelBill(Long id, int state) {
        return orderBillMapper.updateStateToCancelBill(id, state);
    }

    @Override
    public Long getCountOfState(Long id, int state) {
        return orderBillMapper.getCountOfState(id, state);
    }

    @Override
    public PageResult<OrderBill> queryBillsByStateAndUid(OrderBillQueryObject qo) {
        int totalCount = orderBillMapper.queryBillsCountByStateAndUid(qo).intValue();
        if (totalCount == 0) {
            return PageResult.empty(qo.getPageSize());
        }
        List<OrderBill> rows = orderBillMapper.queryBillsByStateAndUid(qo);
        return new PageResult<>(rows, totalCount, qo.getCurrentPage(), qo.getPageSize());
    }
}
