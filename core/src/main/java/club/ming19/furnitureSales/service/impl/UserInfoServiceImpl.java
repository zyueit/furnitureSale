package club.ming19.furnitureSales.service.impl;

import club.ming19.furnitureSales.domain.UserInfo;
import club.ming19.furnitureSales.mapper.UserInfoMapper;
import club.ming19.furnitureSales.service.IUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserInfoServiceImpl implements IUserInfoService {
    @Autowired
    private UserInfoMapper userInfoMapper;

    @Override
    public Long checkUserExist(String info) {
        return userInfoMapper.checkUserExist(info);
    }

    @Override
    public int saveUserInfo(UserInfo userInfo) {
        return userInfoMapper.saveUserInfo(userInfo);
    }
}
