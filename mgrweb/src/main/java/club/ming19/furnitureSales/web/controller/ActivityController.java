package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.Activity;
import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.web.event.ActivityInsertEvent;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class ActivityController {
    @Autowired
    private IActivityService activityService;
    @Autowired
    private ApplicationContext context;

    @RequestMapping("/listActivities")
    public String listActivities(HttpServletRequest request) {
        try {
            List<Activity> list = activityService.listActivities();
            request.setAttribute("list", list);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "活动加载异常！请稍后再试或联系管理员...");
        }
        return "activity/list";
    }

    @RequestMapping("/editActivity")
    public String editActivity(HttpServletRequest request, Long id) {
        if (id != null) {
            try {
                Activity activity = activityService.getActivityById(id);
                request.setAttribute("activity", activity);
                //只有是即将开始的活动才能编辑，否者只能查看
                if (activity.getState() != Activity.COMING) {
                    return "activity/show";
                }
                StringBuilder ids = new StringBuilder();
                List<Goods> goods = activity.getGoods();
                for (int index = 0; index < goods.size(); index++) {
                    if (index == 0) {
                        ids.append(goods.get(index).getId());
                    } else {
                        ids.append(",").append(goods.get(index).getId());
                    }
                }
                request.setAttribute("ids", ids.toString());
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "活动查询异常！请稍后再试或联系管理员...");
            }
        }
        return "activity/input";
    }

    @RequestMapping("/saveActivity")
    @ResponseBody
    public AjaxResult saveActivity(Activity activity) {
        AjaxResult ajax;
        try {
            int line;
            if (activity.getId() == null) {
                activity.setState(Activity.COMING);
                activity.setEsState(false);
                line = activityService.saveActivity(activity);
                //------------新增活动，发布新增事件-------------
                context.publishEvent(new ActivityInsertEvent(activity.getId(), activity.getBeginTime(), activity.getEndTime()));
            } else {
                line = activityService.updateActivity(activity);
            }
            if (line == 0) {
                ajax = new AjaxResult("活动保存失败！请稍后再试或联系管理员...");
            } else {
                ajax = new AjaxResult(true, "活动保存成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("活动保存异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }

    @RequestMapping("/updateEstimate")
    @ResponseBody
    public AjaxResult updateEstimate(Long id, int estimate, String esIntro) {
        AjaxResult ajax;
        try {
            int line = activityService.updateEstimate(id, estimate, esIntro);
            if (line == 0) {
                ajax = new AjaxResult("活动评估保存失败！请稍后再试或联系管理员...");
            } else {
                ajax = new AjaxResult(true, "活动评估保存成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("活动评估保存异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }

    @RequestMapping("/updateActivityState")
    @ResponseBody
    public AjaxResult updateState(Long id, String esIntro) {
        AjaxResult ajax;
        try {
            int line = activityService.updateState(id, esIntro);
            if (line == 0) {
                ajax = new AjaxResult("活动撤销失败！请稍后再试或联系管理员...");
            } else {
                ajax = new AjaxResult(true, "活动撤销成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("活动撤销异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }
}
