package club.ming19.furnitureSales.query;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class QueryObject {
    private int pageSize = 10;//默认一页最多显示10条
    private int currentPage = 1;//默认显示第一页

    public int getStartIndex() {
        return (currentPage - 1) * pageSize;
    }
}
