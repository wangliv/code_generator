package com.wangli.utils;

public class StringUtils {


    /**
     * 字符串首字母转大写
     * @param str
     * @return
     */
    public static String toCapital(String str){
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }

    /**
     * 下划线转驼峰
     * @param s
     * @return
     */
    public static String toCamelCase(String s) {
        if (s == null) {
            return null;
        }
        if(-1 == s.indexOf('_')){
            return s;
        }
        s = s.toLowerCase();
        StringBuilder sb = new StringBuilder(s.length());
        boolean upperCase = false;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '_') {
                upperCase = true;
            } else if (upperCase) {
                sb.append(Character.toUpperCase(c));
                upperCase = false;
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    /**
     *
     * @param templateName
     * @param businessName
     * @return
     */
    public static String buildFileName(String templateName,String businessName){
        String suffix = null;
        if("Mapper.ftl".equals(templateName)){
            suffix = ".xml";
        }else if("Entity.ftl".equals(templateName)){
            suffix = ".java";
        }else if("Dao.ftl".equals(templateName)){
            suffix = "Dao.java";
        }else if("Service.ftl".equals(templateName)){
            suffix = "Service.java";
        }else if("Controller.ftl".equals(templateName)){
            suffix = "Controller.java";
        }else if("Page.ftl".equals(templateName)){
            suffix = ".jsp";
        }else if("Javascript.ftl".equals(templateName)){
            suffix = "-init.js";
        }
        return businessName + suffix;
    }
}
