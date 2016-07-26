//
//  AppDelegate.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "AppDelegate.h"
#import "RecommendedViewController.h"
#import "ForumViewController.h"
#import "CarViewController.h"
#import "FoundViewController.h"
#import "MyViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
    
    RecommendedViewController *recomVC = [[RecommendedViewController alloc] init];
    ForumViewController *forumVC = [[ForumViewController alloc] init];
    CarViewController *carVC = [[CarViewController alloc] init];
    FoundViewController *foundVC = [[FoundViewController alloc] init];
    MyViewController *myVC = [[MyViewController alloc] init];
    
    UINavigationController *recomNC = [[UINavigationController alloc] initWithRootViewController:recomVC];
    UINavigationController *forumNC = [[UINavigationController alloc] initWithRootViewController:forumVC];
    UINavigationController *carNC = [[UINavigationController alloc] initWithRootViewController:carVC];
    UINavigationController *foundNC = [[UINavigationController alloc] initWithRootViewController:foundVC];
    UINavigationController *myNC = [[UINavigationController alloc] initWithRootViewController:myVC];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.tabBar.backgroundColor = [UIColor whiteColor];
    tabBarVC.viewControllers = @[recomNC, forumNC, carNC, foundNC, myNC];
    
    
    
    recomNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:[UIImage imageNamed:@"recommended.png"] tag:101];
    forumNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"论坛" image:[UIImage imageNamed:@"forum.png"] tag:102];
    carNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"找车" image:[UIImage imageNamed:@"car.png"] tag:103];
    foundNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"found.png"] tag:104];
    myNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"my.png"] tag:105];
    
    recomNC.tabBarController.selectedIndex = 0;

    tabBarVC.delegate = self;
    self.window.rootViewController = tabBarVC;
    
    
    
    //后台播放，只支持真机，不支持模拟器
    //后台播放的步骤
    //1。在info.plist中添加支持后台播放的参数
    //2.配置后台播放代码
    //创建音频会话
    AVAudioSession  *sesson = [AVAudioSession sharedInstance];
    //设置支持后台播放
    [sesson setCategory:AVAudioSessionCategoryPlayback error:nil];
    //激活会话
    [sesson setActive:YES error:nil];
    //支持远程控制
    [application beginReceivingRemoteControlEvents];
    
    
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"1417adb02d8aa"
          activePlatforms:@[
//                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat)]
//                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
//             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
//             case SSDKPlatformTypeSinaWeibo:
//                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                         redirectUri:@"http://www.sharesdk.cn"
//                                            authType:SSDKAuthTypeBoth];
//                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx53c1c7b6d539ce71"
                                       appSecret:@"976b9b7ce84062d642059c9df77177f2"];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"100371282"
//                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
                 
             default:
                 break;
         }
     }];
    return YES;
    
    
    
    
    
    
    
    
    return YES;
}

#pragma mark UITabBarControllerDelegate协议中的方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    viewController.tabBarItem.badgeValue = nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIBackgroundTaskIdentifier taskId = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:taskId];
    }];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
