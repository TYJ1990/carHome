//
//  ValidationViewController.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "ValidationViewController.h"

@interface ValidationViewController ()
@property (strong, nonatomic) IBOutlet UITextField *vCodeTF;
@property (strong, nonatomic) IBOutlet UIButton *dateBut;
@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ValidationViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.seconds = 60;
    [self createTitleBar];
    [self.dateBut setUserInteractionEnabled:NO];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)timerAction:(NSTimer *)timer {
    if (self.seconds == 1) {
        [timer invalidate];
        [_dateBut setTitle:@"获取验证码" forState: UIControlStateNormal];
        [_dateBut setTitleColor:self.view.tintColor forState:(UIControlStateNormal)];
        [_dateBut setUserInteractionEnabled:YES];
        [_dateBut addTarget:self action:@selector(dateAction) forControlEvents:(UIControlEventTouchUpInside)];
    } else {
        self.seconds --;
        NSString *title = [NSString stringWithFormat:@"重新获取%lds", _seconds];
        [self.dateBut setTitle:title forState:(UIControlStateNormal)];
        [_dateBut setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self.dateBut setUserInteractionEnabled:NO];
    }
    
}

- (void)dateAction {
   
    /**
     *  @from                    v1.1.1
     *  @brief                   获取验证码(Get verification code)
     *
     *  @param method            获取验证码的方法(The method of getting verificationCode)
     *  @param phoneNumber       电话号码(The phone number)
     *  @param zone              区域号，不要加"+"号(Area code)
     *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
     *  @param result            请求结果回调(Results of the request)
     */
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumber zone:self.areaCode customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
            self.seconds = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
            [self.timer fire];
        } else {
            NSLog(@"错误信息:%@", error);
        }
    }];
    
}

// 创建标题栏
- (void)createTitleBar {
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    head.backgroundColor = [UIColor blackColor];
    [self.view addSubview:head];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20 + kNaviH, kWidth - 50, 35)];
    label.textColor = [UIColor grayColor];
    label.alpha = 0.7;
    label.font = [UIFont systemFontOfSize:13];
    label.text = [NSString stringWithFormat:@"请输入手机号%@收到的短信验证码", self.phoneNumber];
    [self.view addSubview:label];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/2.0 - 90, 10, 180, 20)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor grayColor];
    //    titleL.font = [UIFont systemFontOfSize:17];
    titleL.text = @"填写短信验证码";
    [view addSubview:titleL];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.frame = CGRectMake(5, 10, 40, 20);
    [button setImage:[UIImage imageNamed:@"返回.png"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:button];
}

// 返回上级页面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

// 下一步
- (IBAction)nextAction:(UIButton *)sender {
    /**
     * @from               v1.1.1
     * @brief              提交验证码(Commit the verification code)
     *
     * @param code         验证码(Verification code)
     * @param phoneNumber  电话号码(The phone number)
     * @param zone         区域号，不要加"+"号(Area code)
     * @param result       请求结果回调(Results of the request)
     */
    
    [SMSSDK commitVerificationCode:self.vCodeTF.text phoneNumber:self.phoneNumber zone:self.areaCode result:^(NSError *error) {
        if (!error) {
            NSLog(@"验证成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
    }];
    
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
