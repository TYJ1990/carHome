//
//  LoginViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ForgotPWDViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userTF;
@property (strong, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation LoginViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger tag = textField.tag;
    
    if (tag != 2) {
        UITextField *nextTF = [self.view viewWithTag:tag + 1];
        [nextTF becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![_userTF isExclusiveTouch] || ![_pwdTF isExclusiveTouch]) {
        [_userTF resignFirstResponder];
        [_pwdTF resignFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.userTF.tag = 1;
    self.userTF.delegate = self;
    self.pwdTF.delegate = self;
    self.pwdTF.tag = 2;
    [self createTitleBar];
}

- (void)createTitleBar {
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    head.backgroundColor = [UIColor blackColor];
    [self.view addSubview:head];
    
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kNaviH)];
    bar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bar];
    
    UIButton *back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    back.frame = CGRectMake(5, 10, 40, 20);
    [back setImage:[UIImage imageNamed:@"返回.png"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bar addSubview:back];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(bar.width / 2.0 - 50, 10, 100, 20)];
    titleL.font = [UIFont systemFontOfSize:18];
    titleL.textColor = [UIColor grayColor];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = @"登录";
    [bar addSubview:titleL];
    
    UIButton *regist = [UIButton buttonWithType:(UIButtonTypeSystem)];
    regist.frame = CGRectMake(bar.width - 40, 10, 30, 20);
    [regist setTitle:@"注册" forState:(UIControlStateNormal)];
    [regist addTarget:self action:@selector(registAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bar addSubview:regist];
}

// 忘记密码
- (IBAction)forgetPWD:(UIButton *)sender {
    
    ForgotPWDViewController *fvc = [[ForgotPWDViewController alloc] init];
    [self.navigationController pushViewController:fvc animated:YES];
}

// 登录
- (IBAction)login:(UIButton *)sender {
}

// 微博登录
- (IBAction)WeiBoLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             // 使用NSUserDefault进行存储数据
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1%@", user.nickname] forKey:@"user"];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", user.rawData[@"avatar_large"]] forKey:@"icon"];
             // 马上进行同步存储数据
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             NSDictionary *dic = @{@"nickname":user.nickname, @"figureurl_qq_2":user.rawData[@"avatar_large"]};
             // 发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil userInfo:dic];
             [self dismissViewControllerAnimated:NO completion:nil];
         }
         else
         {
             NSLog(@"%@",error);
         }
     }];

}

// QQ登录
- (IBAction)QQLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
//             NSLog(@"uid=%@",user.uid);
//             NSLog(@"%@",user.credential);
//             NSLog(@"token=%@",user.credential.token);
//             NSLog(@"nickname=%@",user.nickname);
//             NSLog(@"rawData = %@", user.rawData);
             // 使用NSUserDefault进行存储数据
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"3%@", user.nickname] forKey:@"user"];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", user.rawData[@"figureurl_qq_2"]] forKey:@"icon"];
             // 马上进行同步存储数据
             [[NSUserDefaults standardUserDefaults] synchronize];
             // 发送通知
             [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil userInfo:user.rawData];
             
             [self dismissViewControllerAnimated:NO completion:nil];
             
         }
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

// 微信登录
- (IBAction)WeiXinLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             // 使用NSUserDefault进行存储数据
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"2%@", user.nickname] forKey:@"user"];
             // 马上进行同步存储数据
             [[NSUserDefaults standardUserDefaults] synchronize];
             // 发送通知
             NSDictionary *dic = [NSDictionary dictionaryWithObject:user.nickname forKey:@"name"];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil userInfo:dic];
             [self dismissViewControllerAnimated:NO completion:nil];
         }
         else
         {
             NSLog(@"%@",error);
         }
     }];

}

// 注册
- (void)registAction {
    RegistViewController *rvc = [[RegistViewController alloc] init];
    
    [self.navigationController pushViewController:rvc animated:YES];
}

// 返回上级界面
- (void)backAction {
    [self dismissViewControllerAnimated:NO completion:nil];
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
