package club.ming19.furnitureSales.service;

import club.ming19.furnitureSales.domain.LoginInfo;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.LoginInfoQueryObject;

import java.util.Date;

public interface ILoginInfoService {
    LoginInfo getForLoginCheck(String username, String password, int userType);

    String getLoginIdById(Long id);

    PageResult<LoginInfo> listLoginInfo(LoginInfoQueryObject qo);

    int updateLoginTimeAndIdById(Date loginTime, String login_id, Long id);

    int resetPassword(Long id, String password);

    int saveLoginInfo(LoginInfo loginInfo);
}
