package club.ming19.furnitureSales.service;

import club.ming19.furnitureSales.domain.UserInfo;

public interface IUserInfoService {
    Long checkUserExist(String info);

    int saveUserInfo(UserInfo userInfo);
}
