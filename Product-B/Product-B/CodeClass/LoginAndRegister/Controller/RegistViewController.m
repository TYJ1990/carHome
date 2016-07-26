//
//  RegistViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "RegistViewController.h"
#import "AreaModel.h"
#import "AreaTableViewCell.h"
#import "ValidationViewController.h"
#import "AgreementViewController.h"
@interface RegistViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) UIView *areaNumView;
@property (strong, nonatomic) UIView *transView;
@property (strong, nonatomic) IBOutlet UIButton *phoneNumBut;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation RegistViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIView *)transView {
    if (!_transView) {
        _transView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kHeight - 20)];
        _transView.backgroundColor = [UIColor grayColor];
        _transView.hidden = YES;
        _transView.alpha = 0.7;
        _transView.tag = 204;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_transView addGestureRecognizer:tap];
    }
    return _transView;
}

- (UIView *)areaNumView {
    if (!_areaNumView) {
        _areaNumView = [[UIView alloc] initWithFrame:CGRectMake(kWidth + 1, 20, 1, kHeight - 20)];
        _areaNumView.backgroundColor = [UIColor whiteColor];
        _areaNumView.tag = 203;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth / 5.0 * 4, kNaviH)];
        view.backgroundColor = [UIColor whiteColor];
        [_areaNumView addSubview:view];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNaviH - 1, view.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.7;
        [view addSubview:line];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, kNaviH)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.alpha = 0.7;
        label.text = @"选择国家";
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame = CGRectMake(view.width - 50, 0, 40, 40);
        [button setTitle:@"关闭" forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(takeBackareaNumView:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
    }
    return _areaNumView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviH, kWidth / 5.0 * 4, kHeight - kNaviH - 20)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.rowHeight = _tableView.height / 13.0;
    }
    return _tableView;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
        NSArray *arr = @[@"+1 美国", @"+852 香港", @"+886 台湾", @"+61 澳大利亚", @"+81 日本", @"+1 加拿大", @"+65 新加坡", @"+44 英国", @"+82 韩国", @"+49 德国", @"+60 马来西亚", @"+7 俄罗斯", @"+91 印度", @"+853 澳门", @"+33 法国", @"+64 新西兰", @"+84 越南", @"+39 意大利", @"+66 泰国", @"+966 沙特阿拉伯", @"+62 印度尼西亚", @"+34 西班牙", @"+86 中国"];
        for (NSString *a in arr) {
            AreaModel *model = [[AreaModel alloc] init];
            model.name = a;
            [_array addObject:model];
        }
    }
    return _array;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![_phoneNumber isExclusiveTouch]) {
        [_phoneNumber resignFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.transView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.areaNumView];
    [self createTitleBar];
    [self.areaNumView addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"AreaTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    titleL.text = @"注册";
    [bar addSubview:titleL];
}
// 更换区号
- (IBAction)areaCode:(UIButton *)sender {
    [_phoneNumber resignFirstResponder];
    [self launchareaNumView];
}
// 下一步
- (IBAction)nextAction:(UIButton *)sender {
    
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
    
    
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumber.text zone:[self.phoneNumBut.currentTitle substringFromIndex:1] customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
            ValidationViewController *vvc = [[ValidationViewController alloc] init];
            vvc.phoneNumber = self.phoneNumber.text;
            vvc.areaCode = [self.phoneNumBut.currentTitle substringFromIndex:1];
            [self.navigationController pushViewController:vvc animated:YES];
        } else {
            NSLog(@"错误信息:%@", error);
        }
    }];
    
//    ValidationViewController *vvc = [[ValidationViewController alloc] init];
//    vvc.phoneNumber = self.phoneNumber.text;
//    [self.navigationController pushViewController:vvc animated:YES];
}
// 用户服务协议
- (IBAction)agreement:(UIButton *)sender {
    AgreementViewController *avc = [[AgreementViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
}
// 返回上级页面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
// 推出国家电话区号视图
- (void)launchareaNumView {
    self.transView.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];// 动画执行时间
    [UIView setAnimationRepeatCount:1];// 动画的执行次数
    [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
    self.areaNumView.frame = CGRectMake(kWidth / 5.0, 20, kWidth / 5.0 * 4, kHeight - 20);
    // 动画提交
    [UIView commitAnimations];
}

// 收回国家电话区号视图
- (void)takeBackareaNumView:(UIButton *)sender {
    self.transView.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];// 动画执行时间
    [UIView setAnimationRepeatCount:1];// 动画的执行次数
    [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
    self.areaNumView.frame = CGRectMake(kWidth + 1, 20, 1, kHeight - 20);
    // 动画提交
    [UIView commitAnimations];
}

// 手势收回国家电话区号视图
- (void)tapAction {
    [self takeBackareaNumView:nil];
}

#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AreaModel *model = self.array[indexPath.row];
    if ([self.phoneNumBut.currentTitle integerValue] == [model.name integerValue]) {
        model.isSelect = YES;
    } else {
        model.isSelect = NO;
    }
    [cell cellConfigureModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AreaTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.nameL.textColor = self.view.tintColor;
    cell.imageV.hidden = NO;
    AreaModel *model = self.array[indexPath.row];
    model.isSelect = YES;
    [self.phoneNumBut setTitle:[NSString stringWithFormat:@"+%ld", [model.name integerValue]] forState:(UIControlStateNormal)];
    [self takeBackareaNumView:nil];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (![self.phoneNumBut.currentTitle isEqualToString:@"+86"]) {
            AreaModel *model = [self.array lastObject];
            model.isSelect = NO;
            model.name = @"+86 中国";
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.array.count - 1 inSection:0];
            
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path, nil] withRowAnimation:(UITableViewRowAnimationNone)];
        }
    });
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    AreaTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.nameL.textColor = [UIColor blackColor];
    cell.imageV.hidden = YES;
    AreaModel *model = self.array[indexPath.row];
    model.isSelect = NO;
    
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
