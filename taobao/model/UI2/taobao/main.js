define(function(require) {
	var $ = require("jquery");
	var justep = require("$UI/system/lib/justep");
	var allData = require("./js/loadData");

	var Model = function() {
		this.callParent();
		this.contentName;
		this.tag;
		this.lastContentXid = "homeContent";
	};

	// 图片路径转换
	Model.prototype.getImageUrl = function(url) {
		return require.toUrl(url);
	};
	/*
	 * 写首页图片数据缓存的代码 1、数据模型创建时事件
	 * 2、判断有没有localStorage，如果有显示localStorage中的内容，否则显示静态内容。
	 * 3、从服务端获取最新数据和图片，获取之后，更新界面并写入localStorage
	 */
	Model.prototype.modelModelConstruct = function(event) {
		/*
		 * 1、数据模型创建时事件 2、加载静态图片或从缓存中加载图片
		 */
		var carousel = this.comp("carousel1");

		var fImgUrl = localStorage.getItem("index_BannerImg_src");
		if (fImgUrl == undefined) {
			$(carousel.domNode).find("img").eq(0).attr({
				"src" : "./main/img/carouselBox61.jpg",
				"pagename" : "./detail.w"
			});
		} else {
			var fUrl = localStorage.getItem("index_BannerImg_url");
			$(carousel.domNode).find("img").eq(0).attr({
				"src" : fImgUrl,
				"pagename" : fUrl
			});
		}
	};

	Model.prototype.imgDataCustomRefresh = function(event) {
		/*
		 * 1、加载轮换图片数据
		 * 2、根据data数据动态添加carouse组件中的content页面 
		 * 3、如果img已经创建了，只修改属性
		 * 4、第一张图片信息存入localStorage
		 */
		var url = require.toUrl("./main/json/imgData.json");
		allData.loadDataFromFile(url, event.source, true);
		var me = this;
		var carousel = this.comp("carousel1");
		event.source.each(function(obj) {
			var fImgUrl = require.toUrl(obj.row.val("fImgUrl"));
			var fUrl = require.toUrl(obj.row.val("fUrl"));
			if (me.comp('contentsImg').getLength() > obj.index) {
				$(carousel.domNode).find("img").eq(obj.index).attr({
					"src" : fImgUrl,
					"pagename" : fUrl
				});
				if (obj.index == 0) {
					localStorage.setItem("index_BannerImg_src", fImgUrl);
					localStorage.setItem("index_BannerImg_url", fUrl);
				}
			} else {
				carousel.add('<img src="' + fImgUrl + '" class="tb-img1" bind-click="openPageClick" pagename="' + fUrl + '"/>');
			}
		});
	};

	Model.prototype.goodsDataCustomRefresh = function(event) {
		/*
		 * 1、加载商品数据
		 */
		var url = require.toUrl("./main/json/goodsData.json");
		allData.loadDataFromFile(url, event.source, true);
	};

	// 打开页面
	Model.prototype.openPageClick = function(event) {
		/*
		 * 1、点击组件增加算定义属性：pagename 2、获取自定义属性，打开 对应页面
		 */
		var pageName = event.currentTarget.getAttribute('pagename');
		if (pageName)
			justep.Shell.showPage(require.toUrl(pageName));
	};

	// 进入详细页
	Model.prototype.listClick = function(event) {
		/*
		 * 1、获取当前行 2、进入详细页面，并传值rowid
		 */
		var data = this.comp("goodsData");
		justep.Shell.showPage("detail", {
			goodsID : data.getValue("id"),
			shopID : data.getValue("fShopID")
		});
	};

	// 搜索
	Model.prototype.searchBtnClick = function(event) {
		/*
		 * 1、进入搜索页面
		 */
		justep.Shell.showPage("search");
	};

	// 下划刷新
	Model.prototype.scrollViewPullDown = function(event) {
		/*
		 * 1、滚动视图下拉事件 2、刷新data
		 */
		this.comp("imgData").refreshData();
	};

	Model.prototype.shoppingContentInactive = function(event) {
		/*
		 * 1、购物车页面离开事件 2、获取子页面Model 3、调用子页面的函数showBackBtn，设置返回按钮显否显示
		 */
		var model = this.comp("navContainer4").getInnerModel();
		if (model) {
			model.showBackBtn(false);
		}
	};
	// 添加事件
	Model.prototype.modelLoad = function(event) {
		justep.Shell.on("onRestoreContent", this.onRestoreContent, this);
		justep.Shell.on("onShoppingContent", this.onShoppingContent, this);
		justep.Shell.on("onHomeContent", this.onHomeContent, this);
	};
	// 卸载事件
	Model.prototype.modelUnLoad = function(event) {
		justep.Shell.off("onRestoreContent", this.onRestoreContent);
		justep.Shell.off("onShoppingContent", this.onShoppingContent);
		justep.Shell.off("onHomeContent", this.onHomeContent);
	};
	// 返回上一次的content
	Model.prototype.onRestoreContent = function(event) {
		this.comp("contents2").to(this.lastContentXid);
	};
	// 记住当前content，切换到购物车页
	Model.prototype.onShoppingContent = function(event) {
		this.lastContentXid = this.comp("contents2").getActiveXid();
		this.comp("contents2").to("shoppingContent");
		var shoppingModel = this.comp("navContainer4").getInnerModel();
		if (shoppingModel) {
			shoppingModel.showBackBtn(true);
		}
	};
	// 切换到首页
	Model.prototype.onHomeContent = function(event) {
		this.comp("contents2").to("homeContent");
	};

	Model.prototype.contents2ActiveChange = function(event){
		var to = event.to;
		if (to >= 1) {
			// 优化内存占用
			$('.x-window-container', this.comp('content2').$domNode).css('display', 'none');
			this.comp('navContainer' + (to + 1)).$domNode.css('display', 'block');

			this.comp('navContainer' + (to + 1)).load();
		}

	};

	return Model;
});