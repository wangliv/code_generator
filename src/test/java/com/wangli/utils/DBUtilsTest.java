package com.wangli.utils;

import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;

public class DBUtilsTest {

    @Test
    public void test1() throws SQLException {
        Connection connection = DBUtils.getConnection();
        System.out.println(connection);
    }

    @Test
    public void test2() throws SQLException {
        Connection connection = DBUtils.getConnection();
        System.out.println(connection);
    }
}
