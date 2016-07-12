<?xml version="1.0" encoding="utf-8"?>

<div xmlns="http://www.w3.org/1999/xhtml" class="main13" component="$UI/system/components/justep/window/window"
  design="device:mobile;" xid="window">  
  <div component="$UI/system/components/justep/model/model" xid="model" style="height:auto;left:351px;top:42px;"
    onParamsReceive="modelParamsReceive"> 
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="imgData" idColumn="id" onCustomRefresh="imgDataCustomRefresh"> 
      <column label="id" name="id" type="String" xid="xid2"/>  
      <column label="图片" name="fImgUrl" type="String" xid="xid1"/> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="commentsData" idColumn="id" onCustomRefresh="commentsDataCustomRefresh"> 
      <column label="id" name="id" type="String" xid="xid3"/>  
      <column label="用户名" name="fUserName" type="String" xid="xid4"/>  
      <column label="用户头像" name="fUserImg" type="String" xid="xid7"/>  
      <column label="评分" name="fScore" type="Float" xid="xid5"/>  
      <column label="评论内容" name="fContent" type="String" xid="xid6"/>  
      <column label="评论日期" name="fDate" type="Date" xid="xid8"/> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="goodsData" idColumn="id" onCustomRefresh="goodsDataCustomRefresh"> 
      <column label="id" name="id" type="String" xid="column1"/>  
      <column label="标题" name="fTitle" type="String" xid="column2"/>  
      <column label="图片" name="fImg" type="String" xid="column3"/>  
      <column label="价格" name="fPrice" type="Float" xid="column4"/>  
      <column label="原价格" name="fOldPrice" type="Float" xid="column5"/>  
      <column label="邮费" name="fPostage" type="String" xid="column6"/>  
      <column label="买出数量" name="fRecord" type="Integer" xid="column7"/>  
      <column label="所在地区" name="fAddress" type="String" xid="column8"/>  
      <column label="详情" name="fDetail" type="String" xid="xid17"/>  
      <column label="评价数量" name="fCommentsNumber" type="String" xid="xid24"/>  
      <rule xid="rule1"> 
        <col name="fCommentsNumber" xid="ruleCol1"> 
          <calculate xid="calculate1"> 
            <expr xid="default3">$model.commentsData.count()</expr> 
          </calculate> 
        </col> 
      </rule> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="shopData" idColumn="id" onCustomRefresh="shopDataCustomRefresh"> 
      <column name="id" type="String" xid="xid9"/>  
      <column label="店名" name="fShopName" type="String" xid="xid10"/>  
      <column label="等级" name="fLevel" type="Integer" xid="xid11"/>  
      <column label="店标" name="fShopImg" type="String" xid="xid16"/>  
      <column label="描述相符" name="fConsistent" type="Float" xid="xid12"/>  
      <column label="服务态度" name="fService" type="Float" xid="xid13"/>  
      <column label="商品数量" name="fGoodsNumber" type="Integer" xid="xid14"/>  
      <column label="关注人数" name="fFocusNumber" type="Integer" xid="xid15"/> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="parameterData" idColumn="id" onCustomRefresh="parameterDataCustomRefresh"> 
      <column name="id" type="String" xid="xid19"/>  
      <column label="商品ID" name="fGoodsID" type="String" xid="xid20"/>  
      <column label="参数名" name="fName" type="String" xid="xid20"/>  
      <column label="参数" name="fParameter" type="String" xid="xid21"/> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="colorData" idColumn="id"> 
      <column label="id" name="id" type="String" xid="xid18"/>  
      <column label="商品ID" name="fGoodID" type="String" xid="xid22"/>  
      <column label="颜色" name="fColor" type="String" xid="xid23"/>  
      <column label="状态" name="fState" type="Integer" xid="xid25"/>  
      <data xid="default2">[{"id":"1","fGoodID":"1","fColor":"草绿（12支/盒）","fState":0},{"id":"2","fGoodID":"1","fColor":"橙色（12支/盒）","fState":0},{"id":"3","fGoodID":"1","fColor":"蓝色（12支/盒）","fState":0},{"id":"4","fGoodID":"1","fColor":"粉红（12支/盒）","fState":0},{"id":"5","fGoodID":"1","fColor":"黑色（12支/盒）","fState":0},{"id":"6","fGoodID":"1","fColor":"红色（12支/盒）","fState":0},{"id":"7","fGoodID":"1","fColor":"黄色（12支/盒）","fState":0},{"id":"8","fGoodID":"1","fColor":"绿色（12支/盒）","fState":0},{"id":"9","fGoodID":"1","fColor":"墨蓝（12支/盒）","fState":0},{"id":"10","fGoodID":"1","fColor":"天蓝（12支/盒）","fState":0},{"id":"11","fGoodID":"1","fColor":"紫色（12支/盒）","fState":0},{"id":"12","fGoodID":"1","fColor":"棕色（12支/盒）","fState":0},{"id":"13","fGoodID":"1","fColor":"12色混装（12支/盒）","fState":0}]</data>
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="stateData" idColumn="state">
      <column label="显示状态" name="state" type="Integer" xid="xid26"></column>
  <data xid="default4">[{&quot;state&quot;:0}]</data></div>
  </div>  
  <div component="$UI/system/components/justep/popOver/popOver" class="x-popOver"
    xid="popOver" position="bottom"> 
    <div class="x-popOver-overlay" xid="div2"/>  
    <div class="x-popOver-content" xid="div3"> 
      <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-icon pull-right tb-close text-black"
        icon="icon-ios7-close-outline" onClick="{operation:'popOver.hide'}"> 
        <i xid="i17" class="icon-ios7-close-outline"/>  
        <span xid="span35"/> 
      </a>  
      <img src="$UI/demo/taobao/detail/img/pic1.png" alt="" class="img-thumbnail tb-colorImg"/>  
      <div class="tb-title"> 
        <span class="text-danger h4"><![CDATA[￥]]></span>  
        <span bind-text="goodsData.ref('fPrice')" class="text-danger h4"><![CDATA[]]></span>  
        <div xid="div7"/>  
        <span><![CDATA[库存]]></span>  
        <span bind-text="goodsData.ref('fRecord')"/>  
        <span xid="span47"><![CDATA[件]]></span>  
        <h5 xid="h52" class="text-black"><![CDATA[请选择颜色分类]]></h5> 
      </div>  
      <div class="panel-body"> 
        <h4 class="text-black"><![CDATA[颜色分类]]> </h4>  
        <div component="$UI/system/components/justep/list/list" class="x-list tb-colorList"
          xid="colorList" data="colorData" bind-click="colorLiClick" dataItemAlias="colorRow"> 
          <ul class="x-list-template" xid="ul2" componentname="ul(html)" id="undefined_ul2"> 
            <li xid="li2" class="col col-xs-6" componentname="li(html)" id="undefined_li2"> 
              <div class="text-center" bind-css="{'current':colorRow.val('fState')==1}"> 
                <span bind-text="ref('fColor')"/> 
              </div> 
            </li> 
          </ul> 
        </div>  
        <div class="clearfix"/> 
      </div>  
      <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-label btn-block tb-colorOk"
        label="确定" onClick="{operation:'popOver.hide'}" bind-visible='$model.stateData.val("state")==0'> 
        <i xid="i18"/>  
        <span xid="span50">确定</span> 
      </a>  
      <div component="$UI/system/components/justep/button/buttonGroup" class="btn-group btn-group-justified tb-shopping"
        tabbed="true" xid="buttonGroup4" bind-visible='$model.stateData.val("state")==1'>
        <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-label"
          label="加入购物车"> 
          <i xid="i16"/>  
          <span xid="span34">加入购物车</span>
        </a>  
        <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-label"
          label="立即购买"> 
          <i xid="i19"/>  
          <span xid="span37">立即购买</span>
        </a>
      </div>
    </div> 
  </div>  
  <div component="$UI/system/components/justep/panel/panel" class="x-panel x-full x-card tb-trans x-has-iosstatu"> 
    <div class="x-panel-top" xid="top1"><div component="$UI/system/components/justep/titleBar/titleBar" class="x-titlebar tb-box" xid="titleBar">
   <div class="x-titlebar-left" xid="left1"><a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-icon tb-backBtn" xid="backBtn" icon="icon-chevron-left" onClick="backBtnClick"> 
          <i xid="i6" class="icon-chevron-left" />  
          <span xid="span6">关闭</span> 
        </a></div>
   <div class="x-titlebar-title" xid="title1"><a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-icon tb-cartBtn pull-right" xid="cartBtn" icon="icon-ios7-cart" onClick="shoppingCartBtnClick">
   <i xid="i12" class="icon-ios7-cart"></i>
   <span xid="span4"></span></a></div>
   <div class="x-titlebar-right reverse" xid="right1"><a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-icon tb-moreBtn pull-right" xid="moreBtn" icon="icon-android-more">
   <i xid="i13" class="icon-android-more"></i>
   <span xid="span23"></span></a>
  </div></div></div><div class="x-panel-content x-cards tb-trans"> 
        
      <div component="$UI/system/components/bootstrap/carousel/carousel" class="x-carousel carousel"
        xid="carousel1" auto="false" style="height:251px;"> 
        <ol class="carousel-indicators" xid="default1"/>  
        <div class="x-contents carousel-inner" role="listbox" component="$UI/system/components/justep/contents/contents"
          active="0" slidable="true" wrap="true" swipe="true" xid="contents1" routable="false"> 
          <div class="x-contents-content" xid="content1"> 
            <img src="" alt="" xid="image1" class="image-wall tb-img"/> 
          </div> 
        </div> 
      </div>  
      <div component="$UI/system/components/justep/panel/panel" class="panel panel-default x-card panel-body"> 
        <div component="$UI/system/components/bootstrap/row/row" class="row tb-nopadding"> 
          <div class="col col-xs-10  tb-nopadding" xid="col8"> 
            <h4 xid="h41" class=" text-black" bind-text="goodsData.ref('fTitle')"><![CDATA[]]></h4>  
            <div xid="div4"> 
              <span xid="span17" class="text-danger h3"><![CDATA[￥]]></span>  
              <span xid="span29" bind-text="goodsData.ref('fPrice')" class="text-danger h3"/> 
            </div>  
            <div xid="div5" class="text-muted"> 
              <span xid="span19"><![CDATA[价格：]]></span>  
              <span xid="span18" class="tb-text-del">￥</span>  
              <span xid="span13" bind-text="goodsData.ref('fOldPrice')" class="tb-text-del"/> 
            </div> 
          </div>  
          <div class="col col-xs-2  tb-nopadding" xid="col9"> 
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-icon-top pull-right tb-nopadding"
              label="分享" xid="shareBtn" icon="icon-android-share" onClick="shareBtnClick"> 
              <i xid="i10" class="text-success icon-android-share"/>  
              <span xid="span10" class="text-success">分享</span> 
            </a> 
          </div> 
        </div>  
        <div component="$UI/system/components/bootstrap/row/row" class="row text-muted h5 tb-nopadding"> 
          <div class="col col-xs-4  tb-nopadding" xid="col11"> 
            <span xid="span14">快递</span>  
            <span xid="span15" bind-text="goodsData.ref('fPostage')"/> 
          </div>  
          <div class="col col-xs-4 text-center" xid="col12"> 
            <span xid="span24">月销</span>  
            <span xid="span26" bind-text="goodsData.ref('fRecord')"/>  
            <span xid="span27">笔</span> 
          </div>  
          <div class="col col-xs-4 text-center" xid="col13"> 
            <span xid="span16" bind-text="goodsData.ref('fAddress')"/> 
          </div> 
        </div> 
      </div>  
      <div component="$UI/system/components/justep/panel/panel" class="panel panel-heading x-card"
        bind-click="popOverClick"> 
        <i xid="i4" class="text-muted icon-chevron-right pull-right btn-sm"/>  
        <span xid="span20">选择颜色分类</span> 
      </div>  
      <div component="$UI/system/components/justep/panel/panel" class="panel panel-default x-card"> 
        <div class="panel-body"> 
          <div class="h5 text-black"> 
            <span xid="span22">宝贝评价（</span>  
            <span xid="span25" bind-text="goodsData.ref('fCommentsNumber')"/>  
            <span xid="span28">）</span> 
          </div>  
          <div class="media-left"> 
            <img src="" alt="" xid="image3" class="img-circle" bind-attr-src="commentsData.ref('fUserImg')"
              height="40px" style="width:40px;"/> 
          </div>  
          <div class="media-body"> 
            <span xid="span30" bind-text="commentsData.ref('fUserName')"/> 
          </div>  
          <div> 
            <span xid="span32" bind-text="commentsData.ref('fContent')"/> 
          </div>  
          <div class="text-muted"> 
            <span xid="span36" bind-text="commentsData.ref('fDate')"/> 
          </div>  
          <div component="$UI/system/components/justep/button/buttonGroup"
            class="btn-group btn-group-justified" tabbed="true" xid="buttonGroup3"> 
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-label text-black"
              label="查看更多评论" xid="button4"> 
              <i xid="i11"/>  
              <span xid="span5">查看更多评论</span> 
            </a> 
          </div> 
        </div> 
      </div>  
      <div component="$UI/system/components/justep/panel/panel" class="panel panel-default x-card"> 
        <div xid="div9" class="panel-body tb-nopadding"> 
          <div class="panel-body media"> 
            <div class="media-left"> 
              <img src="" alt="" xid="image4" class="img-rounded" bind-attr-src="shopData.ref('fShopImg')"
                height="50px" style="width:50px;"/> 
            </div>  
            <div class="media-body"> 
              <span xid="span46" bind-text="shopData.ref('fShopName')" class="show"/>  
              <span xid="span48" bind-text="shopData.ref('fLevel')"><![CDATA[]]></span> 
            </div> 
          </div>  
          <div component="$UI/system/components/bootstrap/row/row" class="row"> 
            <div class="col col-xs-5" xid="col17"> 
              <span class="text-muted" xid="span9">描述相符</span>  
              <span bind-text="shopData.ref('fConsistent')" class="text-danger"
                xid="span11"/> 
            </div>  
            <div class="col col-xs-7" xid="col18"> 
              <span class="text-muted" xid="span12">服务态度</span>  
              <span bind-text="shopData.ref('fService')" class="text-success"
                xid="span21"/> 
            </div> 
          </div> 
        </div>  
        <div component="$UI/system/components/bootstrap/row/row" class="row"> 
          <div class="col col-xs-6 tb-line" xid="col1"> 
            <span xid="span41" bind-text="shopData.ref('fGoodsNumber')" class="show text-center"/>  
            <span xid="goodsBtn" class="show text-center text-muted" bind-click="goodsBtnClick">全部宝贝</span> 
          </div>  
          <div class="col col-xs-6" xid="col2"> 
            <span xid="span44" bind-text="shopData.ref('fFocusNumber')" class="show text-center"/>  
            <span xid="span43" class="show text-center text-muted">关注人数</span> 
          </div> 
        </div>  
        <div component="$UI/system/components/bootstrap/row/row" class="row panel-body"> 
          <div class="col col-xs-6" xid="col4"> 
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-icon-left btn-block thumbnail text-black"
              label="查看宝贝分类" xid="classBtn" icon="icon-navicon" onClick="classBtnClick"> 
              <i xid="i9" class="icon-navicon"/>  
              <span xid="span40">查看宝贝分类</span> 
            </a> 
          </div>  
          <div class="col col-xs-6" xid="col5"> 
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-icon-left btn-block thumbnail text-black"
              label="进店逛逛" xid="storeBtn" icon="icon-bag" onClick="storeBtnClick"> 
              <i xid="i5" class="icon-bag"/>  
              <span xid="span39">进店逛逛</span> 
            </a> 
          </div> 
        </div> 
      </div>  
      <div component="$UI/system/components/justep/panel/panel" class="panel x-card"> 
        <div component="$UI/system/components/justep/button/buttonGroup" class="btn-group btn-group-justified tb-tabs"
          tabbed="true"> 
          <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-label active"
            label="图文详情" xid="detailsBtn" target="detailsContent"> 
            <i xid="i14"/>  
            <span xid="span31">图文详情</span> 
          </a>  
          <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-label"
            label="产品参数" xid="parameterBtn" target="parameterContent"> 
            <i xid="i15"/>  
            <span xid="span33">产品参数</span> 
          </a> 
        </div>  
        <div component="$UI/system/components/justep/contents/contents" class="x-contents"
          active="0"> 
          <div class="x-contents-content panel-body" xid="detailsContent"> 
            <div bind-html="$model.goodsData.val(&quot;fDetail&quot;)"/> 
          </div>  
          <div class="x-contents-content panel-body" xid="parameterContent"> 
            <div component="$UI/system/components/justep/list/list" class="x-list x-cards"
              xid="list1" data="parameterData"> 
              <ul class="x-list-template" xid="ul1" componentname="ul(html)"
                id="undefined_ul1"> 
                <li xid="li1" componentname="li(html)" id="undefined_li1"
                  class="list-group-item"> 
                  <span bind-text="ref('fName')" class="col col-xs-4 tb-nopadding text-muted"/>  
                  <span bind-text="ref('fParameter')" class="x-flex col col-xs-8 tb-nopadding"/>  
                  <div class="clearfix"/>
                </li> 
              </ul> 
            </div> 
          </div> 
        </div> 
      </div> 
    </div>  
    <div class="x-panel-bottom" xid="bottom1"> 
      <div component="$UI/system/components/bootstrap/row/row" class="row"> 
        <div class="col col-xs-5 tb-nopadding" xid="col3"> 
          <div component="$UI/system/components/justep/button/buttonGroup"
            class="btn-group btn-group-justified" tabbed="true" xid="buttonGroup1"> 
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-icon-top"
              label="客服" xid="button1" icon="icon-ios7-chatboxes-outline"> 
              <i xid="i1" class="icon icon-ios7-chatboxes-outline"/>  
              <span xid="span1">客服</span> 
            </a>  
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-icon-top"
              label="店铺" xid="button2" icon="icon-bag"> 
              <i xid="i2" class="icon icon-bag"/>  
              <span xid="span2">店铺</span> 
            </a>  
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-icon-top"
              label="收藏" xid="button3" icon="icon-ios7-star-outline"> 
              <i xid="i3" class="icon icon-ios7-star-outline"/>  
              <span xid="span3">收藏</span> 
            </a> 
          </div> 
        </div>  
        <div class="col col-xs-7 tb-nopadding" xid="col6"> 
          <div component="$UI/system/components/justep/button/buttonGroup"
            class="btn-group btn-group-justified tb-shopping" tabbed="true" xid="buttonGroup2"> 
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-label"
              label="加入购物车" xid="joinCartBtn" icon="icon-radio-waves" onClick="joinCartBtnClick"> 
              <i xid="i8" class="icon-radio-waves icon"/>  
              <span xid="span7">加入购物车</span> 
            </a>  
            <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-label"
              label="立即购买" xid="buyBtn" icon="icon-android-display" onClick="buyBtnClick"> 
              <i xid="i7" class="icon-android-display icon"/>  
              <span xid="span8">立即购买</span> 
            </a> 
          </div> 
        </div> 
      </div> 
    </div> 
  </div> 
</div>
