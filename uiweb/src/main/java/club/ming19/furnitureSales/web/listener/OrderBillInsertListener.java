package club.ming19.furnitureSales.web.listener;

import club.ming19.furnitureSales.domain.OrderBill;
import club.ming19.furnitureSales.service.IOrderBillService;
import club.ming19.furnitureSales.web.event.OrderBillInsertEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class OrderBillInsertListener implements ApplicationListener<OrderBillInsertEvent> {
    @Autowired
    private IOrderBillService orderBillService;

    @Async
    @Override
    public void onApplicationEvent(OrderBillInsertEvent event) {
        System.out.println("新增订单监听器......");
        try {
            Thread.sleep(60 * 1000);//测试一分钟
            //Thread.sleep(60 * 60 * 1000);//一小时
            System.out.println(event.getId() + "订单取消......");
            orderBillService.updateStateToCancelBill(event.getId(), OrderBill.CANCEL_BILL);//取消订单
        } catch (InterruptedException e) {
            e.printStackTrace();
            System.out.println(event.getId() + "系统异常......");//请注意订单状态
        }
    }
}
