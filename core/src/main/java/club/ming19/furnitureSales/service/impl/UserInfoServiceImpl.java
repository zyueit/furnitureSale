package club.ming19.furnitureSales.service.impl;

import club.ming19.furnitureSales.domain.Shipping;
import club.ming19.furnitureSales.domain.UserInfo;
import club.ming19.furnitureSales.mapper.UserInfoMapper;
import club.ming19.furnitureSales.service.IUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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

    @Override
    public UserInfo getUserInfo(Long id) {
        return userInfoMapper.getUserInfo(id);
    }

    @Override
    public int updateUserInfo(UserInfo userInfo) {
        return userInfoMapper.updateUserInfo(userInfo);
    }

    @Override
    public List<UserInfo> listRealNameCheck() {
        return userInfoMapper.listRealNameCheck();
    }

    @Override
    public int updateStateOfUserInfo(Long id, int state) {
        return userInfoMapper.updateStateOfUserInfo(id, state);
    }

    @Override
    public List<Shipping> queryShippingByUserId(Long id) {
        return userInfoMapper.queryShippingByUserId(id);
    }

    @Override
    public int removeShipping(Long id, Long userInfo_id) {
        return userInfoMapper.removeShipping(id, userInfo_id);
    }

    @Override
    public int resetShipping(Long userInfo_id) {
        return userInfoMapper.resetShipping(userInfo_id);
    }

    @Override
    public int setDefaultShipping(Long id, Long userInfo_id) {
        return userInfoMapper.setDefaultShipping(id, userInfo_id);
    }

    @Override
    public int saveShipping(Shipping shipping, Long id) {
        return userInfoMapper.saveShipping(shipping, id);
    }

    @Override
    public int resetPassword(Long id, String oldpassword, String newpassword) {
        return userInfoMapper.resetPassword(id, oldpassword, newpassword);
    }

    @Override
    public UserInfo getUserInfoByPhone(String phone) {
        return userInfoMapper.getUserInfoByPhone(phone);
    }
}
