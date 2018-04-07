package club.ming19.furnitureSales.domain;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 用户登陆信息
 */
@Setter
@Getter
@Alias("LoginInfo")
public class LoginInfo extends BaseDomain {
    public static final String MANAGER_PASSWORD = "88888888";//后台初始密码

    public static final int USER_CLIENT = 0;//前台用户
    public static final int USER_MANAGER = 1;//后台管理用户

    private String username;
    private String password;
    private int userType = USER_CLIENT;
    private Date loginTime;//最近一次登陆时间
}
