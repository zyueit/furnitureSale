import club.ming19.furnitureSales.util.MD5;

import java.util.ArrayList;
import java.util.List;

public class test {
    public static void main(String[] args) {
        List<String> list = new ArrayList<>();
        list.add("fgsfsdfdt");
        list.add("fgsfsdfdt");
        list.add("fgsfsdfdt");
        list.add("fgsfsdfdt");
        list.add("fgsfsdfdt");
        String s = list.toString();
        System.out.println(s.substring(1, s.length() - 1).replace(" ", ""));
    }
}
