//
//  CarViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "CarViewController.h"
//#import "BrandTableViewController.h"
#import "BrandViewController.h"
#import "FilterViewController.h"
#import "PriceViewController.h"
#import "UsedCarViewController.h"
@interface CarViewController ()<UIScrollViewDelegate>
// 右滑大scrollview
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *NavView;
@property (nonatomic, strong)UIView *smallView;
@property (nonatomic, strong)BrandViewController *brand;
@property (nonatomic, strong)FilterViewController *filter;
@property (nonatomic, strong)PriceViewController *price;
@property (nonatomic, strong)UsedCarViewController *usedCar;

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1];
    
    // 隐藏导航栏s
    self.navigationController.navigationBarHidden = YES;
    // 创建导航栏按钮
    [self NavigationBarView];
    [self createScrollView];
    
    [self initTableViewController];
    
    
}
#pragma mark  初始化控制器
- (void)initTableViewController{
    
    self.brand = [[BrandViewController alloc]init];
    self.filter = [[FilterViewController alloc]init];
    self.price = [[PriceViewController alloc]init];
    self.usedCar = [[UsedCarViewController alloc]init];
    
    [self addTableViewController:self.brand];
    [self addTableViewController:self.filter];
    [self addTableViewController:self.price];
    [self addTableViewController:self.usedCar];
}
#pragma mark  添加四个控制器
- (void)addTableViewController:(UIViewController *)vc{
    
    if (vc == self.brand) {
        vc.view.frame = CGRectMake(0, 0, W, H - 104);
    }else if (vc == self.filter){
        vc.view.frame = CGRectMake(W, 0, W, H - 104);

    }else if (vc == self.price){
        vc.view.frame = CGRectMake(W * 2, 0, W, H - 104);

    }else if (vc == self.usedCar){
        vc.view.frame = CGRectMake(W * 3, 0, W, H - 104);

    }
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    
}
#pragma mark 创建导航栏  和  按钮
- (void)NavigationBarView{
    
    
    // 毛边玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    effectview.frame = CGRectMake(0, 0, W, 60);
    [self.view addSubview:effectview];
    
    // 创建导航栏背景
    self.NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 59)];
    self.NavView.backgroundColor = [UIColor whiteColor];
    self.NavView.alpha = 1;
    [effectview addSubview:self.NavView];
    
    NSArray *arr = @[@"品牌", @"筛选", @"降价", @"找二手车"];
    
    // 循环创建导航栏上的button
    for (int i = 1; i < 5; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10 + 50 * (i - 1), 30, 80, 20)];
        button.tag = i;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitle:arr[i - 1] forState:(UIControlStateNormal)];
        // 灰色
        [button setTitleColor:[UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget: self action:@selector(NavigationBarButtionAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.NavView addSubview:button];
        if (button.tag == 1) {
            // 蓝色
            [button setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        }
        
    }
    
    self.smallView = [[UIView alloc]initWithFrame:CGRectMake(10, 57, 35, 2)];
    self.smallView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1];
    [self.NavView addSubview: self.smallView];
    
}
#pragma mark 导航栏按钮点击方法
- (void)NavigationBarButtionAction:(UIButton *)sender{
    
    // 点击按钮 更改scrollView 偏移量
    [UIView animateWithDuration:0.3 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(W * sender.tag - W, 0);
        
        self.smallView.frame = CGRectMake(10 + 50 * (sender.tag - 1), 57, 35, 2);
        if (sender.tag == 4) {
            self.smallView.frame = CGRectMake(10 + 50 * (4 - 1), 57, 70, 2);

        }
    }];
    
    // 点击按钮 更改颜色
    for (int i = 1; i < 5; i++) {
        UIButton *bu = [self.view viewWithTag:i];
        if (i == sender.tag) {
            [bu setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        }else{
            [bu setTitleColor:[UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        }
    }
}

#pragma mark 横向滑动大Scrollview
- (void)createScrollView{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, W, H - 44 - 60)];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    self.scrollView.contentSize = CGSizeMake(W * 4, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];

    
}
#pragma mark scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 偏移量改变 按钮变色
    
    [UIView animateWithDuration:0.3 animations:^{
        
    
        for (int i = 0; i < 4; i++) {
            UIButton *bu = [self.view viewWithTag:i + 1];
            
            if (self.scrollView.contentOffset.x ==  W * i) {
                [bu setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
                self.smallView.frame = CGRectMake(10 + 50 * i, 57, 35, 2);
                if (i == 3) {
                    self.smallView.frame = CGRectMake(10 + 50 * (4 - 1), 57, 70, 2);
                }

            }else{
                [bu setTitleColor:[UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1] forState:(UIControlStateNormal)];
            }
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
