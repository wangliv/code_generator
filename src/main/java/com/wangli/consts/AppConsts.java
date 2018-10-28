package com.wangli.consts;

import com.wangli.utils.StringUtils;

import java.util.function.Function;

public class AppConsts {

    /**
     * table_name=>TableName
     * Function
     */
    public static final Function<String, String> FN = t -> StringUtils.toCapital(StringUtils.toCamelCase(t));

    /**
     * 需要生成的模板
     */
    public static final String[] TEMPLATES = new String[]{"Entity.ftl", "Dao.ftl", "Mapper.ftl", "Service.ftl", "Controller.ftl", "Page.ftl", "Javascript.ftl"};

    /**
     * 默认输出路径
     */
    public static final String DEFAULT_OUTPUT_PATH="/crud";

}
