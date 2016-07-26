//
//  DetailViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>
#import "videoView.h"
#import "CommentModel.h"
#import "CommentTableViewCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface DetailViewController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
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

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tabBarController.tabBar.hidden = YES;
    [self.view addSubview:self.tableView];
    [self creatWebView];
    [self loadData];
    [self creatBottom];
    [self creatUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 45) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"cell"];

    }
    return _tableView;
}

- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}


#pragma mark -   导航栏控件
- (void)creatUI{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(0, 28, 65, 20);
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"返回2"] forState:(UIControlStateNormal)];
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
    UILabel *commentL = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, kScreenWidth - 10 - 70, 30)];
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
    
    UILabel *countL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 7, 80, 30)];
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




#pragma mark - 创建webView
- (void)creatWebView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth,kScreenHeight)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + kScreenWidth/2.0);
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    
    if (self.model.id) {
        self.newsid = self.model.id;
    } else{
        self.newsid = self.model.newsid;
    }
    NSString *UrlString;
    if ([self.newsid integerValue] > 100000) {
        UrlString = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/cont_v6.0.0/content/news/newscontent-pm1-n%@-t0-rct1.json",self.newsid];
    } else if ([self.newsid integerValue] < 100000){
        UrlString = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/cont_v6.0.0/content/news/videopage-a2-pm1-v6.0.0-vid%@-night0-showpage1-fs0-cw414-nwwifi-rct1.json",self.newsid];
    }
    if (self.model.videoaddress) {
        [self loadVideo];
    }
    
    self.urlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:UrlString] usedEncoding:0 error:nil];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,self.videoView.height, kScreenWidth, kScreenHeight)];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.delegate = self;
    [self.scrollView addSubview:self.webView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadAction) object:self.view];
    [thread start];
    
}
- (void)threadAction{
    [self.webView loadHTMLString:self.urlString baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
    
}




#pragma mark - 加载视频
- (void)loadVideo{
    self.videoView = [[videoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth + 20, kScreenWidth/2.0 + 10) height:0];
    [self.videoView.start sd_setImageWithURL:[NSURL URLWithString:self.model.thumbnailpics]];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://baobab.wdjcdn.com/1451897812703c.mp4"]];
    [self.videoView.player replaceCurrentItemWithPlayerItem:item];
    [self.scrollView addSubview:self.videoView];
}


#pragma mark - 网络请求
- (void)loadData{
    NSString *commentString;
    if (self.model.videoaddress.length > 0) {
        commentString = [NSString stringWithFormat:@"http://newsnc.app.autohome.com.cn/reply_v5.7.0/news/videocomments-pm1-vi%@-o0-s20-lastid0.json",self.newsid];
    }else{
        commentString = [NSString stringWithFormat:@"http://newsnc.app.autohome.com.cn/reply_v5.7.0/news/comments-pm1-n%@-o0-s20-lastid0.json",self.newsid];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [RequestManager requestWithUrlString:commentString requestType:requestGET parDic:nil finish:^(NSData *data) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [CommentModel ModelConfigureJsonDic:dic];
        UILabel *label = [self.bottomView viewWithTag:110];
        label.text = [NSString stringWithFormat:@"%@评论",dic[@"result"][@"totalcount"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight/2.0-20, kScreenWidth, 40)];
        label.text = @"网络太糟糕了";
        [view addSubview:label];
        [self.view addSubview:view];
    }];
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
        [shareParams SSDKSetupShareParamsByText:self.model.title images:imageArray url:[NSURL URLWithString:[NSString stringWithFormat:@"http://cont.app.autohome.com.cn/cont_v6.0.0/content/news/newscontent-pm1-n%@-t0-rct1.json",self.newsid]] title:self.model.title type:SSDKContentTypeAuto];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    UIView *view = [self.view viewWithTag:10000];
    [view removeFromSuperview];
    CGFloat height = webView.scrollView.contentSize.height;
    self.webView.frame = CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, height);
    if (self.model.videoaddress) {
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, height + kScreenWidth/2.0);
        self.scrollView.frame = CGRectMake(0, 40, kScreenWidth, height + kScreenWidth/2.0);
    }else{
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, height);
        self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, height);
    }
    self.tableView.tableHeaderView = self.scrollView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.videoView.player pause];
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
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextView class]]) {
            [view resignFirstResponder];
        }
    }
}

@end
