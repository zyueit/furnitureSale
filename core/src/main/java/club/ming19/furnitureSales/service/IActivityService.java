package club.ming19.furnitureSales.service;

import club.ming19.furnitureSales.domain.Activity;

import java.util.List;

public interface IActivityService {
    List<Activity> listActivities();

    Activity getActivityById(Long id);

    int saveActivity(Activity activity);

    int updateActivity(Activity activity);

    int updateEstimate(Long id, int estimate, String esIntro);

    int updateState(Long id, String esIntro);

    int updateActivityStateByAsync(Long id, int state);
}
