package club.ming19.furnitureSales.query;

import club.ming19.furnitureSales.util.StringUtil;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LoginInfoQueryObject extends QueryObject {
    private String keyword;
    private int userType;//是查前台用户登陆信息还是查后台用户登陆信息
    private int state = -1;//实名认证状态

    public String getKeyword() {
        if (StringUtil.isEmpty(keyword)) {
            return null;
        }
        return keyword.trim();
    }
}
