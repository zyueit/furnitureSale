package club.ming19.furnitureSales.page;

import lombok.Getter;
import lombok.Setter;

import java.util.Collections;
import java.util.List;

@Setter
@Getter
public class PageResult<T> {
    private List<T> rows;//分页数据
    private int totalCount;//总条数
    private int pageSize;//一页显示的条数
    private int currentPage;//当前页

    private int totalPage;//总页数
    private int prevPage;//上一页
    private int nextPage;//下一页

    public PageResult(List<T> rows, int totalCount, int currentPage, int pageSize) {
        this.rows = rows;
        this.totalCount = totalCount;
        this.currentPage = currentPage;
        this.pageSize = pageSize;

        this.totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : totalCount / pageSize + 1;
        this.prevPage = currentPage - 1 <= 1 ? 1 : currentPage - 1;
        this.nextPage = currentPage + 1 >= totalPage ? totalPage : currentPage + 1;
    }

    public static <T> PageResult<T> empty(int pageSize) {
        return new PageResult<>(Collections.emptyList(), 0, 1, pageSize);
    }
}
