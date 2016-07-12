define(function(require){
	var $ = require("jquery");
	var justep = require("$UI/system/lib/justep");
	
	var Model = function(){
		this.callParent();
	};
	
	//图片路径转换
	Model.prototype.getImageUrl = function(url){
		/*
		1、返回转换后的url
		 */
		return require.toUrl(url);
	};
	
	Model.prototype.searchKeyDataCustomRefresh = function(event){
		/*
		1、加载数据
		2、从localStorage缓存中加载数据
		*/
		var searchKeyData=event.source;
		try{
		   var data =  JSON.parse(localStorage.getItem("search_input_keys"));
		   searchKeyData.loadData(data);
		  }catch(e){
		   localStorage.removeItem("search_input_keys");
		}		
	};
	
	//搜索框	
	Model.prototype.keyInputFocus = function(event){
		/*
		1、搜索框获取焦点事件
		2、显示词库列表
		*/
		this.comp("keyInput").val("");
	};
		
	//搜索按钮单击事件
	Model.prototype.searchBtnClick = function(event){
		/*
		1、获取搜索框值
		2、存入data和缓存
		3、打开 页面并传参
		*/

		var searchKeyData = this.comp("searchKeyData");
		var text=this.comp("keyInput").val();
		if(text.length>0 && searchKeyData.find(["key"],[text]).length==0){		
			var options = {
					defaultValues : [ {
						key : this.comp("keyInput").val()
					} ]
			};
			searchKeyData.newData(options);
			localStorage.setItem("search_input_keys",JSON.stringify(searchKeyData.toJson(true)));
		}
		
		justep.Shell.showPage("list",{
			keyValue : this.comp("keyInput").val()
		});
	};	
	
	//打开列表页
	Model.prototype.liClick = function(event){
		/*
		1、列表点击事件
		2、打开列表页并传参数
		*/
		var searchKeyData=this.comp("searchKeyData");
		justep.Shell.showPage("list",{
			keyValue : searchKeyData.getValue("key")
		});
	};
	
	//清空历史记录
	Model.prototype.clearBtnClick = function(event){
		localStorage.clear();
		this.comp("searchKeyData").clear();
	};	
		
	return Model;
});