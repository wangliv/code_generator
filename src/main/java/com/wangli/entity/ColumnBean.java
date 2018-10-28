package com.wangli.entity;

public class ColumnBean {
    private String tableName;//表名
    private String columnKey;//主键时为:PRI
    private String columnName;//字段名
    private String columnCamelName;//转驼峰后的字段名
    private String isNullable;//是否可为空
    private String dataType;//数据类型
    private String characterMaximumLength;//字符最大长度
    private String columnComment;//注释

    public String getTableName() {
        return tableName;
    }

    public ColumnBean setTableName(String tableName) {
        this.tableName = tableName;
        return this;
    }

    public String getColumnKey() {
        return columnKey;
    }

    public ColumnBean setColumnKey(String columnKey) {
        this.columnKey = columnKey;
        return this;
    }

    public String getColumnName() {
        return columnName;
    }

    public ColumnBean setColumnName(String columnName) {
        this.columnName = columnName;
        return this;
    }

    public String getColumnCamelName() {
        return columnCamelName;
    }

    public ColumnBean setColumnCamelName(String columnCamelName) {
        this.columnCamelName = columnCamelName;
        return this;
    }

    public String getIsNullable() {
        return isNullable;
    }

    public ColumnBean setIsNullable(String isNullable) {
        this.isNullable = isNullable;
        return this;
    }

    public String getDataType() {
        return dataType;
    }

    public ColumnBean setDataType(String dataType) {
        this.dataType = dataType;
        return this;
    }

    public String getCharacterMaximumLength() {
        return characterMaximumLength;
    }

    public ColumnBean setCharacterMaximumLength(String characterMaximumLength) {
        this.characterMaximumLength = characterMaximumLength;
        return this;
    }

    public String getColumnComment() {
        return columnComment;
    }

    public ColumnBean setColumnComment(String columnComment) {
        this.columnComment = columnComment;
        return this;
    }
}
