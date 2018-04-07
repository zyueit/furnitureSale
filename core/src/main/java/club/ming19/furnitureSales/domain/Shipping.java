package club.ming19.furnitureSales.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Setter
@Getter
@Alias("Shipping")
public class Shipping extends BaseDomain {
    private String name;//收货人姓名
    private String phone;//收货人电话
    private String address;//收货人地址
    private boolean state = false;//默认地址
}
