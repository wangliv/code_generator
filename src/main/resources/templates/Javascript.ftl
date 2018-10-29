$(function(){
	var table = null;
	page${tableName}.init();
})
var page${tableName} = {};
(function(_pp){

	_pp.initSelect = function(){
		$("select").select2({
			minimumResultsForSearch : Infinity
		})
	};

	_pp.initTable = function(){
		var listConfig = { // 参数配置
				"language" : { // 国际化
					"url" : "/resource/plugin/datatables/chinese/chinese.txt"
				},
				"buttons" : [{
					'text' : '增加',
					'className' : 'btn btn-primary btn-css', // 按钮的class样式
					'action' : function(dt) {
						$(".${tableName}-editInfo-dialog form input").each(function(){
							$(this).val('');
						});
						$("#detailDlg").Modal({
							width : "700",// 模态框宽度
							modal_title : "新增",
							modal_body : $(".${tableName}-editInfo-dialog").show(),
							modal_type : 1,
							is_close_hidden : 0,
							is_submit_hidden : 0,
							submit_click : function() {
								table.ajax.reload(null, false);
							},
							close_click : function() {
								table.ajax.reload(null, false);
							}
						});
					}
				}
				],
				"dom" : '<"col-sm-12"B><"contable"rt><"row table-foot-wrapper"<"col-sm-12"p><"clear">>',// 显示控件位置（搜索、分页控件等）
				"pagingType" : "simple_numbers",// 分页控件是否显示首页和末页
				"autoWidth" : false, // 禁用自动调整列宽
				"processing" : false, // 隐藏加载提示,自行处理
				"serverSide" : false, // 是否启用服务器端分页
				"searching" : true, // 禁用原生搜索
				"pageLength" : 10,// 每页显示数据量
				"aLengthMenu" : [ 10, 25, 50, 100 ],// 每页可选条数
				"scrollCollapse" : true, // 当显示更少记录时，是否允许表格减少高度
				"scrollX" : true, // 设置水平滚动
				"ordering" : true, // 是否允许Datatables开启排序
				"destroy": true,  //Cannot reinitialise DataTable,解决重新加载表格内容问题
				fnDrawCallback: TableDrawCallBack
		};

		table = $('#${tableName}').DataTable($.extend(true, {}, listConfig, {
			"bProcessing": true,
			"ajax": function (data, callback, settings) {
				ZnvWeb.post(ZnvWeb.contextPath + "site/PVIP/${tableName?lower_case}/list.ds", {}, function (errcode, data) {
					if (errcode != 0) {
						$("#alertModal").Modal({
							modal_body: ZnvWeb._resource['res.common.queryFail'],
							prompt_class: 2,
							modal_type:0
						});
						return;
					}
					if (data) {
						data = JSON.parse(data);
						callback(data);
					}
				},false);
			},
			"deferRender": true,//ajax请求时，加入此属性，加载速度快
			"columns": [
            <#assign y= 0 />
            <#list columnList as x >
				<#if x.columnKey != "PRI" && y < 5 >
                {
					data: "${x.columnCamelName}",
					orderable: false
				},
                <#assign y= y+1 />
				</#if>
            </#list>
				{
					orderable: false ,
					render: function (data, type, row, meta) {
						var info = JSON.stringify(row);
						return "<div class='table_icon edit_btn' onclick='page${tableName}.edit(" + info + ")'></div>" +
						"<div class='table_icon delete_btn' onclick='page${tableName}.remove(" + info + ")'></div>"+
						"<div class='table_icon detail_btn' onclick='page${tableName}.detail(" + info + ")'></div>";
					}
				}
				],
				"order": [[1, null]],//第一列排序图标改为默认
					"initComplete": function () {
						//表头与表身对齐
						$('.dataTables_scrollHeadInner').css('width', "100%");
						$('.dataTable').css('width', "100%");
					},
		}));
	}

	_pp.init = function(){
		_pp.initTable();
		_pp.initSelect();
	}

	_pp.closeDlg=function(){
		$(".closes").click();
	}

	_pp.submitInfo = function(){
		var form = $("#${tableName}-Form");
		if(!form.validationEngine('validate')){
			return;
		}
		var info = form.serializeObject();
		var url;
	<#list columnList as x >
		<#if x.columnKey == "PRI">
		if("" != info.${x.columnCamelName}){
		<#break>
		</#if>
	</#list>
			url = ZnvWeb.contextPath + "/site/PVIP/${tableName?lower_case}/update.ds";
		}else{
			url = ZnvWeb.contextPath + "/site/PVIP/${tableName?lower_case}/add.ds";
		}
		ZnvWeb.post(url,info,function(errorcode,data){
			data=JSON.parse(data);
			if(errorcode== 0 && data.errorCode!=0){
				$(".closes").click();
				_pp.alertDlg("操作成功！",4);
				table.ajax.reload(null, false);
			}else{
				_pp.alertDlg("操作失败！",1);
			}
			_pp.initDialog(form);

		},false)

	}

	_pp.remove = function(info){
		$("#deleteDlg").Modal({
			modal_title : ZnvWeb._resource["scim.vcms.contentmng.tishi"],
			modal_body : "确定要删除吗？",
			prompt_class : 3,
			modal_type : 0,
			width : '300',
			close_id : "closesubmit",
			submit_id : "delsubmit",
			is_close_hidden : 0,
			is_submit_hidden : 1,
			close_content : ZnvWeb._resource['res.common.close'],
			submit_content : ZnvWeb._resource['res.common.confirm'],
			submit_click : function() {
				ZnvWeb.post(ZnvWeb.contextPath + "/site/PVIP/${tableName?lower_case}/delete.ds",info,
                         function(errorcode,data){
							data=JSON.parse(data);
							if(errorcode==0&&data.errorCode!=0){
								_pp.alertDlg("操作成功！",4);
								table.ajax.reload(null, false);
							}else{
								_pp.alertDlg("操作失败！",1);
							}
						},false)
			},
			close_click : function() {
			}
		});
	}


	_pp.edit = function(info){
		for(p in info){
			$("#${tableName}_e_" + p).val(info[p]);
		}
		$("#detailDlg").Modal({
			width : "700",
			modal_title : "编辑",
			modal_body : $(".${tableName}-editInfo-dialog").show(),
			modal_type : 1,
			is_close_hidden : 0,
			is_submit_hidden : 0,
			submit_click : function() {
				table.ajax.reload(null, false);
			},
			close_click : function() {
				table.ajax.reload(null, false);
			}
		});
	}

	_pp.detail = function(info){
		for(p in info){
			$("#${tableName}_v_" + p).text(info[p]);
		}
		$("#detailDlg").Modal({
			width : "700",// 模态框宽度
			modal_title : "查看",
			modal_body : $(".${tableName}-viewInfo-dialog").show(),
			modal_type : 1,
			is_close_hidden : 0,
			is_submit_hidden : 0,
			submit_click : function() {
				table.ajax.reload(null, false);
			},
			close_click : function() {
				table.ajax.reload(null, false);
			}
		});
	}

	_pp.alertDlg=function(alertString, type) {
		$("#alertDlg").Modal({
			modal_title : ZnvWeb._resource["scim.vcms.contentmng.tishi"],
			modal_body : alertString,
			prompt_class : type,
			modal_type : 0,
			width : '300',
			close_id : "closesubmit",
			submit_id : "delsubmit",
			is_close_hidden : 0,
			is_submit_hidden : 1,
			close_content : ZnvWeb._resource['res.common.close'],
			submit_content : ZnvWeb._resource['res.common.confirm'],
			submit_click : function() {
			},
			close_click : function() {
			}
		});
	}

	_pp.initDialog = function(form){
           $(form).each(function(){
               $(this).val('');
           });
	}

})(page${tableName});


