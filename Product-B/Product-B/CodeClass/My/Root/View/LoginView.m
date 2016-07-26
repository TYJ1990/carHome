//
//  LoginView.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "LoginView.h"
#import "LoginViewController.h"

@implementation LoginView

#pragma mark 账号登陆
- (IBAction)loginAction:(UIButton *)sender {
//    self.myVC.navigationController.navigationBarHidden = NO;
    LoginViewController *login = [[LoginViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:login];
    [self.myVC presentViewController:nc animated:NO completion:nil];
}

#pragma mark QQ登陆
- (IBAction)QQLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
            
             // 使用NSUserDefault进行存储数据
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"3%@", user.nickname] forKey:@"user"];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", user.rawData[@"figureurl_qq_2"]] forKey:@"icon"];
             // 马上进行同步存储数据
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             // 发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil userInfo:user.rawData];
         }
         else
         {
             NSLog(@"%@",error);
         }
     }];
}

#pragma mark 微博登陆
- (IBAction)WeiBoLogin:(id)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             NSLog(@"raw = %@", user.rawData);
             
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1%@", user.nickname] forKey:@"user"];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", user.rawData[@"avatar_large"]] forKey:@"icon"];
             // 马上进行同步存储数据
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             NSDictionary *dic = @{@"nickname":user.nickname, @"figureurl_qq_2":user.rawData[@"avatar_large"]};
             // 发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil userInfo:dic];
             
         }
         else
         {
             NSLog(@"%@",error);
         }
     }];
}

#pragma mark 微信登陆
- (IBAction)WinXinLogin:(id)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"2%@", user.nickname] forKey:@"user"];
             // 马上进行同步存储数据
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             // 发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil userInfo:user.rawData];
         }
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

#pragma mark 获取Caches路径
- (NSString *)cachesFilePath {
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
