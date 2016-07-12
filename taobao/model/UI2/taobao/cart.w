<?xml version="1.0" encoding="utf-8"?>

<div xmlns="http://www.w3.org/1999/xhtml" class="main13" component="$UI/system/components/justep/window/window"
  design="device:mobile;" xid="window">  
  <div component="$UI/system/components/justep/model/model" xid="model" style="height:auto;left:135px;top:10px;"> 
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="goodsData" idColumn="id" limit="20" confirmRefresh="false" confirmDelete="false"
      onCustomRefresh="goodsDataCustomRefresh"> 
      <column label="id" name="id" type="String" xid="column1"/>  
      <column label="店铺ID" name="fShopID" type="String" xid="xid1"/>  
      <column label="标题" name="fTitle" type="String" xid="column2"/>  
      <column label="图片" name="fImg" type="String" xid="column3"/>  
      <column label="价格" name="fPrice" type="Float" xid="column4"/>  
      <column label="原价格" name="fOldPrice" type="Float" xid="column5"/>  
      <column label="邮费" name="fPostage" type="String" xid="column6"/>  
      <column label="买出数量" name="fRecord" type="Integer" xid="column7"/>  
      <column label="所在地区" name="fAddress" type="String" xid="column8"/>  
      <column label="颜色" name="fColor" type="String" xid="xid2"/>  
      <column label="尺寸" name="fSize" type="String" xid="xid3"/>  
      <column label="选择" name="fChoose" type="Integer" xid="xid4"/>  
      <column label="数量" name="fNumber" type="Integer" xid="xid5"/>  
      <column label="总价" name="fSum" type="Float" xid="xid6"/>  
      <rule xid="rule1"> 
        <col name="fColor" xid="ruleCol1"> 
          <constraint xid="constraint1"> 
            <expr xid="default1"/> 
          </constraint>  
          <calculate xid="calculate1"> 
            <expr xid="default2"/> 
          </calculate>  
          <readonly xid="readonly1"> 
            <expr xid="default6"/> 
          </readonly> 
        </col>  
        <col name="fSize" xid="ruleCol2"> 
          <calculate xid="calculate2"> 
            <expr xid="default3"/> 
          </calculate> 
        </col>  
        <col name="fSum" xid="ruleCol3"> 
          <calculate xid="calculate3"> 
            <expr xid="default4">$row.val('fChoose')==1?$row.val('fPrice')*$row.val('fNumber'):'0'</expr> 
          </calculate> 
        </col>  
        <col name="fNumber" xid="ruleCol4"> 
          <calculate xid="calculate4"> 
            <expr xid="default5"/> 
          </calculate> 
        </col> 
      </rule> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="shopData" idColumn="id" confirmDelete="false" confirmRefresh="false" onCustomRefresh="shopDataCustomRefresh"> 
      <column label="id" name="id" type="String" xid="xid9"/>  
      <column label="店名" name="fShopName" type="String" xid="xid10"/>  
      <column label="等级" name="fLevel" type="Integer" xid="xid11"/>  
      <column label="店标" name="fShopImg" type="String" xid="xid16"/>  
      <column label="描述相符" name="fConsistent" type="Float" xid="xid12"/>  
      <column label="服务态度" name="fService" type="Float" xid="xid13"/>  
      <column label="商品数量" name="fGoodsNumber" type="Integer" xid="xid14"/>  
      <column label="关注人数" name="fFocusNumber" type="Integer" xid="xid15"/> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="calculateData" idColumn="allSum"> 
      <column label="合计" name="allSum" type="String" xid="xid7"></column>
  <column label="总数量" name="allNumber" type="String" xid="xid8"></column>
  <rule xid="rule2">
   <col name="allSum" xid="ruleCol5">
    <calculate xid="calculate5">
     <expr xid="default7">$model.goodsData.sum('fSum')</expr></calculate> </col> 
   <col name="allNumber" xid="ruleCol6">
    <calculate xid="calculate6">
     <expr xid="default9">$model.goodsData.sum('fChoose')</expr></calculate> </col> </rule>
  <column label="是否返回" name="isBack" type="Integer" xid="xid17"></column>
  <data xid="default8">[{&quot;allSum&quot;:&quot;0&quot;,&quot;isBack&quot;:0}]</data></div> 
  </div>  
  <div component="$UI/system/components/justep/panel/panel" class="x-panel x-full x-card x-has-iosstatusbar"> 
    <div class="x-panel-top" height="48"> 
      <div component="$UI/system/components/justep/titleBar/titleBar" class="x-titlebar"> 
        <div class="x-titlebar-left"><a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-icon" label="button" xid="backBtn" icon="icon-chevron-left" bind-visible='$model.calculateData.val("isBack")==1' onClick="backBtnClick">
   <i xid="i1" class="icon-chevron-left"></i>
   <span xid="span3"></span></a></div>  
        <div class="x-titlebar-title"> 
          <span xid="span1"><![CDATA[购物车（]]></span>  
          <span xid="span11" bind-text="goodsData.count()"/>  
          <span xid="span2"><![CDATA[）]]></span> 
        </div>  
        <div class="x-titlebar-right reverse"> 
          <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-icon"
            label="button" xid="delBtn" icon="icon-ios7-trash-outline" onClick="delBtnClick"> 
            <i xid="i4" class="icon-ios7-trash-outline"/>  
            <span xid="span20"/> 
          </a> 
        </div> 
      </div> 
    </div>  
    <div xid="content" class="x-panel-content x-scroll-view x-cards" supportpulldown="true"> 
      <div class="x-scroll" component="$UI/system/components/justep/scrollView/scrollView"
        xid="scrollView" pullUpLabel=" "> 
        <div class="x-content-center x-pull-down container" xid="div8"> 
          <i class="x-pull-down-img glyphicon x-icon-pull-down" xid="i2"/>  
          <span class="x-pull-down-label" xid="span9">下拉刷新...</span>
        </div>  
        <div class="x-scroll-content" xid="div7"> 
          <div component="$UI/system/components/justep/list/list" class="x-list"
            data="shopData" limit="-1" xid="shopList" disablePullToRefresh="true" disableInfiniteLoad="true"
            autoLoad="true" dataItemAlias="shopRow"> 
            <ul class="x-list-template x-min-height" xid="listTemplateUl1"
              componentname="$UI/system/components/justep/list/list#listTemplateUl"
              id="undefined_listTemplateUl1"> 
              <li xid="li1" class="panel panel-default x-card tb-box"> 
                <div class="panel-heading">
                  <i xid="i5" class="icon-chevron-right"/> 
                  <img src="" alt="" xid="image3" bind-attr-src="$model.getImageUrl(val(&quot;fShopImg&quot;))"
                    class="img-circle tb-img-shop"/> 
                  <span xid="span4" bind-text="ref('fShopName')"/>
                </div>  
                <div component="$UI/system/components/justep/list/list" class="x-list bg-white"
                  data="goodsData" filter="$row.val('fShopID')==shopRow.val('id')"
                  xid="goodsList" disablePullToRefresh="true" disableInfiniteLoad="true"> 
                  <ul class="x-list-template x-min-height" xid="listTemplateUl4"
                    componentname="$UI/system/components/justep/list/list#listTemplateUl"
                    id="undefined_listTemplateUl4"> 
                    <li xid="li4" class="x-min-height tb-goodList" componentname="li(html)"
                      id="undefined_li4"> 
                      <div component="$UI/system/components/justep/row/row" class="x-row">
   <div class="x-col x-col-fixed" xid="col1" style="width:auto;"><span component="$UI/system/components/justep/button/checkbox" class="x-checkbox x-radio choose" xid="checkbox2" bind-ref="ref('fChoose')" checkedValue="1"></span></div>
   <div class="x-col x-col-fixed tb-nopadding" xid="col2"><img src="" alt="" xid="image1" bind-attr-src='$model.getImageUrl(val("fImg"))' class="tb-img-good" bind-click="listClick"></img></div>
   <div class="x-col  tb-nopadding" xid="col3"><span bind-text="ref('fTitle')" class="x-flex text-black h5 tb-nomargin" xid="span26"></span>
  <div class="text-muted h6" xid="div6">
   <span xid="span27"><![CDATA[颜色:]]></span>
   <span bind-text="ref('fColor')" xid="span6"></span>
   <span xid="span7"><![CDATA[;]]></span>
   <span xid="span12"><![CDATA[尺寸:]]></span>
   <span bind-text="ref('fSize')" xid="span18"></span></div>
  <div class="text-muted" xid="div5">
   <span xid="span22" class="text-danger">￥</span>
   <span xid="span28" bind-text="ref('fPrice')" class="h4 text-danger"></span>
   <span xid="span19" class="tb-del-line">￥</span>
   <span xid="span24" bind-text="ref('fOldPrice')" class="tb-del-line"></span></div>
  <div class="tb-numberOperation" xid="div4">
   <a component="$UI/system/components/justep/button/button" class="btn x-gray btn-sm btn-only-icon pull-left" label="button" xid="button1" icon="icon-android-remove" onClick="reductionBtnClick">
    <i xid="i3" class="icon-android-remove"></i>
    <span xid="span13"></span></a> 
   <span bind-text="ref('fNumber')" class="pull-left"></span><a component="$UI/system/components/justep/button/button" class="btn x-gray btn-sm btn-only-icon pull-left" label="button" xid="button2" icon="icon-android-add" onClick="addBtnClick">
    <i xid="i6" class="icon-android-add"></i>
    <span xid="span29"></span></a> 
   
   </div></div></div></li> 
                  </ul> 
                </div> 
              </li> 
            </ul> 
          </div>
        </div>  
        <div class="x-content-center x-pull-up" xid="div7"> 
          <span class="x-pull-up-label" xid="span8"></span>
        </div> 
      </div>
    </div>  
    <div class="x-panel-bottom" xid="bottom1"> 
      <div component="$UI/system/components/justep/row/row" class="x-row tb-nopadding" xid="row2">
   <div class="x-col x-col-20 x-col-center" xid="col4"><span component="$UI/system/components/justep/button/checkbox" class="x-checkbox" xid="allChoose" label="全选" checked="false" onChange="allChooseChange" /></div>
   <div class="x-col" xid="col8"><div class="text-right" xid="div9">
   <span xid="span15" class="text-muted">合计：</span>
   <span xid="span17" class="text-danger">￥</span>
   <span xid="sum" class="h4 text-danger" bind-text="calculateData.ref('allSum')"></span></div>
  <div class="text-right" xid="div10">
   <span xid="span16">不含运费</span></div></div>
   <div class="x-col x-col-33 text-center tb-settlement" xid="col9" bind-click="settlementClick"><span xid="span10">结算(</span>
  <span xid="number" class="allNumber" bind-text="calculateData.ref('allNumber')"></span>
  <span xid="span14">)</span></div></div></div> 
  </div> 
</div>
