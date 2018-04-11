package club.ming19.furnitureSales.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 订单对象
 */
@Setter
@Getter
@Alias("OrderBill")
public class OrderBill extends BaseDomain {
    public static final int CANCEL_BILL = -1;//订单取消
    public static final int WAIT_TO_PAY = 0;//待付款
    public static final int WAIT_TO_SEND = 1;//待发货
    public static final int WAIT_TO_TAKE = 2;//待收货
    public static final int WAIT_TO_EVAL = 3;//待评价
    public static final int SUCCESS_BILL = 4;//订单完成

    private String sn;//订单编号
    private BigDecimal totalAmount;//订单总金额
    private int state = WAIT_TO_PAY;//订单状态
    private Date createTime;//创建时间
    private Date takeTime;//收货时间
    private String remark;//买家留言

    private LoginInfo loginInfo;//购买商品的用户
    private Shipping shipping;//收货（送货）信息

    private List<OrderBillItem> items;
}
