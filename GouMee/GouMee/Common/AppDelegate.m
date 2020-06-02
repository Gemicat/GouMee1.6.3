//
//  AppDelegate.m
//  GouMee
//
//  Created by 白冰 on 2019/12/10.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "AppDelegate.h"
#import "GouMee_TabbarViewController.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_NavigationViewController.h"
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMAnalytics/MobClick.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>
#import <UMShare/UMShare.h>
#import "Goumee_OrderViewController.h"
#import "AccountMessageViewController.h"
#import "GouMee_BalanceViewController.h"
#import "Goumee_OrderDetailViewController.h"
#import "ServiceMessageViewController.h"
#import "GouMee_NavigationViewController.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
      [UMConfigure initWithAppkey:@"5e7c6fe6570df3d26400007f" channel:@"App Store"];
    [UMCommonLogManager setUpUMCommonLogManager];
    [MobClick setScenarioType:E_UM_NORMAL];//支持普通场景
    [UMConfigure setLogEnabled:YES];

    
       // Push's basic setting
       UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
       //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
       entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
       [UNUserNotificationCenter currentNotificationCenter].delegate=self;
       [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                          NSLog(@"注册APNS成功");
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [[UIApplication sharedApplication] registerForRemoteNotifications];
                          });
                          
                      } else {
                          NSLog(@"注册APNS失败");
                      }
       }];
       
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shuai_day"];
     [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shuai_time"];
    [[NSUserDefaults standardUserDefaults]synchronize];
       [[SDImageCache sharedImageCache] clearMemory];
    [self AFNReachability];
    _zxcs = 1;
//    if (isLogin.count > 0) {
        GouMee_TabbarViewController *rootVC = [[GouMee_TabbarViewController alloc]init];
           self.window.rootViewController = rootVC;
//    }
//    else
//    {
//        GouMee_LoginViewController *rootVC = [[GouMee_LoginViewController alloc]init];
//                  GouMee_NavigationViewController *navc = [[GouMee_NavigationViewController alloc]initWithRootViewController:rootVC];
//                  self.window.rootViewController = navc;
//    }
//   
    [self.window makeKeyAndVisible];

    return YES;
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

NSString *error_str = [NSString stringWithFormat: @"%@", error];

NSLog(@"Failed to get token, error:%@", error_str);

}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken

{

[UMessage registerDeviceToken:deviceToken];

NSMutableString *tokenString = [NSMutableString string];
const char *bytes = deviceToken.bytes;
int iCount = deviceToken.length;
for (int i = 0; i < iCount; i++) {
    [tokenString appendFormat:@"%02x", bytes[i]&0x000000FF];
}

NSLog(@"tokenString = %@", tokenString);
    self.deviceToken = tokenString;
    
    
    
    
}

- (void)AFNReachability {
    [Network GET:@"api/v1/system-config/ios_examine_v163/" paramenters:nil success:^(id data) {
                    if (isNotNull(data)) {
                        self.auditStatus = [data[@"data"][@"int_value"] intValue];
                    }
                } error:^(id data) {
                    
                }];
    // 创建网络监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 监听网络状态
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
               
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"暂无网络");
               
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"4G");
               
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
             
                break;
                
            default:
                break;
        }

    }];
    
    // 开启监测
    [manager startMonitoring];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
     if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
            NSLog(@"acitve or background");

        }
        else
        {
            
            
        }
        
        
        completionHandler(UIBackgroundFetchResultNewData);
    }
}


//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
         [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
//      [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNoti" object:userInfo];
        [self presentViewControllerWithPushInfo:userInfo];
        [UMessage didReceiveRemoteNotification:userInfo];


        
    }else{
        //应用处于后台时的本地推送接受
    }
}
- (void)presentViewControllerWithPushInfo:(NSDictionary *)userInfo {



        NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];

        [pushJudge setObject:@"push" forKey:@"push"];

        [pushJudge synchronize];



    NSInteger type = [userInfo[@"type"] intValue];
    if (type == 1) {
        AccountMessageViewController *vc = [[AccountMessageViewController alloc]init];
        GouMee_NavigationViewController *pushNav = [[GouMee_NavigationViewController alloc] initWithRootViewController:vc];

            [self.window.rootViewController presentViewController:pushNav animated:YES completion:nil];
    }
    if (type == 2) {
        GouMee_BalanceViewController *vc = [[GouMee_BalanceViewController alloc]init];
         GouMee_NavigationViewController *pushNav = [[GouMee_NavigationViewController alloc] initWithRootViewController:vc];

            [self.window.rootViewController presentViewController:pushNav animated:YES completion:nil];
    }
    if (type == 3) {

    }
    if (type == 4) {
        Goumee_OrderDetailViewController *vc = [[Goumee_OrderDetailViewController alloc]init];
        vc.ID = [NSString stringWithFormat:@"%@",userInfo[@"resource_id"]];
         GouMee_NavigationViewController *pushNav = [[GouMee_NavigationViewController alloc] initWithRootViewController:vc];

            [self.window.rootViewController presentViewController:pushNav animated:YES completion:nil];
    } if (type == 5) {
        ServiceMessageViewController *vc = [[ServiceMessageViewController alloc]init];
       GouMee_NavigationViewController *pushNav = [[GouMee_NavigationViewController alloc] initWithRootViewController:vc];

            [self.window.rootViewController presentViewController:pushNav animated:YES completion:nil];
    }



}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//控制旋转方向
-  (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  {
    return UIInterfaceOrientationMaskPortrait;
}


//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)setupUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}




@end
