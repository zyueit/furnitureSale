package club.ming19.furnitureSales.mapper;

import club.ming19.furnitureSales.domain.Shipping;
import club.ming19.furnitureSales.domain.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserInfoMapper {
    Long checkUserExist(String info);

    int saveUserInfo(UserInfo userInfo);

    UserInfo getUserInfo(Long id);

    int updateUserInfo(UserInfo userInfo);

    List<UserInfo> listRealNameCheck();

    int updateStateOfUserInfo(@Param("id") Long id, @Param("state") int state);

    List<Shipping> queryShippingByUserId(Long id);

    int removeShipping(@Param("id") Long id, @Param("userInfo_id") Long userInfo_id);

    int resetShipping(Long userInfo_id);

    int setDefaultShipping(@Param("id") Long id, @Param("userInfo_id") Long userInfo_id);

    int saveShipping(@Param("shipping") Shipping shipping, @Param("id") Long id);

    int resetPassword(@Param("id") Long id, @Param("oldpassword") String oldpassword, @Param("newpassword") String newpassword);

    UserInfo getUserInfoByPhone(String phone);
}
