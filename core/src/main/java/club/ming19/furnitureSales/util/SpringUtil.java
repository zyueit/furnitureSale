package club.ming19.furnitureSales.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

@Component
public class SpringUtil {
    private static ApplicationContext context;

    @Autowired
    public void setContext(ApplicationContext context) {
        SpringUtil.context = context;
    }

    public static ApplicationContext getContext() {
        return context;
    }
}
