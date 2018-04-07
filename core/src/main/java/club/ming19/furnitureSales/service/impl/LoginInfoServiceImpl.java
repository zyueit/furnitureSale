package club.ming19.furnitureSales.service.impl;

import club.ming19.furnitureSales.domain.LoginInfo;
import club.ming19.furnitureSales.mapper.LoginInfoMapper;
import club.ming19.furnitureSales.page.PageResult;
import club.ming19.furnitureSales.query.LoginInfoQueryObject;
import club.ming19.furnitureSales.service.ILoginInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class LoginInfoServiceImpl implements ILoginInfoService {
    @Autowired
    private LoginInfoMapper loginInfoMapper;

    @Override
    public LoginInfo getForLoginCheck(String username, String password, int userType) {
        return loginInfoMapper.getLoginInfoForLogin(username, password, userType);
    }

    @Override
    public String getLoginIdById(Long id) {
        return loginInfoMapper.getLoginIdById(id);
    }

    @Override
    public PageResult<LoginInfo> listLoginInfo(LoginInfoQueryObject qo) {
        int totalCount = loginInfoMapper.listLoginInfoCount(qo).intValue();
        if (totalCount == 0) {
            return PageResult.empty(qo.getPageSize());
        }
        List<LoginInfo> rows = loginInfoMapper.listLoginInfo(qo);
        return new PageResult<>(rows, totalCount, qo.getCurrentPage(), qo.getPageSize());
    }

    @Override
    public int updateLoginTimeAndIdById(Date loginTime, String login_id, Long id) {
        return loginInfoMapper.updateLoginTimeAndIdById(loginTime, login_id, id);
    }

    @Override
    public int resetPassword(Long id, String password) {
        return loginInfoMapper.resetPassword(id, password);
    }

    @Override
    public int saveLoginInfo(LoginInfo loginInfo) {
        return loginInfoMapper.saveLoginInfo(loginInfo);
    }
}
