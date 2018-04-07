package club.ming19.furnitureSales.web.event;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

import java.util.Date;

/**
 * 新增活动事件
 */
@Getter
public class ActivityInsertEvent extends ApplicationEvent {
    private Long id;//活动主键
    private Date beginTime;//活动开始时间
    private Date endTime;//活动结束时间

    public ActivityInsertEvent(Long id, Date beginTime, Date endTime) {
        super(id);
        this.id = id;
        this.beginTime = beginTime;
        this.endTime = endTime;
    }
}
