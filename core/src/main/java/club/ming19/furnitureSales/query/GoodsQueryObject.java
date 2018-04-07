package club.ming19.furnitureSales.query;

import club.ming19.furnitureSales.util.StringUtil;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Setter
@Getter
public class GoodsQueryObject extends QueryObject {
    private String keyword;
    private int state = -1;
    private BigDecimal stockCount;


    private String style;
    private String material;
    private Long roomId;
    private String type;
    private BigDecimal lowMoney;
    private BigDecimal highMoney;

    private Integer sort = -1;//排序的依据

    public String getKeyword() {
        if (StringUtil.isEmpty(keyword)) {
            return null;
        }
        return keyword.trim();
    }

    public BigDecimal getHighMoney() {
        if (lowMoney != null && highMoney != null && lowMoney.compareTo(highMoney) > 0) {
            return null;
        }
        return highMoney;
    }
}
