<?xml version="1.0" encoding="utf-8"?>

<div xmlns="http://www.w3.org/1999/xhtml" xid="window" class="window" component="$UI/system/components/justep/window/window"
  design="device:m;">  
  <div component="$UI/system/components/justep/model/model" xid="model" style="height:auto;left:354px;top:95px;"> 
    <div component="$UI/system/components/justep/data/data" autoLoad="true"
      xid="searchKeyData" idColumn="key" onCustomRefresh="searchKeyDataCustomRefresh"
      autoNew="false"> 
      <column label="搜索关键字" name="key" type="String" xid="xid1"/>  
      <data xid="default1">[]</data>
    </div> 
  </div>  
  <div component="$UI/system/components/justep/panel/panel" class="x-panel x-full x-card"
    xid="panel1"> 
    <div class="x-panel-top" height="48" xid="top1"> 
      <div component="$UI/system/components/justep/titleBar/titleBar" class="x-titlebar tb-index"
        xid="titleBar1"> 
        <div class="x-titlebar-left" xid="div1"> 
          <a component="$UI/system/components/justep/button/button" class="btn btn-link btn-only-icon"
            label="搜索" xid="button6" icon="icon-chevron-left" onClick="{operation:'window.close'}"> 
            <i xid="i6" class="icon-chevron-left"/>  
            <span xid="span6">搜索</span> 
          </a> 
        </div>  
        <div class="x-titlebar-title" xid="div2"> 
          <div class="form-group has-feedback" xid="formGroup1"> 
            <input component="$UI/system/components/justep/input/input" class="form-control input-sm text-white"
              xid="keyInput" bind-focus="keyInputFocus"/>  
            <i class="icon-ios7-search-strong form-control-feedback" xid="col3"/> 
          </div> 
        </div>  
        <div class="x-titlebar-right reverse" xid="div3"> 
          <a component="$UI/system/components/justep/button/button" class="btn x-yellow btn-only-label more"
            label="搜索" xid="searchBtn" onClick="searchBtnClick"> 
            <i xid="i11"/>  
            <span xid="span10">搜索</span> 
          </a> 
        </div> 
      </div> 
    </div>  
    <div xid="content" class="x-panel-content x-cards"> 
      <div class="panel x-card" bind-visible="$model.searchKeyData.count()&gt;0">
        <div class="tb-title text-muted">历史搜索</div><div component="$UI/system/components/justep/list/list" class="x-list"
          xid="keyMenuList" data="searchKeyData" bind-click="liClick"> 
          <ul class="x-list-template x-min-height" xid="ul1" componentname="ul(html)"
            id="undefined_ul1"> 
            <li xid="li1" class="x-min-height" componentname="li(html)" id="undefined_li1"> 
              <i xid="i1" class="icon-ios7-arrow-right pull-right"/>  
              <h5 bind-text="ref('key')" class="text-black"><![CDATA[]]></h5> 
            </li> 
          </ul> 
        </div> 
      </div>  
      <div class="text-center">
        <a component="$UI/system/components/justep/button/button" class="btn btn-default tb-clearBtn"
          label="清空搜索历史" xid="clearBtn" onClick="clearBtnClick" bind-visible=" $model.comp(&quot;searchKeyData&quot;).count()&gt;0"
          style="display:none;"> 
          <i xid="i2"/>  
          <span xid="span1">清空搜索历史</span>
        </a>
      </div> 
    </div> 
  </div> 
</div>
