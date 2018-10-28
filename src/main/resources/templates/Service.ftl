package ${servicepackage};

import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ${daopackage}.${tableName}Dao;
import ${entitypackage}.${tableName};

@Service
public class ${tableName}Service {

    @Autowired
    private ${tableName}Dao dao;

    /**
     * 查询所有
     * @param form
     * @return
     */
    public List<${tableName}> list(${tableName} form){
         return dao.list(form);
    }

    /**
    * 添加
    * @param form
    * @return
    */
    public int add(${tableName} form){
    <#list columnList as x >
        <#if x.columnKey == "PRI">
        form.set${x.columnCamelName?cap_first}(Id());
        <#break>
        </#if>
    </#list>
        return dao.add(form);
    }

    /**
    * 删除
    * @param id
    * @return
    */
    public int delete(${tableName} form){
         return dao.delete(form);
    }

    /**
    * 修改
    * @param form
    * @return
    */
    public int update(${tableName}  form){
        return dao.update(form);
    }

    /**
    * 生成产品编号
    * @return
    */
    private final static String Id(){
        return UUID.randomUUID().toString().replace("-", "");
    }
}
