package club.ming19.furnitureSales.domain;

import club.ming19.furnitureSales.util.StringUtil;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

/**
 * 字典明细
 */
@Setter
@Getter
@Alias("SystemDictionaryItem")
public class SystemDictionaryItem extends BaseDomain {
    private String name;//明细名称
    private String intro;//明细备注说明

    private SystemDictionary parent;//字典目录
}
