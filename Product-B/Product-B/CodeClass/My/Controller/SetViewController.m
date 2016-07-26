//
//  SetViewController.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "SetViewController.h"
#import "LoginViewController.h"

@interface SetViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTitleBar];
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSLog(@"%ld", [name integerValue]);
    _button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _button.frame = CGRectMake(10, 200, kWidth - 20, 40);
    _button.tag = [name integerValue];
    _button.backgroundColor = [UIColor redColor];
    [_button setTintColor:[UIColor whiteColor]];
    [_button setTitle:@"退出当前账号" forState:(UIControlStateNormal)];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
    
    if ([name isEqualToString:@"0"] || name == nil) {
        self.button.hidden = YES;
    } else {
        self.button.hidden = NO;
    }
}

- (void)createTitleBar {
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    head.backgroundColor = [UIColor blackColor];
    [self.view addSubview:head];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kNaviH)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:view];
    
    UIButton *back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    back.frame = CGRectMake(5, 10, 40, 20);
    back.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [back setImage:[UIImage imageNamed:@"返回.png"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:back];
}

// 注销账号
- (void)buttonAction:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"确定要退出登录吗?" preferredStyle:1];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"icon"];
        // 马上进行同步存储数据
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Change" object:nil];
        
        switch (sender.tag - 1) {
            case 0:
                [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
                break;
            case 1:
                [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
                break;
            case 2:
                [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
                break;
            default:
                break;
        }
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];

}

// 返回上级界面
- (void)backAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)goChange:(NSNotification *)notification
{
    NSLog(@"asdfghjk");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
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
