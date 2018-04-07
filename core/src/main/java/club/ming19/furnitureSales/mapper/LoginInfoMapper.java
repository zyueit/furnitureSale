package club.ming19.furnitureSales.mapper;

import club.ming19.furnitureSales.domain.LoginInfo;
import club.ming19.furnitureSales.query.LoginInfoQueryObject;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface LoginInfoMapper {
    LoginInfo getLoginInfoForLogin(@Param("username") String username,
                                   @Param("password") String password,
                                   @Param("userType") int userType);

    String getLoginIdById(Long id);

    Long listLoginInfoCount(LoginInfoQueryObject qo);

    List<LoginInfo> listLoginInfo(LoginInfoQueryObject qo);

    int updateLoginTimeAndIdById(@Param("loginTime") Date loginTime, @Param("login_ID") String login_id, @Param("id") Long id);

    int resetPassword(@Param("id") Long id, @Param("password") String password);

    int saveLoginInfo(LoginInfo loginInfo);
}
