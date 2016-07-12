<?xml version="1.0" encoding="utf-8"?>

<div xmlns="http://www.w3.org/1999/xhtml" class="main13" component="$UI/system/components/justep/window/window"
  design="device:mobile;" xid="window">  
  <div component="$UI/system/components/justep/model/model" xid="model" style="height:auto;left:32px;top:226px;"> 
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="rootClassData" idColumn="fID" onCustomRefresh="rootClassDataCustomRefresh"> 
      <column label="id" name="fID" type="String" xid="default6"/>  
      <column label="标题" name="fClassName" type="String" xid="xid6"/> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="false"
      xid="secondClassData" idColumn="fID" onCustomRefresh="secondClassDataCustomRefresh"> 
      <column label="id" name="fID" type="String" xid="xid1"/>  
      <column label="一级分类ID" name="fRootID" type="String" xid="xid2"/>  
      <column label="分类名称" name="fClassName" type="String" xid="xid3"/> 
    </div>  
    <div component="$UI/system/components/justep/data/data" autoLoad="false"
      xid="threeClassData" onCustomRefresh="threeClassDataCustomRefresh" idColumn="fID"> 
      <column label="id" name="fID" type="String" xid="xid4"/>  
      <column label="二级分类ID" name="fSecondID" type="String" xid="xid5"/>  
      <column label="分类名称" name="fClassName" type="String" xid="xid7"/>  
      <column label="分类图片" name="fClassImg" type="String" xid="xid8"/> 
    </div> 
  </div>  
  <div component="$UI/system/components/justep/panel/panel" class="x-panel x-full x-card x-has-iosstatusbar"> 
    <div class="x-panel-top" height="49"> 
      <div component="$UI/system/components/justep/titleBar/titleBar" class="x-titlebar"
        title="宝贝分类"> 
        <div class="x-titlebar-left"> 
          </div>  
        <div class="x-titlebar-title">宝贝分类</div>  
        <div class="x-titlebar-right reverse"/> 
      </div> 
    </div>  
    <div xid="content" class="x-panel-content x-cards"> 
      <div component="$UI/system/components/bootstrap/row/row" class="row tb-box"> 
        <div class="col col-xs-3" xid="col10"> 
          <div component="$UI/system/components/justep/list/list" class="x-list tb-root"
            xid="rootClassList" data="rootClassData" dataItemAlias="rootClassRow"> 
            <ul class="x-list-template list-group" xid="listTemplateUl1"> 
              <li xid="li1" bind-css="{'current':rootClassRow.val('fID')==$model.rootClassData.val('fID')}"
                class="list-group-item text-center tb-nopadding"> 
                <h5 xid="h52" bind-text="ref('fClassName')" class="text-black"><![CDATA[]]></h5> 
              </li> 
            </ul> 
          </div> 
        </div>  
        <div class="col col-xs-9" xid="col11"> 
          <div component="$UI/system/components/justep/list/list" class="x-list"
            xid="secondClassList" data="secondClassData" filter='$row.val("fRootID")==$model.rootClassData.val("fID")' dataItemAlias="secondClassRow"> 
            <ul class="x-list-template" xid="listTemplateUl2"> 
              <li xid="li2"> 
                <h5 bind-text="ref('fClassName')" class="text-muted"><![CDATA[]]></h5>  
                <div component="$UI/system/components/justep/list/list" class="x-list clearfix"
                  xid="threeClassList" data="threeClassData" filter="$row.val('fSecondID')==secondClassRow.val('fID')" bind-click="listClick" dataItemAlias="threeClassRow"> 
                  <ul class="x-list-template" xid="listTemplateUl3"> 
                    <li xid="li3" class="col col-xs-4 text-center tb-listBox text-black"> 
                      <div><img src="" alt="" bind-attr-src='$model.getImageUrl(val("fClassImg"))' class="img-responsive" /><p bind-text="val(&quot;fClassName&quot;)"/></div>
                       
                    </li> 
                  </ul> 
                </div> 
              </li> 
            </ul> 
          </div> 
        </div> 
      </div> 
    </div> 
  </div> 
</div>
