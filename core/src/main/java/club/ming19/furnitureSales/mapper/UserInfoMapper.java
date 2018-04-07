package club.ming19.furnitureSales.mapper;

import club.ming19.furnitureSales.domain.UserInfo;

public interface UserInfoMapper {
    Long checkUserExist(String info);

    int saveUserInfo(UserInfo userInfo);
}
