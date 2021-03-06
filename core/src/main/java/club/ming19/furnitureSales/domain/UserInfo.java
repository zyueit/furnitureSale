package club.ming19.furnitureSales.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

@Setter
@Getter
@Alias("UserInfo")
public class UserInfo extends BaseDomain {
    public static final int AUDIT_FAILED = -1;//实名认证失败
    public static final int NO_REAL = 0;//未实名认证
    public static final int IN_AUDIT = 1;//提交审核中
    public static final int REAL = 2;//已实名认证

    private String phone;//联系电话

    private int state = NO_REAL;//实名认证状态
    private String name;//实名
    private String IDcard;//身份证号
    private Integer sex;//性别
    private String address;//住址
    private String imgs;//证件照片
    private Date time;//认证材料提交时间

    private List<Shipping> shippings;//收货信息
}
