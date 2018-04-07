package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.SystemDictionary;
import club.ming19.furnitureSales.domain.SystemDictionaryItem;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.service.ISystemDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class SystemDictionaryController {
    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequestMapping("/listSystemDictionary")
    public String listSystemDictionary(HttpServletRequest request) {
        //显示数据字典目录
        request.setAttribute("cmd", 0);
        try {
            List<SystemDictionary> list = systemDictionaryService.listSystemDictionary();
            request.setAttribute("list", list);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "加载异常！请稍后再试或联系管理员...");
        }
        return "systemDictionary/list";
    }

    @RequestMapping("/querySystemDictionaryItemsByPid")
    public String querySystemDictionaryItemsByPid(HttpServletRequest request, Long id) {
        //显示数据字典明细
        request.setAttribute("cmd", 1);
        try {
            List<SystemDictionaryItem> list = systemDictionaryService.querySystemDictionaryItemsByPid(id);
            request.setAttribute("list", list);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "查询字典明细异常！请稍后再试或联系管理员...");
        }
        return "systemDictionary/list";
    }

    @RequestMapping("/queryItemsByPidForGoods")
    @ResponseBody
    public List<SystemDictionaryItem> queryItemsByPidForGoods(Long id) {
        List<SystemDictionaryItem> list = null;
        try {
            list = systemDictionaryService.queryItemsByPidForGoods(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/editSystemDictionaryItem")
    public String editSystemDictionaryItems(HttpServletRequest request, Long id) {
        if (id != null) {
            try {
                SystemDictionaryItem item = systemDictionaryService.getSystemDictionaryItemById(id);
                request.setAttribute("item", item);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "查询字典明细异常！请稍后再试或联系管理员...");
            }
        }
        return "systemDictionary/input";
    }

    @RequestMapping("/saveSystemDictionaryItem")
    @ResponseBody
    public AjaxResult saveSystemDictionaryItem(SystemDictionaryItem item) {
        AjaxResult ajax;
        int line;
        try {
            if (item.getId() == null) {
                line = systemDictionaryService.saveSystemDictionaryItem(item);
            } else {
                line = systemDictionaryService.updateSystemDictionaryItemById(item);
            }
            if (line == 0) {
                ajax = new AjaxResult("保存失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "保存成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("保存异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }

    @RequestMapping("/deleteSystemDictionaryItemById")
    @ResponseBody
    public AjaxResult deleteSystemDictionaryItemById(Long id) {
        AjaxResult ajax;
        if (id == null) {
            return new AjaxResult("搞事情啊！");
        }
        try {
            int line = systemDictionaryService.deleteSystemDictionaryItemById(id);
            if (line == 0) {
                ajax = new AjaxResult("删除失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "删除成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("刪除异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }
}
