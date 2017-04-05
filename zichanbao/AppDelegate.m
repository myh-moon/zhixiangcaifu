//
//  AppDelegate.m
//  zichanbao
//
//  Created by zhixiang on 15/10/8.
//  Copyright (c) 2015年 zhixiang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GuideViewController.h"

//分享统计
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "MobClick.h"
#import "UMessage.h"

//环信
//#import "EaseMob.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.applicationSupportsShakeToEdit = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //判断是否是首次登录
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"first"];
    NSString *value = [settings objectForKey:key];
    if (!value) {//首次登录
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        self.window.rootViewController = guideVC;
        [[NSUserDefaults standardUserDefaults] setObject:@"first" forKey:@"first"];
    }else{
        ViewController *viewController = [[ViewController alloc] init];
        self.window.rootViewController = viewController;
        [self changeTabBarStyle];
    }
    
    [UMSocialData setAppKey:ZXUmengAppKey];
    
//    微信
    [UMSocialWechatHandler setWXAppId:WXAppID appSecret:WXAppSecret url:ZXUmengAppUrl];
//    //QQ
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKey url:ZXUmengAppUrl];
//
    //统计下载量
    [self configurationUmengAnalytics];
    
//    //推送
//   // 1.注册 （Let the device know we want to receive push notifications）
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeBadge|UIUserNotificationTypeAlert) categories:nil]];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//    }else{
//        
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
//    }
//    //2.
//    [UMessage startWithAppkey:ZXUmengAppKey launchOptions:launchOptions];
//    //由于iOS8的推送与以往版本不同，所以要针对iOS8以上的版本进行判断：
//    if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
//        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//        action1.identifier = @"action1_identifier";
//        action1.title = @"accept";
//        //当点击的时候启动程序
//        action1.activationMode = UIUserNotificationActivationModeForeground;
//    
//        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
//        action2.identifier = @"action2.identifier";
//        action2.title = @"reject";
//        //当点击的时候不启动程序，在后台处理
//        action2.activationMode = UIUserNotificationActivationModeBackground;
//        //需要解锁才能处理
//        action2.authenticationRequired = YES;
//        action2.destructive = YES;
//        
//        UIMutableUserNotificationCategory *categary = [[UIMutableUserNotificationCategory alloc] init];
//        //这组动作的唯一标识
//        categary.identifier = @"categary.identifier";
//        [categary setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObjects:categary, nil]];
//        [UMessage registerRemoteNotificationAndUserNotificationSettings:settings];
//    }else{
//        //注册消息推送类型
//        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound];
//    }
//    
//    
//    //3.设置是否允许SDK自动清空角标（默认开启）
//    [UMessage setBadgeClear:YES];
//    //4.设置是否允许SDK当应用在前台运行收到Push时弹出Alert框（默认开启）
////    [UMessage setAutoAlert:NO];
//    //5.打开调试日志
//    [UMessage setLogEnabled:YES];
//    //6.设置当前 App 的发布渠道（默认"App Store"）
//    [UMessage setChannel:@"App Store"];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

//修改TabBar样式
-(void)changeTabBarStyle
{
    [[UITabBar appearance] setBackgroundColor:RGBCOLOR(0.9216, 0.9255, 0.9294)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:0];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigationColor} forState:UIControlStateSelected];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"com.zhixiangcf.zxcf"]];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if (url) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"你唤醒了您的应用" delegate:selfcancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您唤醒了你的应用" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *act0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    }
    return YES;
}
///**
// 这里处理微信分享完成之后跳转回来
// */
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
//    return  [UMSocialSnsService handleOpenURL:url];
//}

/**
 配置友盟统计SDK
 */
-(void)configurationUmengAnalytics
{
    [MobClick setAppVersion:XcodeAppVersion];
    
    //注册app
    [MobClick startWithAppkey:ZXUmengAppKey reportPolicy:REALTIME channelId:nil];
    
    /**设置是否对日志进行加密 ，默认为NO*/
    [MobClick setEncryptEnabled:YES];
    
    /**设置是否开启background后台模式，默认YES*/
    [MobClick setBackgroundTaskEnabled:YES];
    
    /**友盟iOS统计SDK默认自带错误分析功能，不需要开发者手动调用
     如果开发者自己做了错误捕捉，可以调用下面方法关闭友盟的统计错误
     */
    //    [MobClick setCrashReportEnabled:YES];
}

////推送方法
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
//{
//    NSLog(@"deviceToken is %@",deviceToken);
//    [UMessage registerDeviceToken:deviceToken];
//}
//
//-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    NSLog(@"error is %@",error);
//}
//
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    [UMessage didReceiveRemoteNotification:userInfo];
//    //自定义弹出框后，想补发前台的消息的点击统计
//    [UMessage sendClickReportForRemoteNotification:userInfo];
//}

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

@end
