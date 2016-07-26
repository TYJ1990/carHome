//
//  AgreementViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define KUrl @"http://mobile.app.autohome.com.cn/usereg_v5.7.0/static/register_protocol.html"
#import "AgreementViewController.h"
#import "AdjustHeight.h"
@interface AgreementViewController ()
@end

@implementation AgreementViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [self createTitleBar];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 20 + kNaviH, kWidth, kHeight - 20 -kNaviH)];
    webView.scrollView.bounces = NO;
    webView.backgroundColor = [UIColor grayColor];

    NSURL *url = [NSURL URLWithString:KUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
    [self.view addSubview:webView];
}

- (void)createTitleBar {
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    head.backgroundColor = [UIColor blackColor];
    [self.view addSubview:head];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, 40)];
    view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:view];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.frame = CGRectMake(5, 10, 30, 20);
    [button setTitle:@"关闭" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:button];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
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
