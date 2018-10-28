package com.wangli;

import com.wangli.consts.AppConsts;
import com.wangli.process.Processor;
import com.wangli.utils.FileUtils;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.Stream;

/**
 * @author wangli
 * a simple code generator
 */
public class App {

    //默认输出路径
    private final static String DEFAULT_PATH = AppConsts.DEFAULT_OUTPUT_PATH;

    //处理器
    private static final Processor processor = new Processor();

    //初始化输出目录
    static {
        FileUtils.mkdirs(DEFAULT_PATH);
    }

    //程序入口
    public static void main(String[] args) {
        System.out.println("###############CRUD代码生成器#################\n");
        MainLoop();
        System.out.println("###############CRUD代码生成器#################\n");
    }

    /**
     * 主循环事件
     */
    private static void MainLoop() {
        try(BufferedReader br = new BufferedReader(new InputStreamReader(System.in))) {
            final List<String> outputPaths = new ArrayList<>();

            String schema = input(br, "数据库名", "db_name");
            String tableNames = input(br, "表名（多个用逗号分割）", "TABLE1,TABLE2...");
            String defaultFlag = input(br, "是否默认路径[" + DEFAULT_PATH + "]输出[Y：是]", "Y/N");
            if ("y".equalsIgnoreCase(defaultFlag)) {
                IntStream.rangeClosed(0, 6).forEach(i -> outputPaths.add(DEFAULT_PATH));
            } else {
                String entityOutput = input(br, "实体类输出路径", DEFAULT_PATH);
                String daoOutput = input(br, "DAO类输出路径", DEFAULT_PATH);
                String mapperOutput = input(br, "Mapper.xml输出路径", DEFAULT_PATH);
                String serviceOutput = input(br, "Service类输出路径", DEFAULT_PATH);
                String controllerOutput = input(br, "Controller类输出路径", DEFAULT_PATH);
                String jspOutput = input(br, "JSP/JS输出路径", DEFAULT_PATH);
                outputPaths.addAll(Arrays.asList(entityOutput, daoOutput, mapperOutput,
                        serviceOutput, controllerOutput, jspOutput, jspOutput));
            }

            System.out.println("\n正在处理...\n");
            final long start = System.nanoTime();
            //并行流处理多个table
            Stream.of(tableNames.split(","))
                    .parallel()
                    .forEach(tableName ->
                    {
                        try {
                            processor.process(schema, tableName.trim(), outputPaths);
                        } catch (Exception e) {
                            System.out.printf("处理异常*_*，原因:%s\n", e.getMessage());
                        }
                    });

            final float total = (System.nanoTime() - start) / 1_000_000_000.0f;
            System.out.printf("\n处理结束^_^，耗时:%.2f 秒\n\n", total);
        } catch (IOException e) {
            System.out.printf("程序崩溃*_*，原因:%s\n", e.getMessage());
        }
    }


    /**
     * 读取用户输入值
     *
     * @param br
     * @param value
     * @param tip
     * @throws IOException
     */
    private static String input(BufferedReader br, String value, String tip) throws IOException {
        System.out.printf("请输入%s：", value);
        String read = br.readLine();
        while (read == null || "".equals(read.trim())) {
            System.out.printf("输入不合法，格式：<%s>\n", tip);
            System.out.printf("请重新输入%s：", value);
            read = br.readLine();
        }
        return read.trim();
    }

}
