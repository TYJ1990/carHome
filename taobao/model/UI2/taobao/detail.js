define(function(require) {
	var $ = require("jquery");
	var justep = require("$UI/system/lib/justep");	
	var allData = require("./js/loadData");	
	require("cordova!cordova-plugin-device");
	require("cordova!com.justep.cordova.plugin.weixin.v3");

	var Model = function() {
		this.callParent();
		this.goodsID="";
		this.shopID="";
	};
	
	//返回上一页
	Model.prototype.backBtnClick = function(event){
		justep.Shell.closePage();
	};
	
	//接收
	Model.prototype.modelParamsReceive = function(event){
		/*
		1、参数接收事件
		2、根据参数从服务端过滤数据
		*/
		if (this.params && this.params.shopID) {
			this.shopID = this.params.shopID;
			this.goodsID = this.params.goodsID;
		}
	};	
	
	//获取轮换图片
	Model.prototype.imgDataCustomRefresh = function(event){
		/*
		1、加载轮换图片数据
		2、根据goodsID过滤数据
		3、修改对应图片的src
		*/		
		var url = require.toUrl("./detail/json/imgData.json");
		allData.loadDataFromFile(url,event.source,true);
		
        var carousel=this.comp("carousel1");        
        event.source.each(function(obj){			
			var fImgUrl=require.toUrl(obj.row.val("fImgUrl"));
			if( obj.index==0){
				$(carousel.domNode).find("img").eq(0).attr({"src":fImgUrl});
			} else {
				carousel.add('<img src="'+fImgUrl+'" class="image-wall tb-img"/>');
			}
		});
	};
	
	//获取商品信息
	Model.prototype.goodsDataCustomRefresh = function(event){
		/*
		1、加载商品数据
		2、根据goodsID过滤数据
		*/				
		var url = require.toUrl("./detail/json/goodsData.json");
		allData.loadDataFromFile(url,event.source,true);
	};
	
	//获取店铺信息
	Model.prototype.shopDataCustomRefresh = function(event){
		/*
		1、加载店铺数据
		2、根据shopID过滤数据
		 */
        var url = require.toUrl("./detail/json/shopData.json");
        allData.loadDataFromFile(url,event.source,true);       
	};
	
	//获取参数信息
	Model.prototype.parameterDataCustomRefresh = function(event){
		/*
		1、加载参数数据
		2、根据goodsID过滤数据
		 */
        var url = require.toUrl("./detail/json/parameterData.json");
        allData.loadDataFromFile(url,event.source,true);       
	};
	
	//获取评论信息
	Model.prototype.commentsDataCustomRefresh = function(event){
		/*
		1、加载评论数据
		2、根据goodsID过滤数据
		 */
		var url = require.toUrl("./detail/json/commentsData.json");
        allData.loadDataFromFile(url,event.source,true);
	};
	
	//更多评论按钮
	Model.prototype.moreBtnClick = function(event){
		/*
		1、获取当前商品ID
		2、传入新窗口，打开的窗口中显示评论列表
		3、在打开的窗口中接收数据，并从服务端过滤数据		
		*/
	};
	
	//购物车按钮
	Model.prototype.shoppingCartBtnClick = function(event){
		/*
		1、切换到购物车页面
		*/
		justep.Shell.fireEvent("onShoppingContent",{});
		justep.Shell.showMainPage();
	};
	//加入购物车
	Model.prototype.joinCartBtnClick = function(event){
		/*
		1、弹出商品尺码颜色选择框
		2、点击确定后购物车中增加一条相应数据
		*/
		this.comp("stateData").setValue("state",0);
		this.comp("popOver").show();
	};
	
	//购买按钮
	Model.prototype.buyBtnClick = function(event){
		/*
		1、获取当前商品ID
		2、传入新窗口，打开的窗口中显示购买确认页面
		3、在打开的窗口中接收数据，并从服务端过滤数据
		*/
		this.comp("stateData").setValue("state","0");
		this.comp("popOver").show();
	};
	
	//查看宝贝分类按钮
	Model.prototype.classBtnClick = function(event){
		/*
		1、获取当前商铺ID
		2、传入新窗口，打开的窗口中显示商铺分类
		3、在打开的窗口中接收数据，并从服务端过滤数据
		*/
	};
	
	//进店逛逛按钮
	Model.prototype.storeBtnClick = function(event){
		/*
		1、获取当前商铺ID
		2、传入新窗口，打开的窗口中显示店铺主页面
		3、在打开的窗口中接收数据，并从服务端过滤数据
		*/
	};
	
	//全部宝贝按钮
	Model.prototype.goodsBtnClick = function(event){
		/*
		1、获取当前店铺ID
		2、传入新窗口，打开的窗口中显示商品列表
		3、在打开的窗口中接收数据，并从服务端过滤数据
		*/
	};
	
	//分享按钮
	Model.prototype.shareBtnClick = function(event){
		/*
		1、获取商品ID 
		2、打开分享页面
        3、参数说明 
            thumb：缩略图，可以显示商品图片，注意不能大于32kb，链接从http开始
			webpageUrl: 分享链接，使用location.href显示当前页面，链接从http开始
			scene:分享到微信朋友圈、微信朋友、微信群 
				weixin.Scene.TIMELINE 是分享到微信朋友圈
		 		weixin.Scene.SESSION 是分享给微信朋友、微信群
		*/
		if (!navigator.weixin) {
			return;
		}
		var weixin = navigator.weixin;
		var Utils = require("$UI/system/components/justep/common/utils");		
		weixin.share({
			message : {
				title : this.comp("goodsData").val("fTitle"),
				description : "",
				mediaTagName : "",
				thumb : location.origin + require.toUrl("./detail/img/icon.png"),
				media : {
					type : weixin.Type.WEBPAGE,
					webpageUrl : Utils.getShareUrl()
				}
			},
			scene : weixin.Scene.TIMELINE
		}, function() {
			// alert("Success");
		}, function(reason) {
			// alert("Failed: " + reason);
		});
			
	};
	
	//颜色选择弹出窗显示
	Model.prototype.popOverClick = function(event){		
		this.comp("stateData").setValue("state", 1);
		this.comp("popOver").show();
	};
	
	//颜色状态修改
	Model.prototype.colorLiClick = function(event){
		/*
		1、颜色选择点击事件
		2、修改当前颜色状态
		*/
		var colorData=this.comp("colorData");
		var row=colorData.getCurrentRow();		
		colorData.setValue("fState", "0", colorData.find(["fState"],["1"],true,true,true)[0]);
		colorData.setValue("fState", "1",row);
	};	

	return Model;
});