package club.ming19.furnitureSales.web.event;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

import java.util.Date;

/**
 * 新增活动事件
 */
@Getter
public class OrderBillInsertEvent extends ApplicationEvent {
    private Long id;//订单主键
    private Date createTime;//订单创建时间

    public OrderBillInsertEvent(Long id, Date createTime) {
        super(id);
        this.id = id;
        this.createTime = createTime;
    }
}
