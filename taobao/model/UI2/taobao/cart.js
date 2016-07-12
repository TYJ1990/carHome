define(function(require) {
	var $ = require("jquery");
	var justep = require("$UI/system/lib/justep");
	var allData = require("./js/loadData");

	var Model = function() {
		this.callParent();
		this.isBack;	
	};
	
	//返回上一页
	Model.prototype.backBtnClick = function(event){
		justep.Shell.closePage();
		setTimeout(function(){
			justep.Shell.fireEvent("onRestoreContent", {});
		},500);
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
	//全选
	Model.prototype.allChooseChange = function(event){
		/*
		1、全选多选框绑定变化事件onChange()
		2、点击全选多选框按钮，获取其值
		3、修改商品表中的fChoose字段为全选多选框按钮的值
		*/
		var goodsData = this.comp("goodsData");
		var choose=this.comp("allChoose").val();
		goodsData.each(function(obj){
			if(choose){				
				goodsData.setValue("fChoose","1",obj.row);
			} else {
				goodsData.setValue("fChoose","",obj.row);
			}	
		});
	};
	
	//减数量
	Model.prototype.reductionBtnClick = function(event){		
		/*
		1、减少数量按钮绑定点击事件onClick()
		2、点击按钮，当前记录的fNumber值减1
		3、fNumber为1时不再相减
		*/
		var row = event.bindingContext.$object;
		var n=row.val("fNumber");
		if(n>1){
			row.val("fNumber",n-1);
		}
	};
	
	//加数量
	Model.prototype.addBtnClick = function(event){
		/*
		1、增加数量按钮绑定点击事件onClick()
		2、点击按钮，当前记录的fNumber值加1
		*/
		var row = event.bindingContext.$object;
		var n=row.val("fNumber");
		row.val("fNumber",n+1);
	};
	
	//删除
	Model.prototype.delBtnClick = function(event){
		/*
		1、删除按钮点击事件
		2、删除选中商品
		3、如果商店里已经没有商品，则删除商店
		*/
		var goodsData = this.comp("goodsData");
		var goodsRows = goodsData.find(["fChoose"],["1"]);
		goodsData.deleteData(goodsRows);
  
		var shopData = this.comp("shopData");
		var shopRows = new Array();
		shopData.each(function(obj){
			var n = goodsData.find(["fShopID"],[obj.row.val("id")]).length; 
			if(n == 0){
				shopRows.push(obj.row);
			}
		});    
		shopData.deleteData(shopRows);  
	};
	
	Model.prototype.showBackBtn = function(isBack){
		/*
		1、根据参数修改calculateData
		 */		
		this.isBack = isBack;
		var v = isBack ? 1 : 0;
		this.comp("calculateData").setValue("isBack",v);		
	};
	
	//结算事件
	Model.prototype.settlementClick = function(event){
		/*
		1、结算按钮点击事件
		2、打开订单确认页面
		3、点击确认按钮，选择支付方式
		4、进入支付成功页面
		*/		
		justep.Shell.showPage("order");
	};

	Model.prototype.listClick = function(event){
		/*
		 1、获取当前商品ID
		 2、传入弹出窗口，弹出窗口中显示商品详细信息
		 3、在弹出窗口的接收事件中，从服务端过滤数据
		*/
		var data=this.comp("goodsData");
		justep.Shell.showPage("detail", {
			goodsID : data.getValue("id"),
			shopID : data.getValue("fShopID")
		});
	};

	return Model;
});