package club.ming19.furnitureSales.web.controller;

import club.ming19.furnitureSales.domain.*;
import club.ming19.furnitureSales.service.IOrderBillService;
import club.ming19.furnitureSales.service.IUserInfoService;
import club.ming19.furnitureSales.util.UserContext;
import club.ming19.furnitureSales.web.event.OrderBillInsertEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("user")
public class OrderBillController {
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IOrderBillService orderBillService;
    @Autowired
    private ApplicationContext context;

    @RequestMapping("/toOrderBill")
    public String toOrderBill(HttpServletRequest request, @RequestParam("ids") List<Long> ids) {
        HttpSession session = request.getSession();
        LoginInfo user = (LoginInfo) session.getAttribute(UserContext.USER_IN_SESSION);
        List<ShopCatItem> items = (List<ShopCatItem>) session.getAttribute(UserContext.SHOPCAT_IN_SESSION);

        List<Shipping> shippings = userInfoService.queryShippingByUserId(user.getId());
        request.setAttribute("shippings", shippings);

        List<OrderBillItem> billItems = createOrderBillItems(ids, items);
        request.setAttribute("billItems", billItems);
        return "orderBill/create";
    }

    @RequestMapping("/saveOrderBill")
    public String saveOrderBill(HttpServletRequest request, @RequestParam("ids") List<Long> ids, Long shipId, String remark) {
        HttpSession session = request.getSession();
        LoginInfo user = (LoginInfo) session.getAttribute(UserContext.USER_IN_SESSION);
        UserInfo info = userInfoService.getUserInfo(user.getId());

        List<ShopCatItem> items = (List<ShopCatItem>) session.getAttribute(UserContext.SHOPCAT_IN_SESSION);
        //创建订单明细
        List<OrderBillItem> billItems = createOrderBillItems(ids, items);
        //创建订单对象
        OrderBill bill = new OrderBill();
        //生成订单编号--用用户号码+时间生成
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        bill.setSn(info.getPhone() + df.format(new Date()));
        bill.setCreateTime(new Date());
        bill.setLoginInfo(user);
        bill.setItems(billItems);
        //计算总金额
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (OrderBillItem billItem : billItems) {
            totalAmount = totalAmount.add(billItem.getAmount());
        }
        bill.setTotalAmount(totalAmount);
        //设置收货地址
        Shipping shipping = new Shipping();
        shipping.setId(shipId);
        bill.setShipping(shipping);
        bill.setRemark(remark);
        bill.setState(OrderBill.WAIT_TO_PAY);

        //保存订单
        int line = orderBillService.saveOrderBill(bill);
        if (line != 0) {
            context.publishEvent(new OrderBillInsertEvent(bill.getId(), bill.getCreateTime()));
            //java8
            items.removeIf(item -> ids.contains(item.getGoods().getId()));
        }
        return "";
    }

    private List<OrderBillItem> createOrderBillItems(List<Long> ids, List<ShopCatItem> items) {
        ArrayList<OrderBillItem> billItems = new ArrayList<>();
        for (ShopCatItem item : items) {
            Goods goods = item.getGoods();
            if (ids.contains(goods.getId())) {
                //如果是订单商品，创建一个订单明细
                OrderBillItem billItem = new OrderBillItem();
                billItem.setGoods(goods);
                billItem.setNum(item.getNum());

                Activity activity = goods.getActivity();
                BigDecimal salePrice = goods.getSalePrice();
                if (activity == null || activity.getState() != Activity.MOTION) {
                    BigDecimal discountPrice = goods.getDiscountPrice();
                    if (discountPrice == null) {
                        billItem.setSalePrice(salePrice);
                    } else {
                        billItem.setSalePrice(discountPrice);
                    }
                } else {
                    billItem.setSalePrice(salePrice.multiply(activity.getDiscount()).divide(BigDecimal.valueOf(10), 2, RoundingMode.HALF_UP));
                }

                billItem.setAmount(billItem.getNum().multiply(billItem.getSalePrice()).setScale(2, RoundingMode.HALF_UP));

                billItems.add(billItem);
            }
        }
        return billItems;
    }
}
