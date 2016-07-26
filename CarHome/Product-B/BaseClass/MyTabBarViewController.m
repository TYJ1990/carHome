//
//  MyTabBarViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "RecommendedViewController.h"
#import "ForumViewController.h"
#import "CarViewController.h"
#import "FoundViewController.h"
#import "MyViewController.h"
@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)createTabBar {
    RecommendedViewController *recomVC = [[RecommendedViewController alloc] init];
    ForumViewController *forumVC = [[ForumViewController alloc] init];
    CarViewController *carVC = [[CarViewController alloc] init];
    FoundViewController *foundVC = [[FoundViewController alloc] init];
    MyViewController *myVC = [[MyViewController alloc] init];
    
    UINavigationController *recomNC = [self createNaVC:recomVC title:@"推荐" image:[UIImage imageNamed:@"recommended.png"]];
    UINavigationController *forumNC = [self createNaVC:forumVC title:@"论坛" image:[UIImage imageNamed:@"forum.png"]];
    UINavigationController *carNC = [self createNaVC:carVC title:@"找车" image:[UIImage imageNamed:@"car.png"]];
    UINavigationController *foundNC = [self createNaVC:foundVC title:@"发现" image:[UIImage imageNamed:@"found.png"]];
    UINavigationController *myNC = [self createNaVC:myVC title:@"我的" image:[UIImage imageNamed:@"my.png"]];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    
    tabBarVC.viewControllers = @[recomNC, forumNC, carNC, foundNC, myNC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UINavigationController *)createNaVC:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image{
    vc.title = title;
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:vc];
    naVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:image tag:100];
    return naVC;
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
