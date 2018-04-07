package club.ming19.furnitureSales.mapper;

import club.ming19.furnitureSales.domain.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ActivityMapper {
    List<Activity> listActivities();

    int saveActivity(Activity activity);

    void saveRelation(@Param("aid") Long aid, @Param("gid") Long gid);

    Activity getActivityById(Long id);

    int updateActivity(Activity activity);

    void delOldRelation(Long id);

    int updateEstimate(@Param("id") Long id, @Param("estimate") int estimate, @Param("esIntro") String esIntro);

    int updateState(@Param("id") Long id, @Param("esIntro") String esIntro);

    int updateActivityStateByAsync(@Param("id") Long id, @Param("state") int state);
}
