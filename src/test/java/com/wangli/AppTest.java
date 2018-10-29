package com.wangli;

import com.wangli.dao.CodeDao;
import com.wangli.entity.ColumnBean;
import com.wangli.utils.StringUtils;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import org.junit.Test;

import java.io.*;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;
import java.util.stream.IntStream;

import static org.junit.Assert.assertTrue;

/**
 * Unit test for simple App.
 */
public class AppTest 
{

    private static final Function<String,String> fn = t -> StringUtils.toCapital(StringUtils.toCamelCase(t));
    /**
     * Rigorous Test :-)
     */
    @Test
    public void shouldAnswerWithTrue()
    {
        assertTrue( true );
    }

    @Test
    public void testA() throws IOException, TemplateException, SQLException {

        Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
        cfg.setClassForTemplateLoading(App.class, "/templates");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

       // Writer writer= new OutputStreamWriter(new FileOutputStream("F:\\ideal_wsp\\code_generator\\src\\main\\java\\com\\wangli\\entity\\aa.xml"));
        Writer writer= new OutputStreamWriter(System.out);
        Map<String,Object> root = new HashMap<>();

        String tableName = "base_project_info";

        List<ColumnBean> list = CodeDao.getInstance().selectColumns("dbcfsd_0608", tableName);

        root.put("tableNameDb",tableName);
        root.put("tableName",fn.apply(tableName));
        root.put("columnList",list);
        root.put("entitypackage","com.wangli.entity");
        root.put("daopackage","com.wangli.dao");
        root.put("servicepackage","com.wangli.service");
        root.put("controllerpackage","com.wangli.controller");

        Template template = cfg.getTemplate("Mapper.ftl");
        template.process(root,writer);
    }



}
