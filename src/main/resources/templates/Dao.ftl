package ${daopackage};

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import ${entitypackage}.${tableName};

@Repository
public interface ${tableName}Dao {

    /**
     * 查询所有
     * @param form
     * @return
     */
    List<${tableName}> list(${tableName} form);

    /**
    * 添加
    * @param form
    * @return
    */
    int add(${tableName} form);

    /**
    * 删除
    * @param id
    * @return
    */
    int delete(${tableName} form);

    /**
    * 修改
    * @param form
    * @return
    */
    int update(${tableName} form);
}
