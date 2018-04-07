package club.ming19.furnitureSales.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.util.List;

/**
 * 字典目录
 */
@Setter
@Getter
@Alias("SystemDictionary")
public class SystemDictionary extends BaseDomain {
    private String sn;//目录编码
    private String name;//名称
    private String intro;//简介
}
