package club.ming19.furnitureSales.service;

import club.ming19.furnitureSales.domain.Shipping;
import club.ming19.furnitureSales.domain.UserInfo;

import java.util.List;

public interface IUserInfoService {
    Long checkUserExist(String info);

    int saveUserInfo(UserInfo userInfo);

    UserInfo getUserInfo(Long id);

    int updateUserInfo(UserInfo userInfo);

    List<UserInfo> listRealNameCheck();

    int updateStateOfUserInfo(Long id, int state);

    List<Shipping> queryShippingByUserId(Long id);

    int removeShipping(Long id, Long userInfo_id);

    int resetShipping(Long userInfo_id);

    int setDefaultShipping(Long id, Long userInfo_id);

    int saveShipping(Shipping shipping, Long id);

    int resetPassword(Long id, String oldpassword, String newpassword);

    UserInfo getUserInfoByPhone(String phone);
}
