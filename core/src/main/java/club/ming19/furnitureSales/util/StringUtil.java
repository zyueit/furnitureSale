package club.ming19.furnitureSales.util;

public class StringUtil {
    private StringUtil() {
    }

    /**
     * 该字符不为null，""或"{空格...}"
     */
    public static boolean hasLength(String string) {
        return string != null && !"".equals(string.trim());
    }

    /**
     * 该字符为null，""或"{空格...}"
     */
    public static boolean isEmpty(String string) {
        return !hasLength(string);
    }
}
