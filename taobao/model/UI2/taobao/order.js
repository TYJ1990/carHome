define(function(require){
	var $ = require("jquery");
	var justep = require("$UI/system/lib/justep");
	var allData = require("./js/loadData");
	
	var Model = function(){
		this.callParent();
	};
		
	//图片路径转换
	Model.prototype.getImageUrl = function(url){
		return require.toUrl(url);
	};
		
	//获取商品列表
	Model.prototype.goodsDataCustomRefresh = function(event){
		/*
		1、加载商品数据
		 */
		var url = require.toUrl("./cart/json/goodsData.json");
		allData.loadDataFromFile(url,event.source,true);
	};
	//获取店铺信息
	Model.prototype.shopDataCustomRefresh = function(event){
		/*
		1、加载店铺数据
		 */
		var url = require.toUrl("./cart/json/shopData.json");
		allData.loadDataFromFile(url,event.source,true);
	};
	//获取邮寄信息
	Model.prototype.sendDataCustomRefresh = function(event){
		/*
		1、加载邮寄数据
		 */
		var url = require.toUrl("./cart/json/sendData.json");
		allData.loadDataFromFile(url,event.source,true);
	};
	
	//打开成功页面
	Model.prototype.confirmBtnClick = function(event){
		/*
		1、确认按钮点击事件
		2、打开成功页面
		*/
		justep.Shell.showPage("success");
	};
	
	Model.prototype.sendClick = function(event){
		/*
		1、配送方式按钮点击事件
		2、显示配送列表
		 */
		this.comp("popOver").show();
	};
	
	Model.prototype.sendLiClick = function(event){
		/*
		1、配送列表点击事件
		2、选中配送方式，关闭配送列表
		*/
		this.comp("sendData").setValue("fState",0);
		var row = event.bindingContext.$object; 
		row.val("fState",1);
		var title=row.val("fSendName")+" "+row.val("fCost");		
		$("span[xid=sendTitle]", this.getRootNode()).text(title);
		this.comp("popOver").hide();
	};
	
	return Model;
});