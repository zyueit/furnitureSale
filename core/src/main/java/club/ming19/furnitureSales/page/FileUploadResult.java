package club.ming19.furnitureSales.page;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class FileUploadResult {
    private boolean success;
    private String msg;
    private String url;//上传文件保存路径

    public FileUploadResult(boolean success, String msg, String url) {
        this.success = success;
        this.msg = msg;
        this.url = url;
    }

    public FileUploadResult(String msg) {
        this(false, msg, null);
    }
}
