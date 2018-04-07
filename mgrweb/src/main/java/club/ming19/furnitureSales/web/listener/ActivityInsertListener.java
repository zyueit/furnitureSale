package club.ming19.furnitureSales.web.listener;

import club.ming19.furnitureSales.domain.Activity;
import club.ming19.furnitureSales.web.event.ActivityInsertEvent;
import club.ming19.furnitureSales.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class ActivityInsertListener implements ApplicationListener<ActivityInsertEvent> {
    @Autowired
    private IActivityService activityService;

    @Async
    public void onApplicationEvent(ActivityInsertEvent event) {
        System.out.println("新增活动监听器......");
        try {
            long time = event.getBeginTime().getTime() - new Date().getTime();//计算距离活动开始时间的毫秒数
            if (time > 0) {
                Thread.sleep(time);
            }
            System.out.println(event.getId() + "活动开始......");
            activityService.updateActivityStateByAsync(event.getId(), Activity.MOTION);//活动开始
            //---------------------------------------
            time = event.getEndTime().getTime() - new Date().getTime();//计算距离活动结束时间的毫秒数
            if (time > 0) {
                Thread.sleep(time);
            }
            System.out.println(event.getId() + "活动结束......");
            activityService.updateActivityStateByAsync(event.getId(), Activity.END);//活动结束
        } catch (InterruptedException e) {
            e.printStackTrace();
            System.out.println(event.getId() + "系统异常......");//请注意活动状态
        }
    }
}
