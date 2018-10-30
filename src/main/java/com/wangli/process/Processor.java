package com.wangli.process;

import com.wangli.consts.AppConsts;
import com.wangli.dao.CodeDao;
import com.wangli.entity.ColumnBean;
import com.wangli.utils.DBUtils;
import com.wangli.utils.FileUtils;
import com.wangli.utils.StringUtils;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.stream.IntStream;

public class Processor {


    //配置freemaker模板
    private static final Configuration CFG = new Configuration(Configuration.VERSION_2_3_22);

    //初始化模板引擎
    static {
        CFG.setClassForTemplateLoading(Processor.class, "/templates");
        CFG.setDefaultEncoding("UTF-8");
        CFG.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
    }

    /**
     * 核心处理方法
     */
    public void process(String schema, String tableName, List<String> outputPaths) throws SQLException, InterruptedException {

        final Map<String, Object> root = new HashMap<>();
        final String businessName = AppConsts.FN.apply(tableName);
        final int size = AppConsts.TEMPLATES.length;
        final CountDownLatch latch = new CountDownLatch(size);
        //查询表字段信息
        final List<ColumnBean> list = CodeDao.getInstance().selectColumns(schema, tableName);
        if (null == list || list.size() == 0)
            throw new RuntimeException("[" + schema + "." + tableName + "] 不存在，请检查");

        root.put("tableNameDb", tableName);
        root.put("tableName", businessName);
        root.put("columnList", list);
        this.setPackage(root);

        //多线程并行处理模板(深思)
        IntStream.range(0, size)
                .parallel()
                .mapToObj(index -> new Thread(() -> {
                    String templateName = AppConsts.TEMPLATES[index];
                    String outputName = StringUtils.buildFileName(templateName, businessName);
                    String path = outputPaths.get(index);
                    FileUtils.mkdirs(path);//输入的目录不存在，则创建
                    this.createCodeFile(root, path, outputName, templateName);
                    latch.countDown();
                }))
                .forEach(Thread::start);
        latch.await();
    }

    /**
     * 生成单个Code文件
     *
     * @param root
     * @param path
     * @param outputName
     * @param templateName
     */
    private void createCodeFile(Map<String, Object> root, String path, String outputName, String templateName) {
        try (Writer writer = new OutputStreamWriter(new FileOutputStream(new File(path, outputName)),AppConsts.CHAR_SET)) {
            Template template = CFG.getTemplate(templateName);
            template.process(root, writer);
            System.out.printf("==> %s 代码生成，目录：%s\n", outputName, path);
        } catch (Exception e) {
            System.out.printf("<== %s 生成失败，目录：%s,原因：%s\n", outputName, path, e.getMessage());
        }
    }


    /**
     * 设置controller,service,dao,entity的包
     * 从jdbc.properties中加载
     * @param root
     */
    private void setPackage(final Map<String, Object> root) {
        String entitypackage = (String) DBUtils.properties.get("entity.package");
        String daopackage = (String) DBUtils.properties.get("dao.package");
        String controllerpackage = (String) DBUtils.properties.get("controller.package");
        String servicepackage = (String) DBUtils.properties.get("service.package");
        root.put("entitypackage", entitypackage);
        root.put("daopackage", daopackage);
        root.put("servicepackage", servicepackage);
        root.put("controllerpackage", controllerpackage);
    }

}
