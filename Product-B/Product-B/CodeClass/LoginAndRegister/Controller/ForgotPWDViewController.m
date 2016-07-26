//
//  ForgotPWDViewController.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "ForgotPWDViewController.h"

@interface ForgotPWDViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *vCodeTF;
@property (strong, nonatomic) IBOutlet UITextField *validationTF;
@property (strong, nonatomic) IBOutlet UIButton *dateBut;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger seconds;

@end

@implementation ForgotPWDViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [self createTitleBar];
//    self.vCodeTF.delegate = self;
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//    [self.timer fire];
    [self.vCodeTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self.dateBut addTarget:self action:@selector(dateAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)textFieldChanged:(UITextField *)textField {
    if (textField.text.length == 0) {
        [self.dateBut setUserInteractionEnabled:NO];
        [self.dateBut setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        
    } else {
        [self.dateBut setUserInteractionEnabled:YES];
        [self.dateBut setTitleColor:self.dateBut.tintColor forState:(UIControlStateNormal)];
    }

}

- (void)dateAction:(UIButton *)sender {
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.dateBut setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.dateBut setTitleColor:self.view.tintColor forState:UIControlStateNormal];
                self.dateBut.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.dateBut setTitle:[NSString stringWithFormat:@"重新获取%.2ds", seconds] forState:UIControlStateNormal];
                [self.dateBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                self.dateBut.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
//    [self.dateBut setUserInteractionEnabled:NO];
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//    [self.timer fire];
}

- (void)timerAction:(NSTimer *)timer {
    NSLog(@"11111111");
    if (self.seconds == 1) {
        [timer invalidate];
        [_dateBut setTitle:@"获取验证码" forState: UIControlStateNormal];
        [_dateBut setTitleColor:self.view.tintColor forState:(UIControlStateNormal)];
        [_dateBut setUserInteractionEnabled:YES];
//        [_dateBut addTarget:self action:@selector(dateAction) forControlEvents:(UIControlEventTouchUpInside)];
    } else {
        self.seconds --;
        NSString *title = [NSString stringWithFormat:@"重新获取%lds", _seconds];
        [self.dateBut setTitle:title forState:(UIControlStateNormal)];
        [_dateBut setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self.dateBut setUserInteractionEnabled:NO];
    }
}

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
    label.text = @"请使用已注册的手机号";
    [self.view addSubview:label];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/2.0 - 90, 10, 180, 20)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor grayColor];
    titleL.text = @"验证手机号";
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
