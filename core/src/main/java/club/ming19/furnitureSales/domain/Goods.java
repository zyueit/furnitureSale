package club.ming19.furnitureSales.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 家具商品
 */
@Setter
@Getter
@Alias("Goods")
public class Goods extends BaseDomain {
    public static final int OUT = 0;//下架中
    public static final int ADD = 1;//上架了

    private String sn;//商品编码
    private String name;//商品名称--如：上等白杨实木框架 储物收纳L型沙发 清新双色拼接转角沙发
    //数据从SystemDictionaryItem来
    private String place;//商品产地
    private String style;//商品风格
    private String material;//商品材料
    private SystemDictionaryItem room;//商品摆放位置
    private String type;//商品类型(和商品摆放位置有关)

    private String size;//商品尺寸
    private int num;//包含件数
    private BigDecimal stockCount;//库存数量

    private BigDecimal costPrice;//成本
    private BigDecimal salePrice;//销售价
    private BigDecimal discountPrice;//优惠价
    private String intro;//介绍(设计理念)
    private String imgs;//商品图片--多张图片路径采用','分割，如：http://loaclhost/1.jsp,http://loaclhost/2.jsp

    private Date addTime;//添加商品的时间
    private int state = OUT;//商品状态--上架--下架
    private int saleCount;//销量

    private Activity activity;//正在参加的活动--只能参加一个正在进行的活动
}