//
//  AuthViewController.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "AuthViewController.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, kScreenWidth, 25)];
    nameL.textAlignment = NSTextAlignmentCenter;
    nameL.textColor = [UIColor grayColor];
    nameL.text = [NSString stringWithFormat:@"编辑博客_%@",self.name];
    [self.view addSubview:nameL];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(0, 23, 65, 25);
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"返回2"] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.blogUrl]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
