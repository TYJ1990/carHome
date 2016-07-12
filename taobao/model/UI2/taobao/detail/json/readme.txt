JSON数据

1、goodsData.json，商品详细
id              id        String
fTitle          标题                 String
fImg            图片                 String
fPrice          价格                 Float
fOldPrice       原价格            Float
fPostage        邮费                 String
fRecord         买出数量       Integer
fAddress        所在地区       String
fDetail         商品详情       String
fSpecification  商品参数       String
fCommentsNumber 评论数量       String 

2、imgData.json，商品图片
id           id        String
fImgUrl      图片                 String

3、commentsData.json，评论信息
id			 id        String
fUserName    用户名            String
fUserImg     用户头像       String
fScore       评分                 Float
fContent     评论内容       String
fDate        评论日期       Date

4、shopData.json，店铺信息
id           id        String
fShopName    店名                 String
fLevel       等级                 Integer
fShopImg     店标                 String
fConsistent  描述相符       Float
fService     服务态度       Float
fGoodsNumber 商品数量       Integer
fFocusNumber 关注人数       Integer

5、parameterData.json,商品参数 
id           id        String
fGoodsID     商品ID    String
fName        参数名           String
fParameter   参数                String

