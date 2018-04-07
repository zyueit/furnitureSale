package club.ming19.furnitureSales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserInfoController {

    @RequestMapping("/indexOfUserInfo")
    public String ToIndex() {
        return "userInfo/index";
    }
}
