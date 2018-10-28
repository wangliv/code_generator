package ${entitypackage};

public class ${tableName} {

<#list columnList as x>
     private String ${x.columnCamelName};//${x.columnComment}

     public String get${x.columnCamelName?cap_first}() {
        return ${x.columnCamelName};
    }

    public void set${x.columnCamelName?cap_first}(String ${x.columnCamelName}) {
        this.${x.columnCamelName} = ${x.columnCamelName};
    }
</#list>


}
