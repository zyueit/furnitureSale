package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.Goods;
import club.ming19.furnitureSales.domain.SystemDictionary;
import club.ming19.furnitureSales.domain.SystemDictionaryItem;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.GoodsQueryObject;
import club.ming19.furnitureSales.service.IGoodsService;
import club.ming19.furnitureSales.page.FileUploadResult;
import club.ming19.furnitureSales.service.ISystemDictionaryService;
import club.ming19.furnitureSales.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
public class GoodsController {
    @Autowired
    private IGoodsService goodsService;
    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequestMapping("/listGoods")
    public String listGoods(HttpServletRequest request, GoodsQueryObject qo) {
        try {
            PageResult<Goods> pageResult = goodsService.listGoods(qo);
            request.setAttribute("pageResult", pageResult);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "商品加载异常！请稍后再试或联系管理员...");
        }
        return "goods/list";
    }

    @RequestMapping("/editGoods")
    public String editGoods(HttpServletRequest request) {
        listGoodsClassify(request);//查询所有分类字典信息
        return "goods/input";
    }

    @RequestMapping("/showGoods")
    public String showGoods(HttpServletRequest request, Long id) {
        if (id == null) {
            request.setAttribute("msg", "没有指定商品！");
        } else {
            try {
                Goods goods = goodsService.getGoodsById(id);
                request.setAttribute("goods", goods);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "商品加载异常！请稍后再试或联系管理员...");
            }
        }
        return "goods/show";
    }

    private void listGoodsClassify(HttpServletRequest request) {
        //字典place
        List<SystemDictionaryItem> places = systemDictionaryService.querySystemDictionaryItemsByPsn("place");
        request.setAttribute("places", places);
        //字典material
        List<SystemDictionaryItem> materials = systemDictionaryService.querySystemDictionaryItemsByPsn("material");
        request.setAttribute("materials", materials);
        //字典style
        List<SystemDictionaryItem> styles = systemDictionaryService.querySystemDictionaryItemsByPsn("style");
        request.setAttribute("styles", styles);
        //字典room
        List<SystemDictionary> rooms = systemDictionaryService.querySystemDictionariesByPsn("room");
        request.setAttribute("rooms", rooms);
    }

    @RequestMapping("/imgUpload")
    @ResponseBody
    public FileUploadResult imgUpload(MultipartFile pic) {
        FileUploadResult result;
        // 把图片保存到图片目录下
        // 保存图片，这个图片有的时候文件名可能会重复，你保存多了会把原来的图片给覆盖掉，这就不太合适了。
        // 所以为每个文件生成一个新的文件名
        String picName = UUID.randomUUID().toString();
        // 截取文件的扩展名(如.jpg)
        String oriName = pic.getOriginalFilename();
        String extName = oriName.substring(oriName.lastIndexOf("."));
        // 保存文件
        try {
            pic.transferTo(new File("D:/IdeaProjects/parent/imgServer/goods/" + picName + extName));
            result = new FileUploadResult(true, "图片上传成功！", UserContext.PICSERVER + "/goods/" + picName + extName);
        } catch (Exception e) {
            e.printStackTrace();
            result = new FileUploadResult("图片上传异常！请稍后再试或联系管理员...");
        }
        return result;
    }

    @RequestMapping("/saveGoods")
    @ResponseBody
    public AjaxResult saveGoods(Goods goods) {
        AjaxResult ajax;
        try {
            goods.setState(Goods.OUT);
            goods.setAddTime(new Date());
            goods.setSaleCount(0);
            int line = goodsService.saveGoods(goods);
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

    @RequestMapping("/addStockCount")
    @ResponseBody
    public AjaxResult addStockCount(Long id, int stock) {
        AjaxResult ajax;
        try {
            int line = goodsService.addStockCount(id, stock);
            if (line == 0) {
                ajax = new AjaxResult("添加库存失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "添加库存成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("添加库存异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }

    @RequestMapping("/updateGoodsState")
    @ResponseBody
    public AjaxResult updateState(Long id, boolean state) {
        AjaxResult ajax;
        try {
            int line = goodsService.updateState(id, state);
            if (line == 0) {
                ajax = new AjaxResult("操作失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "操作成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("操作异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }

    @RequestMapping("/updateImgs")
    @ResponseBody
    public AjaxResult uploadImgs(Long id, String imgs) {
        AjaxResult ajax;
        try {
            int line = goodsService.updateImgs(id, imgs);
            if (line == 0) {
                ajax = new AjaxResult("更新失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "更新成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("更新异常！请稍后再试或联系管理员...");
        }
        return ajax;
    }

    @RequestMapping("/listForActivity")
    public String listForActivity(HttpServletRequest request, GoodsQueryObject qo) {
        try {
            PageResult<Goods> pageResult = goodsService.listForActivity(qo);
            request.setAttribute("pageResult", pageResult);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "商品加载异常！请稍后再试或联系管理员...");
        }
        return "goods/listForActivity";
    }

    @RequestMapping("/showForActivity")
    public String showForActivity(HttpServletRequest request, Long id) {
        try {
            Goods goods = goodsService.getByIdForActivity(id);
            request.setAttribute("goods", goods);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "商品加载异常！请稍后再试或联系管理员...");
        }
        return "goods/showForActivity";
    }
}
