define(function(require) {
	var $ = require("jquery");
	var justep = require("$UI/system/lib/justep");
	var allData = require("./js/loadData");

	var Model = function() {
		this.callParent();
	};
	
	//图片路径转换
	Model.prototype.getImageUrl = function(url){
		return require.toUrl(url);
	};
	
	//获取一级分类信息
	/*
	1、默认显示当前一级菜单对应的二、三级数据
	2、点击其它一级菜单，再加载它的二三级数据
	*/
	Model.prototype.rootClassDataCustomRefresh = function(event){		
		/*
		1、加载一级分类数据
		 */
		var url = require.toUrl("./class/json/rootClassData.json");
		allData.loadDataFromFile(url,event.source,true);       
	};
	//获取二级分类信息	
	Model.prototype.secondClassDataCustomRefresh = function(event){
		/*
		1、加载二级分类数据
		 */
		var url = require.toUrl("./class/json/secondClassData.json");
		allData.loadDataFromFile(url,event.source,true);
	};
	//获取三级分类信息
	Model.prototype.threeClassDataCustomRefresh = function(event){
		/*
		1、加载三级分类数据
		 */
		var url = require.toUrl("./class/json/threeClassData.json");
		allData.loadDataFromFile(url,event.source,true);
	};
	
	//商品点击事件
	Model.prototype.listClick = function(event){
		/*
		 1、获取当前商品ID
		 2、传入弹出窗口，弹出窗口中显示商品详细信息
		 3、在弹出窗口的接收事件中，从服务端过滤数据
		 */
		justep.Shell.showPage("list",{
			keyValue : this.comp("threeClassData").getValue("fClassName")
		});
	};

	return Model;
});