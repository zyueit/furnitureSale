package club.ming19.furnitureSales.service.impl;

import club.ming19.furnitureSales.domain.Activity;
import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.mapper.ActivityMapper;
import club.ming19.furnitureSales.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements IActivityService {
    @Autowired
    private ActivityMapper activityMapper;

    @Override
    public List<Activity> listActivities() {
        return activityMapper.listActivities();
    }

    @Override
    public Activity getActivityById(Long id) {
        return activityMapper.getActivityById(id);
    }

    @Override
    public int saveActivity(Activity activity) {
        int line = activityMapper.saveActivity(activity);
        for (Goods g : activity.getGoods()) {
            activityMapper.saveRelation(activity.getId(), g.getId());
        }
        return line;
    }

    @Override
    public int updateActivity(Activity activity) {
        int line = activityMapper.updateActivity(activity);

        activityMapper.delOldRelation(activity.getId());

        for (Goods g : activity.getGoods()) {
            activityMapper.saveRelation(activity.getId(), g.getId());
        }
        return line;
    }

    @Override
    public int updateEstimate(Long id, int estimate, String esIntro) {
        return activityMapper.updateEstimate(id, estimate, esIntro);
    }

    @Override
    public int updateState(Long id, String esIntro) {
        return activityMapper.updateState(id, esIntro);
    }

    @Override
    public int updateActivityStateByAsync(Long id, int state) {
        return activityMapper.updateActivityStateByAsync(id, state);
    }
}
