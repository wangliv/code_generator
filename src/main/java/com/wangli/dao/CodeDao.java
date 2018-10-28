package com.wangli.dao;

import com.wangli.entity.ColumnBean;
import com.wangli.utils.DBUtils;
import org.apache.commons.dbutils.QueryRunner;
import java.sql.SQLException;
import java.util.List;

public final class CodeDao {

    private static final CodeDao dao = new CodeDao();

    private CodeDao(){}

    public static CodeDao getInstance(){
        return dao;
    }


    /**
     * 初始化QueryRunner对象
     */
    private static final QueryRunner qx  = new QueryRunner(DBUtils.getDataSource());


    /**
     * 查询指定数据库
     * 指定表的字段信息
     * @param schemaName
     * @param tableName
     * @return
     * @throws SQLException
     */
    public List<ColumnBean> selectColumns(String schemaName , String tableName) throws SQLException {
        String sql = "SELECT table_name ,column_Key  ," +
                "column_name ,is_nullable ," +
                "data_type , character_maximum_length , " +
                "column_comment  FROM COLUMNS" +
                " WHERE table_schema =?  AND table_name = ? ORDER BY ORDINAL_POSITION" ;
        Object[] params = new Object[]{schemaName,tableName};
        return qx.query(sql, new ColumnListHandler(), params);
    }

}
