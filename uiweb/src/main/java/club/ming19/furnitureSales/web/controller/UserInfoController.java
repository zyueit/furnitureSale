package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.*;
import club.ming19.furnitureSales.page.AjaxResult;
import club.ming19.furnitureSales.page.FileUploadResult;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.OrderBillQueryObject;
import club.ming19.furnitureSales.service.IGoodsService;
import club.ming19.furnitureSales.service.ILoginInfoService;
import club.ming19.furnitureSales.service.IOrderBillService;
import club.ming19.furnitureSales.service.IUserInfoService;
import club.ming19.furnitureSales.util.MD5;
import club.ming19.furnitureSales.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.net.ssl.HandshakeCompletedEvent;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserInfoController {
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IOrderBillService orderBillService;
    @Autowired
    private IGoodsService goodsService;

    @RequestMapping("/indexOfUserInfo")
    public String toIndex(HttpServletRequest request) {
        request.setAttribute("cmd", 0);

        getUserInfo(request);

        HttpSession session = request.getSession();
        LoginInfo user = (LoginInfo) session.getAttribute(UserContext.USER_IN_SESSION);

        queryInfoOfBill(request, user);

        List<Goods> recommend = goodsService.listGoodsBySaleCount();
        request.setAttribute("recommend", recommend);
        return "userInfo/index";
    }

    private void queryInfoOfBill(HttpServletRequest request, LoginInfo user) {
        //查询待付款订单数量
        Long wait_to_pay = orderBillService.getCountOfState(user.getId(), OrderBill.WAIT_TO_PAY);
        request.setAttribute("wait_to_pay", wait_to_pay);
        //查询待发货订单数量
        Long wait_to_send = orderBillService.getCountOfState(user.getId(), OrderBill.WAIT_TO_SEND);
        request.setAttribute("wait_to_send", wait_to_send);
        //查询待收货订单数量
        Long wait_to_take = orderBillService.getCountOfState(user.getId(), OrderBill.WAIT_TO_TAKE);
        request.setAttribute("wait_to_take", wait_to_take);
        //查询待评价订单数量
        Long wait_to_eval = orderBillService.getCountOfState(user.getId(), OrderBill.WAIT_TO_EVAL);
        request.setAttribute("wait_to_eval", wait_to_eval);
    }

    private void getUserInfo(HttpServletRequest request) {
        HttpSession session = request.getSession();
        LoginInfo user = (LoginInfo) session.getAttribute(UserContext.USER_IN_SESSION);
        UserInfo info = userInfoService.getUserInfo(user.getId());
        session.setAttribute(UserContext.USERINFO_IN_SESSION, info);
    }

    @RequestMapping("/personalUserInfo")
    public String toPersonalInfo(HttpServletRequest request) {
        request.setAttribute("cmd", 1);

        getUserInfo(request);

        List<Goods> newGoods = goodsService.listGoodsByAddTime();
        request.setAttribute("newGoods", newGoods);
        return "userInfo/personalInfo";
    }

    @RequestMapping("toHistoryOfBill")
    public String toHistoryOfBill(HttpServletRequest request, OrderBillQueryObject qo) {
        request.setAttribute("cmd", 2);

        HttpSession session = request.getSession();
        LoginInfo user = (LoginInfo) session.getAttribute(UserContext.USER_IN_SESSION);

        queryInfoOfBill(request, user);

        qo.setId(user.getId());
        PageResult<OrderBill> pageResult = orderBillService.queryBillsByStateAndUid(qo);
        request.setAttribute("pageResult", pageResult);
        return "userInfo/historyOfBill";
    }

    @RequestMapping("/addressOfShipping")
    public String toAddress(HttpServletRequest request) {
        request.setAttribute("cmd", 3);

        getUserInfo(request);

        HttpSession session = request.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute(UserContext.USERINFO_IN_SESSION);
        List<Shipping> shippings = userInfoService.queryShippingByUserId(userInfo.getId());
        userInfo.setShippings(shippings);

        List<Goods> newGoods = goodsService.listGoodsByAddTime();
        request.setAttribute("newGoods", newGoods);
        return "userInfo/address";
    }

    @RequestMapping("/toResetPassword")
    public String toResetPassword(HttpServletRequest request) {
        request.setAttribute("cmd", 6);
        return "userInfo/resetPassword";
    }

    @RequestMapping("/resetPassword")
    @ResponseBody
    public AjaxResult resetPassword(HttpServletRequest request, String oldpassword, String newpassword) {
        AjaxResult ajax;
        HttpSession session = request.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute(UserContext.USERINFO_IN_SESSION);
        try {
            int line = userInfoService.resetPassword(userInfo.getId(), MD5.encode(oldpassword), MD5.encode(newpassword));
            if (line == 0) {
                ajax = new AjaxResult("原来密码输入错误！请确认...");
            } else {
                session.invalidate();
                ajax = new AjaxResult(true, "保存成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("系统繁忙！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/saveShipping")
    @ResponseBody
    public AjaxResult saveShipping(Shipping shipping, Long id) {
        AjaxResult ajax;
        try {
            shipping.setState(false);
            int line = userInfoService.saveShipping(shipping, id);
            if (line == 0) {
                ajax = new AjaxResult("保存失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "保存成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("保存异常！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/removeShipping")
    @ResponseBody
    public AjaxResult removeShipping(HttpServletRequest request, Long id) {
        AjaxResult ajax;
        HttpSession session = request.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute(UserContext.USERINFO_IN_SESSION);
        try {
            int line = userInfoService.removeShipping(id, userInfo.getId());
            if (line == 0) {
                ajax = new AjaxResult("删除失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "删除成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("删除异常！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/setDefaultShipping")
    @ResponseBody
    public AjaxResult setDefaultShipping(HttpServletRequest request, Long id) {
        AjaxResult ajax;
        HttpSession session = request.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute(UserContext.USERINFO_IN_SESSION);
        try {
            userInfoService.resetShipping(userInfo.getId());
            int line = userInfoService.setDefaultShipping(id, userInfo.getId());
            if (line == 0) {
                ajax = new AjaxResult("设置失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "设置成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("设置异常！请稍后再试...");
        }
        return ajax;
    }

    @RequestMapping("/imgsUploadOfIdcard")
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
            pic.transferTo(new File("D:/IdeaProjects/parent/imgServer/ID_card/" + picName + extName));
            result = new FileUploadResult(true, "图片上传成功！", UserContext.PICSERVER + "/ID_card/" + picName + extName);
        } catch (Exception e) {
            e.printStackTrace();
            result = new FileUploadResult("图片上传异常！请稍后再试或联系管理员...");
        }
        return result;
    }

    @RequestMapping("/updateUserInfo")
    @ResponseBody
    public AjaxResult updateUserInfo(UserInfo userInfo) {
        AjaxResult ajax;
        try {
            userInfo.setState(UserInfo.IN_AUDIT);
            userInfo.setTime(new Date());
            int line = userInfoService.updateUserInfo(userInfo);
            if (line == 0) {
                ajax = new AjaxResult("提交失败！请稍后再试...");
            } else {
                ajax = new AjaxResult(true, "提交成功！");
                //getUserInfo(request);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajax = new AjaxResult("提交异常！请稍后再试...");

        }
        return ajax;
    }
}
