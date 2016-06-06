//
//  AppDelegate.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <UMSocial.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import <UMSocialSinaSSOHandler.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor yellowColor];
    [self.window makeKeyAndVisible];

    RootViewController *rootVC = [[RootViewController alloc]init];
    self.window.rootViewController = rootVC;
    
    
#pragma mark -- LeanCloud配置 --
    // 设置AppID和AppKey
    [AVOSCloud setApplicationId:@"94HnxCqr7NY4QODr87sedR36-gzGzoHsz"
                      clientKey:@"tSNO0iEHsWlfootq1PXaxHwR"];
    // 跟踪统计应用的打开情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
#pragma mark -- 友盟分享配置 --
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"5750db84e0f55a2afc00017a"];
    
    // -- 配置第三方平台APPID和scheme
    //设置微信AppId、appSecret，分享url
    // 使用我的的账号申请的AppId和appkey(审核通过）
    [UMSocialWechatHandler setWXAppId:@"wx743f18e48f8823af" appSecret:@"a3f2e30faa4f6f292278230144c90189" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    // 使用温哲的账号申请的AppId和appkey(审核通过）
    [UMSocialQQHandler setQQWithAppId:@"1105375573" appKey:@"mX4pi78e26z6HrY5" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    // 使用我的账号申请的AppId和appkey(审核中）
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2737207096"
                                              secret:@"57dd636af966efda7030cc6568c3d8bb"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
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

#pragma mark --  配置系统回调(友盟分享） --
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
@end
