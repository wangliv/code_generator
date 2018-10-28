package com.wangli.dao;

import com.wangli.entity.ColumnBean;
import com.wangli.utils.StringUtils;
import org.apache.commons.dbutils.ResultSetHandler;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ColumnListHandler implements ResultSetHandler<List<ColumnBean>> {

    @Override
    public List<ColumnBean> handle(ResultSet rs) throws SQLException {
        List<ColumnBean> list = new ArrayList<>();
        ColumnBean bean = null;
        while(rs.next()){
            bean = new ColumnBean();
            bean.setTableName(StringUtils.toCamelCase(rs.getString("table_name")));
            bean.setColumnKey(rs.getString("column_key"));
            bean.setColumnName(rs.getString("column_name"));
            bean.setIsNullable(rs.getString("is_nullable"));
            bean.setDataType(rs.getString("data_type"));
            bean.setCharacterMaximumLength(rs.getString("character_maximum_length"));
            bean.setColumnComment(rs.getString("column_comment"));
            bean.setColumnCamelName(StringUtils.toCamelCase(bean.getColumnName()));
            list.add(bean);
        }
        return list;
    }

}
