package club.ming19.furnitureSales.page;

import lombok.Getter;
import lombok.Setter;

/**
 * Ajax请求操作返回信息
 */
@Setter
@Getter
public class AjaxResult {
    private boolean success;
    private String msg;

    public AjaxResult(boolean success, String msg) {
        this.success = success;
        this.msg = msg;
    }

    public AjaxResult(String msg) {
        //只传msg，表示默认操作失败！
        this(false, msg);
    }
}
