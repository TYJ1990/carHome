//
//  MallViewController.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MallViewController.h"
#import <WebKit/WebKit.h>

@interface MallViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIActivityIndicatorView *aView;

@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-15)];
    self.webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}





- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60)];
//    view.backgroundColor = [UIColor blackColor];
//    view.alpha = 0.5;
//    view.tag = 10000;
//    [self.view addSubview:view];
//    self.aView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    self.aView.center = self.view.center;
//    self.aView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//    [self.view addSubview:self.aView];
//    [self.aView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    UIView *view = [self.view viewWithTag:10000];
//    [view removeFromSuperview];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        NSString *js = @"function imgAutoFit() { \
        var imgs = document.getElementsByTagName('img'); \
        for (var i = 0; i < imgs.length; ++i) {\
        var img = imgs[i];   \
        img.style.maxWidth = %f;   \
        } \
        }";
        js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    
        [webView stringByEvaluatingJavaScriptFromString:js];
        [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}



@end
