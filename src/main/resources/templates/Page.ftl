<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<html>
<head>

    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/bootstrap/css/znvweb_plugin.css" />
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/datatables/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/datatables/css/buttons.bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/datatables/css/buttons.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/datatables/css/znvDataTable.css">
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/bootstrap/css/select2.css">
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/icheck/css/polaris.css">
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/bootstrap/css/bootstrap.modal.css">
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}/resource/plugin/jQuery-Validation-Engine-master/css/validationEngine.jquery.css">
    <link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}<s:theme code='theme'/>base.css" />
    <!--<link rel="stylesheet" type="text/css" href="${r"${"}contextpath${r"}"}<s:theme code='theme'/>pvip.baseinfomng.baseinfomng.css" /> -->

    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/js/znvweb_plugin.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/bootstrap/js/wating.mask.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/datatables/js/jszip.min.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/bootstrap/js/modal.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/datatables/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/datatables/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/datatables/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/icheck/js/icheck.min.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/datatables/js/buttons.bootstrap.min.js"></script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/bootstrap/js/select2.js"></script>
    <script type="text/javascript">
        var ZnvWeb = parent.ZnvWeb;
        $.fn.serializeObject = function() {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name]) {
                    if (!o[this.name].push) {
                        o[this.name] = [ o[this.name] ];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        }
    </script>
    <script type="text/javascript" src="${r"${"}contextpath${r"}"}/resource/plugin/datepicker/WdatePicker.js"></script>
    <script src="${r"${"}contextpath${r"}"}/resource/plugin/jQuery-Validation-Engine-master/js/languages/jquery.validationEngine-zh_CN.js"></script>
    <script src="${r"${"}contextpath${r"}"}/resource/plugin/jQuery-Validation-Engine-master/js/jquery.validationEngine.js"></script>
</head>
<body>
<div class="table_container" id="table_container">
    <table id="${tableName}" class="table">
        <thead>
        <tr>
     <#assign y= 0 />
     <#list columnList as x >
         <#if x.columnKey != "PRI" && y < 5 >
             <th>${x.columnComment}</th>
             <#assign y= y+1 />
         </#if>
     </#list>
            <th>操作</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>


<!-- 查看-->
<div class="${tableName}-viewInfo-dialog" style="display: none;height: 400px;overflow-x: hidden;">
    <div class="info-content">
     <#list columnList as x >
      <#if x.columnKey != "PRI">
         <div class="row">
             <div class="col-md-4">
                 <label>${x.columnComment}:</label>
             </div>
             <div class="col-md-6">
                 <div id="${tableName}_v_${x.columnCamelName}"></div>
             </div>
         </div>
      </#if>
     </#list>

        <div class="row" style="height: 60px;" >
        </div>
        <div class="row">
            <div class="col-md-5"></div>
            <div class="col-md-4">
                <div class="cancel-workplan btn" onClick="page${tableName}.closeDlg();"
                     style="margin-left: 12px;">关闭</div>
            </div>
        </div>
    </div>
</div>


<!-- 编辑 -->
<div class="${tableName}-editInfo-dialog" style="display: none;height: 400px;overflow-x: hidden;">
    <form id="${tableName}-Form" method="post">
        <div id="${tableName}-baseinfo" class="info-content" style="margin-top: 30px;" >
        <#list columnList as x >
            <#if x.columnKey == "PRI">
               <input type="hidden" id="${tableName}_e_${x.columnCamelName}" name="${x.columnCamelName}" >
            <#else>
               <div class="row">
                   <div class="col-md-4">
                       <label>${x.columnComment}:</label>
                   </div>
                   <div class="col-md-6">
                     <#if x.dataType=="int"||x.dataType=="float"||x.dataType=="double"||x.dataType=="decimal"||x.dataType=="bigint"||x.dataType=="tinyint"||x.dataType=="smallint" >
                        <input id="${tableName}_e_${x.columnCamelName}" name="${x.columnCamelName}" type="text" class="validate[<#if x.isNullable=='NO'>required,</#if>number]" />
                     <#elseif x.dataType=="varchar"||x.dataType=="char"||x.dataType=="longtext"||x.dataType=="mediumtext" >
                        <input id="${tableName}_e_${x.columnCamelName}" name="${x.columnCamelName}" type="text" class="validate[<#if x.isNullable=='NO'>required,</#if>maxSize[${x.characterMaximumLength}]]" />
                     <#elseif x.dataType=="date"||x.dataType=="datetime"||x.dataType=="timestamp" >
                        <input class="datepicker Wdate " <#if x.isNullable=='NO'>required=true</#if>  type="text" name="${x.columnCamelName}" id="${tableName}_e_${x.columnCamelName}"
                               onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                     <#else>
                         <input id="${tableName}_e_${x.columnCamelName}" name="${x.columnCamelName}" type="text" class="validate[<#if x.isNullable=='NO'>required</#if>]" />
                     </#if>
                  <#if x.isNullable=="NO">
                     <span class="require" style="color:#f00;font-weight: bold;line-height: 1.5em;font-size: 1.1vw;">*</span>
                  </#if>
                   </div>
               </div>
            </#if>
        </#list>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-6">
                    <div class="submit-workplan btn" onClick = "page${tableName}.submitInfo();">提交</div>
                    <div class="cancel-workplan btn" onClick = "page${tableName}.closeDlg();" style="margin-left: 12px;">取消</div>
                </div>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${tableName}-init.js"></script>
</body>
</html>
