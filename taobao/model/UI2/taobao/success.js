define(function(require){
	var $ = require("jquery");
	var justep = require("$UI/system/lib/justep");
	
	var Model = function(){
		this.callParent();
	};
	//完成按钮
	Model.prototype.mainBtnClick = function(event){
		/*
		1、完成按钮点击事件
		2、打开首页
		*/
		justep.Shell.fireEvent("onHomeContent",{});
		justep.Shell.showMainPage();
	};

	return Model;
});