//
//  MyViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MyViewController.h"
#import "LoginView.h"
#import "IsLogged.h"
#import "LoginViewController.h"
#import "SetModel.h"
#import "MyModel.h"
#import "MyTableViewCell.h"
#import "MyCollectionViewController.h"
#import "SetViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL state;
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) IsLogged *loggedView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) SetViewController *setVC;
@end

@implementation MyViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
        NSArray *arr1 = @[@"兑换商城", @"我的优惠券", @"我的收藏", @"浏览历史", @"草稿箱", @"设置"];
        NSArray *arr2 = @[@"兑换.png", @"优惠券.png", @"收藏.png", @"时间.png", @"编辑.png", @"设置.png"];
        for (int i = 0; i < arr1.count; i++) {
            MyModel *model = [[MyModel alloc] init];
            model.name = arr1[i];
            model.image = arr2[i];
            [_array addObject:model];
        }
    }
    return _array;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 + kNaviH, kWidth, kHeight - (20 + kNaviH + 44))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self createTitleBar];
    [self loginAndLogout];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goChange:) name:@"Change" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goLogin:) name:@"login" object:nil];
    
}

// 登陆/注销页面
- (void)loginAndLogout {
    
    _loginView = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:nil options:nil] firstObject];
    _loginView.myVC = self;
    _loginView.frame = CGRectMake(0, 0, kWidth, kHeight / 3.0);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.loginView addGestureRecognizer:tap];
    
    _loggedView = [[[NSBundle mainBundle] loadNibNamed:@"IsLogged" owner:nil options:nil] firstObject];
    _loggedView.frame = _loginView.frame;
    _loggedView.backgroundColor = [UIColor whiteColor];
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSString *icon = [[NSUserDefaults standardUserDefaults] objectForKey:@"icon"];
    if ([name isEqualToString:@"0"] || name == nil) {
        self.loginView.hidden = NO;
        self.loggedView.hidden = YES;
    } else {
        self.loginView.hidden = YES;
        self.loggedView.hidden = NO;
        self.loggedView.nameL.text = [name substringFromIndex:1];
        [self.loggedView.imageV sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"头像.png"] completed:nil];
        self.loggedView.imageV.layer.cornerRadius = self.loggedView.imageV.width / 2.0;
    }
}

// 监听注销
- (void)goChange:(NSNotification *)notification {
    
    self.loginView.hidden = NO;
    self.loggedView.hidden = YES;
}

// 监听登录
- (void)goLogin:(NSNotification *)notification {
    NSDictionary *dic = [notification userInfo];
    self.loggedView.nameL.text = dic[@"nickname"];
    [self.loggedView.imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"figureurl_qq_2"]] placeholderImage:[UIImage imageNamed:@"头像.png"] completed:nil];
    self.loggedView.imageV.layer.cornerRadius = self.loggedView.imageV.width / 2.0;
    self.loginView.hidden = YES;
    self.loggedView.hidden = NO;
}

// 创建标题栏
- (void)createTitleBar {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    headView.backgroundColor = [UIColor blackColor];
     [self.view addSubview:headView];
    
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kNaviH)];
    View.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:View];
    
    UILabel *myL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    myL.textColor = self.view.tintColor;
    myL.text = @"我";
    [View addSubview:myL];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, kNaviH - 1, kWidth, 1)];
    lineV.backgroundColor = [UIColor grayColor];
    lineV.alpha = 0.7;
    [View addSubview:lineV];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, kNaviH - 2, 30, 2)];
    lineView.backgroundColor = self.view.tintColor;
    [View addSubview:lineView];
    
    UIButton *stateBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    stateBut.frame = CGRectMake(kWidth - 30, 10, 20, 20);
    [stateBut setImage:[UIImage imageNamed:@"夜间模式.png"] forState:(UIControlStateNormal)];
    [stateBut addTarget:self action:@selector(stateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [View addSubview:stateBut];
}

// 白天/夜间模式切换
- (void)stateAction:(UIButton *)sender {
    _state = !_state;
    if (_state) {
        [sender setImage:[UIImage imageNamed:@"白天模式.png"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"夜间模式.png"] forState:(UIControlStateNormal)];
    }
}

// 手势 注册
- (void)tapAction {
    LoginViewController *login = [[LoginViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nc animated:NO completion:nil];
}

#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.array.count;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 15;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return kHeight / 3.0;
    } else {
        return (kHeight - kHeight / 3.0 - 20 - kNaviH) / 6.0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 15)];
        view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        return view;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {

        [cell.contentView addSubview:self.loggedView];
        [cell.contentView addSubview:self.loginView];
        return cell;
    } else {
        [cell cellConfigureModel:self.array[indexPath.row]];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0: {
                NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
                if ([name isEqualToString:@"0"] || name == nil) {
                    LoginViewController *login = [[LoginViewController alloc] init];
                    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:login];
                    [self presentViewController:nc animated:NO completion:nil];
                } else {
                    NSLog(@"已登录");
                }
                
                
                break;
            }
            case 1: {
                NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
                if ([name isEqualToString:@"0"] || name == nil) {
                    LoginViewController *login = [[LoginViewController alloc] init];
                    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:login];
                    [self presentViewController:nc animated:NO completion:nil];
                } else {
                    NSLog(@"已登录");
                }
                break;
            }
            case 2: {
                MyCollectionViewController *myVC = [[MyCollectionViewController alloc] init];
                myVC.itme = 0;
                [self.navigationController pushViewController:myVC animated:NO];
                break;
            }
            case 3: {
                MyCollectionViewController *myVC = [[MyCollectionViewController alloc] init];
                myVC.itme = 1;
                [self.navigationController pushViewController:myVC animated:NO];
                break;
            }
            case 4:
                
                break;
            
            case 5: {
                SetViewController *svc = [[SetViewController alloc] init];
                [self.navigationController pushViewController:svc animated:NO];
                break;
            }
            default:
                break;
        }
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
