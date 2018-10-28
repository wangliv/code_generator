<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${daopackage}.${tableName}Dao">
    <select id="list" resultType="${entitypackage}.${tableName}">
        SELECT
        <#list columnList as x >${x.columnName}<#if x_has_next>,</#if></#list>
        FROM ${tableNameDb}
        <where>
             <#list columnList as x >
             <if test="${x.columnCamelName} !=null and ''!=${x.columnCamelName}">
                 and ${x.columnName}=${r"#{"}${x.columnCamelName}${r"}"}
             </if>
             </#list>
        </where>
    </select>


    <insert id="add" >
        INSERT INTO ${tableNameDb}
            (<#list columnList as x >${x.columnName}<#if x_has_next>,</#if></#list>)
        VALUES
            (<#list columnList as x > ${r"#{"}${x.columnCamelName}${r"}"}<#if x_has_next>,</#if></#list>)
    </insert>


    <delete id="delete">
        DELETE FROM ${tableNameDb} WHERE
        <#assign y=0 />
        <#list columnList as x >
            <#if x.columnKey == "PRI">
                <#if y ==0 >
                    ${x.columnName}=${r"#{"}${x.columnCamelName}${r"}"}
                <#else>
                   AND ${x.columnName}=${r"#{"}${x.columnCamelName}${r"}"}
                </#if>
                <#assign y=y+1 />
            </#if>
        </#list>
    </delete>


    <update id="update">
        UPDATE ${tableNameDb}
        <set>
         <#list columnList as x >
         <#if x.columnKey != "PRI">
             <if test="${x.columnCamelName} !=null and ''!=${x.columnCamelName}">
                ${x.columnName}=${r"#{"}${x.columnCamelName}${r"}"},
             </if>
         </#if>
         </#list>
        </set>
        WHERE
        <#assign y=0 />
        <#list columnList as x >
            <#if x.columnKey == "PRI">
               <#if y == 0 >
                   ${x.columnName}=${r"#{"}${x.columnCamelName}${r"}"}
               <#else>
                  AND ${x.columnName}=${r"#{"}${x.columnCamelName}${r"}"}
               </#if>
                <#assign y=y+1 />
            </#if>
        </#list>
    </update>

</mapper>
