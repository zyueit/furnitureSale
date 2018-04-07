package club.ming19.furnitureSales.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 活动(这里统一是打折活动0.0)
 */
@Setter
@Getter
@Alias("Activity")
public class Activity extends BaseDomain {
    public static final int COMING = 0;//即将开始
    public static final int MOTION = 1;//进行中
    public static final int END = 2;//正常结束
    public static final int FORCE_END = 3;//强制结束

    //活动评估
    public static final int FAILURE = -1;//失败
    public static final int MEDIUM = 0;//一般
    public static final int SUCCESS = 1;//成功

    private String title;//活动标题
    private String intro;//活动简介
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date beginTime;//开始时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date endTime;//结束时间
    private BigDecimal discount;//折扣
    private int state = COMING;//活动状态

    private boolean esState = false;//活动评估状态
    private int estimate;//活动评估
    private String esIntro;//活动评估说明

    private List<Goods> goods;
}
