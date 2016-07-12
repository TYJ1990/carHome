JSON数据

1、imgData.json，滚动图片
id         id        String
fImgUrl    图片                 String
fUrl       链接地址       String

2、goodsData.json，商品信息
id           id           String
fShopID      店铺ID       String
fTitle       标题                         String
fImg         图片                         String
fPrice       价格                         Float
fPostage     邮费                         String
fRecord      月销量               Integer

打开url页面，代码如下：
justep.Shell.showPage(require.toUrl(url),{
	rowid : rowid
});