package com.wangli.dao;

import org.junit.Test;

public class CodeDaoTest {

    @Test
    public void test()throws Exception{
        CodeDao dao = CodeDao.getInstance();
        System.out.println(dao.selectColumns("dbcfsd_0608","sys_user"));
    }

    @Test
    public void test2()throws  Exception{

    }
}
