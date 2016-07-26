//
//  DetailsViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (nonatomic, assign) BOOL isCollection;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UILabel *pagesL;
@property (nonatomic, assign) NSInteger totalCount;
@end

@implementation DetailsViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNaviH + 20, kWidth, kHeight - 80 - 20)];
        _webView.opaque = NO;
        self.webView.scrollView.bounces = NO;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.tabBarController.tabBar.hidden = YES;
    self.totalCount = [_totalNum integerValue] / 20 + 1;
    self.index = 1;
    
    [self createWebView];
    [self createTitleBar];
    [self createTabBar];
    [self.view addSubview:self.webView];
    
    // 下拉刷新
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.index > 1) {
            self.webView.scrollView.bounces = YES;
            self.index -= 1;
            if (self.index == 1) {
                self.webView.scrollView.bounces = NO;
            }
            self.pagesL.text = [NSString stringWithFormat:@"%ld/%ld页", self.index, self.totalCount];
            [self createWebView];
        } else {
            
            [self.webView.scrollView.mj_header endRefreshing];

            return;
        }
    }];
    // 上拉加载
    self.webView.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.index < self.totalCount) {
            self.webView.scrollView.bounces = YES;
            self.index += 1;
            self.pagesL.text = [NSString stringWithFormat:@"%ld/%ld页", self.index, self.totalCount];
            
            [self createWebView];
        } else {
            [self.webView.scrollView.mj_footer endRefreshing];
            return;
        }
    }];

}

- (void)createWebView {
    NSString *urlstring = [NSString stringWithFormat:@"http://forum.app.autohome.com.cn/forum_v6.1.0/forum/club/topiccontent-a2-pm1-v6.1.0-t%@-o0-p%ld-s20-c1-nt0-fs0-sp0-al0-cw375-rct1.json", self.topicid, self.index];
    NSString *url = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlstring] usedEncoding:0 error:nil];
    [self.webView loadHTMLString:url baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
    
    [self.webView.scrollView.mj_header endRefreshing];
    [self.webView.scrollView.mj_footer endRefreshing];
}

// 标题栏
- (void)createTitleBar {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    headView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:headView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kNaviH)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, kWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    
    UIButton *backBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBut.frame = CGRectMake(10, 10, 40, 20);
    [backBut setImage:[UIImage imageNamed:@"返回.png"] forState:(UIControlStateNormal)];
    [backBut addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:backBut];
    
    UIButton *shareBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    shareBut.frame = CGRectMake(kWidth - 30, 10, 20, 20);
    [shareBut setImage:[UIImage imageNamed:@"分享.png"] forState:(UIControlStateNormal)];
    [shareBut addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:shareBut];
    
    UIButton *collectionBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    collectionBut.frame = CGRectMake(kWidth - (15 + 20 + 30), 10, 20, 20);
    [collectionBut setImage:[UIImage imageNamed:@"收藏.png"] forState:(UIControlStateNormal)];
    [collectionBut addTarget:self action:@selector(collectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:collectionBut];
    
    UIButton *masterBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    masterBut.frame = CGRectMake(kWidth - (15 + 20 + 30 + 45), 10, 30, 20);
    [masterBut setImage:[UIImage imageNamed:@"楼主.png"] forState:(UIControlStateNormal)];
    [masterBut addTarget:self action:@selector(masterAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:masterBut];
    
}

// 回帖栏
- (void)createTabBar {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 40, kWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 39, kWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    UIButton *replyBut = [UIButton buttonWithType:(UIButtonTypeCustom)];
    replyBut.frame = CGRectMake(10, 5, kWidth / 4.0 * 3, 30);
    [replyBut setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [replyBut.layer setBorderWidth:1.0];
    [replyBut.layer setBorderColor:[UIColor grayColor].CGColor];
    [replyBut setTitle:@"发表回帖" forState:(UIControlStateNormal)];
    [replyBut addTarget:self action:@selector(replyAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:replyBut];
    
    self.pagesL = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 4.0 * 3 + 10, 5, kWidth / 4.0 - 10, 30)];
    _pagesL.textAlignment = NSTextAlignmentCenter;
    _pagesL.textColor = [UIColor blueColor];
    _pagesL.font = [UIFont systemFontOfSize:15];
    _pagesL.text = [NSString stringWithFormat:@"%ld/%ld页", self.index, self.totalCount];
    [view addSubview:_pagesL];
    
}

// 发表回帖
- (void)replyAction:(UIButton *)sender {
    
}

// 返回上一级界面
- (void)backAction {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
// 分享
- (void)shareAction:(UIButton *)sender {
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shipinbg.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                       }];
    }
}
// 收藏
- (void)collectionAction:(UIButton *)sender {
    
    _isCollection = !_isCollection;
    if (_isCollection) {
        [sender setImage:[UIImage imageNamed:@"取消收藏.png"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"收藏.png"] forState:(UIControlStateNormal)];
    }
}
// 只看楼主
- (void)masterAction:(UIButton *)sender {
    
    _isSelect = !_isSelect;
    
    if (_isSelect) {
        [sender setImage:[UIImage imageNamed:@"取消楼主.png"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"楼主.png"] forState:(UIControlStateNormal)];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
