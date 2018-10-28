package com.wangli.utils;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtils {
    private static DruidDataSource dataSource = null;
    public static Properties properties;
    static {
        try {
            properties = loadPropertiesFile("jdbc.properties");
            dataSource = (DruidDataSource) DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            System.out.println("加载数据库配置信息失败...");
        }
    }

    /**
     * 获取dataSource
     * @return
     */
    public synchronized static DataSource getDataSource(){
        return dataSource;
    }

    /**
     * 获取数据库连接
     * @return
     * @throws SQLException
     */
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    /**
     * 加载配置信息
     *
     * @param name
     * @return
     */
    private static Properties loadPropertiesFile(String name) throws IOException {
        InputStream in = DBUtils.class.getClassLoader().getResourceAsStream(name);
        Properties p = new Properties();
        p.load(in);
        return p;
    }
}
