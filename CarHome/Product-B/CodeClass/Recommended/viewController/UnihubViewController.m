//
//  DetailViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "UnihubViewController.h"
#import <WebKit/WebKit.h>
#import "videoView.h"
#import "CommentModel.h"
#import "CommentTableViewCell.h"
#import "SHBAVController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface UnihubViewController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIButton *collection;
@property(nonatomic,strong)UIButton *share;
@property(nonatomic,strong)videoView *videoView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView *textView;
@property (nonatomic,strong)UIActivityIndicatorView *aView;

@end

@implementation UnihubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tabBarController.tabBar.hidden = YES;
    [self creatWebView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight- 44 - 60) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.modelArray = [NSMutableArray array];
    [self loadData];
    [self creatBottom];
    [self creatUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark -   导航栏控件
- (void)creatUI{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(8, 28, 45, 23);
    [btn setTitle:@"返回2" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    self.collection = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.collection.frame = CGRectMake(kScreenWidth - 80, 25, 25, 25);
    [self.collection setImage:[UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
    [self.collection addTarget:self action:@selector(collectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.collection setTintColor:self.view.tintColor];
    [self.view addSubview:self.collection];
    
    self.share = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.share.frame = CGRectMake(kScreenWidth - 32, 29, 20, 20);
    [self.share setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
    [self.share setTintColor:self.view.tintColor];
    [self.share addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.share];
    
    self.textView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 150)];
    self.textView.backgroundColor = [UIColor whiteColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    title.text = @"评论";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor grayColor];
    [self.textView addSubview:title];
    
    UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    cancelBtn.frame = CGRectMake(8, 5, 35, 20);
    cancelBtn.tintColor = self.view.tintColor;
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.textView addSubview:cancelBtn];
    
    UIButton *sendBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [sendBtn setTitle:@"发送" forState:(UIControlStateNormal)];
    sendBtn.tintColor = [UIColor lightGrayColor];
    sendBtn.tag = 120;
    sendBtn.frame = CGRectMake(kScreenWidth - 45 , 5, 35, 20);
    [self.textView addSubview:sendBtn];
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.textView addSubview:view];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 31, kScreenWidth, 120)];
    textView.tag = 123;
    textView.delegate = self;
    [self.textView addSubview:textView];
    
    UILabel *placeHold = [[UILabel alloc] initWithFrame:CGRectMake(0, 31, 100, 30)];
    placeHold.text = @"输入内容...";
    placeHold.textColor = [UIColor grayColor];
    placeHold.enabled = NO;
    placeHold.backgroundColor = [UIColor clearColor];
    [self.textView addSubview:placeHold];
    
    [self.view addSubview:self.textView];
}
- (void)creatBottom{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
    self.bottomView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    UILabel *commentL = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, kScreenWidth - 10 - 60, 30)];
    commentL.text = @"发表评论";
    commentL.backgroundColor = [UIColor whiteColor];
    commentL.userInteractionEnabled = YES;
    commentL.textAlignment = NSTextAlignmentCenter;
    [commentL.layer setBorderWidth:1];
    commentL.textColor = [UIColor lightGrayColor];
    commentL.font = [UIFont systemFontOfSize:15.0];
    [commentL.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.bottomView addSubview:commentL];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(showTextView:)];
    [commentL addGestureRecognizer:tap];
    
    UILabel *countL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 7, 70, 30)];
    countL.text = @"0评";
    countL.tag = 110;
    countL.textAlignment = NSTextAlignmentCenter;
    countL.textColor = self.view.tintColor;
    countL.font = [UIFont systemFontOfSize:15.0];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToTableView:)];
    countL.userInteractionEnabled = YES;
    [countL addGestureRecognizer:tap2];
    [self.bottomView addSubview:countL];
    
    [self.view addSubview:self.bottomView];
}


- (void)creatWebView{
    
    if (self.model.id) {
        self.newsid = self.model.id;
    } else{
        self.newsid = self.model.newsid;
    }
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth,kScreenHeight)];
    self.scrollView.scrollEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + kScreenWidth/2.0 - 10);
    [self.view addSubview:self.scrollView];
    
    NSString *UrlString;
    if (self.model.videoid.length > 1 || self.model.mediaid.length > 0) {
        [self loadVideo];
        UrlString = [NSString stringWithFormat:@"http://news.app.autohome.com.cn/news_v6.0.0/newspf/news/npvideofinalpage-pm1-n%@-ntwifi-w414-rct1.json",self.newsid];
    }else if([self.model.mediatype integerValue] == 1){
        UrlString = [NSString stringWithFormat:@"http://news.app.autohome.com.cn/news_v6.0.0/newspf/news/nplongarticle-n%@-rct1.json",self.newsid];
    }
    
    NSString *webString = [NSString stringWithContentsOfURL:[NSURL URLWithString:UrlString] usedEncoding:0 error:nil];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,self.videoView.height, kScreenWidth, kScreenHeight - 60 - 44)];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.delegate = self;
    [self.webView loadHTMLString:webString baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
    [self.scrollView addSubview:self.webView];

}




#pragma mark - 加载视频
- (void)loadVideo{
    self.videoView = [[videoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth + 20, kScreenWidth/2.0 + 10) height:0];
//    [self.videoView.start sd_setImageWithURL:[NSURL URLWithString:self.model.thumbnailpics]];
    NSString *videoUrl;
    if (self.model.videoid) {
        videoUrl = self.model.videoid;
    }else{
        videoUrl = self.model.mediaid;
    }
    [RequestManager requestWithUrlString:[NSString stringWithFormat:@"http://newsnc.app.autohome.com.cn/news_v6.0.0/newspf/npgetvideoaudiosource.ashx?pm=1&mids=%@&mt=1&ft=m3u8",videoUrl] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSArray *array = [dic[@"result"] firstObject][@"copieslist"];
        self.videoURL = array[0][@"playurl"];
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.videoURL]];
        [self.videoView.player replaceCurrentItemWithPlayerItem:item];
        [self.videoView.player play];
        UILongPressGestureRecognizer *tapGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self  action:@selector(showAvplayerController:)];
        [self.videoView addGestureRecognizer:tapGes];
        
    } error:^(NSError *error) {
        NSLog(@"1111");
    }];
    [self.scrollView addSubview:self.videoView];
}



#pragma mark - 网络请求
- (void)loadData{
    [RequestManager requestWithUrlString:[NSString stringWithFormat:@"http://newsnc.app.autohome.com.cn/reply_v5.7.0/news/newsplatformcomments-a2-pm1-v5.7.0-n%@-lastid0-ps20.json",self.newsid] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [CommentModel ModelConfigureJsonDic:dic];
        UILabel *label = [self.bottomView viewWithTag:110];
        label.text = [NSString stringWithFormat:@"%@评论",dic[@"result"][@"totalcount"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}





#pragma mark - 导航栏button 方法
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)collectionAction:(UIButton *)btn{
    [self.collection setImage:[UIImage imageNamed:@"取消收藏"] forState:(UIControlStateNormal)];
}
- (void)shareAction:(UIButton *)btn{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"Icon@2x"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:self.model.title images:imageArray url:[NSURL URLWithString:[NSString stringWithFormat:@"http://news.app.autohome.com.cn/news_v6.0.0/newspf/news/npvideofinalpage-pm1-n%@-ntwifi-w414-rct1.json",self.newsid]] title:self.model.title type:SSDKContentTypeAuto];
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state,SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:{
                               UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil];
                               [alertView show];
                               
                               break;
                           }
                           case SSDKResponseStateFail:{
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }

}
- (void)showTextView:(UITapGestureRecognizer *)tap{
    UITextView *textView = [self.textView viewWithTag:123];
    [textView becomeFirstResponder];
}
- (void)scrollToTableView:(UITapGestureRecognizer *)tap{
    if (self.modelArray.count < 1) {
        return;
    }
    if (!self.isScro) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    }else{
        CGPoint point = self.tableView.contentOffset;
        point.y = 0;
        self.tableView.contentOffset = point;
    }
    self.isScro = !self.isScro;
}
- (void)cancel:(UIButton *)btn{
    UITextView *textView = [self.textView viewWithTag:123];
    [textView resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.textView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 150);
    }];
}


- (void)showAvplayerController:(UITapGestureRecognizer *)tap{
    [self.videoView.player pause];
    if (self.videoView.player.currentTime.timescale == 0 || self.videoView.player.currentItem.duration.timescale == 0) {
        return;
    }
    long long int currentTime = self.videoView.player.currentTime.value / self.videoView.player.currentTime.timescale;
    SHBAVController *av = [[SHBAVController alloc] initWithUrl:[NSURL URLWithString:self.videoURL] time:currentTime];
    [self presentViewController:av animated:true completion:nil];
}




#pragma mark - tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CommentModel *model = self.modelArray[indexPath.row];
    [cell cellConfigureModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model = self.modelArray[indexPath.row];
    CGFloat h = [UILabel getHeightByWidth:kScreenWidth - 65 title:model.content font:[UIFont systemFontOfSize:17.0]];
    if (model.sourcecontent.length < 1) {
        return h + 100;
    } else{
        CGFloat h2 = [UILabel getHeightByWidth:kScreenWidth - 50 - 45 title:model.sourcecontent font:[UIFont systemFontOfSize:14.0]];
        return h + h2 + 100+55+15;
    }
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    label.text = @"最新评论";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = self.view.tintColor;
    if (self.modelArray.count<1) {
        label.text = @"我来说两句";
        label.backgroundColor = [UIColor redColor];
    }
    label.font = [UIFont systemFontOfSize:14.0];
    [label sizeToFit];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


- (void)viewWillDisappear:(BOOL)animated{
    [self.videoView.player pause];
}


#pragma mark - webView 代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.tag = 10000;
    [self.view addSubview:view];
    self.aView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    self.aView.center = self.view.center;
    self.aView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.view addSubview:self.aView];
    [self.aView startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    UIView *view = [self.view viewWithTag:10000];
    [view removeFromSuperview];
//    NSString *js = @"function imgAutoFit() { \
//    var imgs = document.getElementsByTagName('img'); \
//    for (var i = 0; i < imgs.length; ++i) {\
//    var img = imgs[i];   \
//    img.style.maxWidth = %f;   \
//    } \
//    }";
//    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
//    
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
//    
//    //获取到webview的高度
//    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGFloat height = webView.scrollView.contentSize.height;
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    frame = webView.frame;
    frame.size = [webView sizeThatFits:CGSizeZero];
    webView.frame = frame;
//    self.webView.frame = CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, height);
    
    if (self.model.videoid.length > 1 || self.model.mediaid.length > 0) {
        self.scrollView.contentSize = CGSizeMake(0, height + kScreenWidth/2.0);
        self.scrollView.frame = CGRectMake(0, 60, kScreenWidth, height + kScreenWidth/2.0);
    }else{
        self.scrollView.contentSize = CGSizeMake(0, height);
        self.scrollView.frame = CGRectMake(0, 60, kScreenWidth, height);
    }
    self.tableView.tableHeaderView = self.scrollView;
}

//键盘出现
-(void)keyBoardShow:(NSNotification *)note{
    CGRect keyBoardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat H = keyBoardFrame.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        //只会走一次
        self.textView.transform = CGAffineTransformMakeTranslation(0, -H - self.textView.height);
    }];
}

//键盘消失
-(void)keyBoardHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.textView.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        
    }];
}

#pragma mark   -- -- - 回收键盘 --------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in self.textView.subviews) {
        if ([view isKindOfClass:[UITextView class]]) {
            [view resignFirstResponder];
        }
    }
}


@end
