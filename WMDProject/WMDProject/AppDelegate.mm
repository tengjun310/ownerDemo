//
//  AppDelegate.m
//  testCharts
//
//  Created by Shannon MYang on 2018/4/19.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "LoginViewController.h"
#import "IQKeyboardManager.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

NSString * const UserLoginSuccessNotify = @"UserLoginSuccessNotify";
NSString * const UserLogoutSuccessNotify = @"UserLogoutSuccessNotify";

//com.marine.weather

#define KBMKSDKKEY  @"oYGLpjH1ea3hkKomXaxhAKuiiuT1k3Xa"

@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager *mapManager; //主引擎类

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    manager.enable = YES;
    manager.enableAutoToolbar = NO;
    
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:KBMKSDKKEY authDelegate:nil];
    //要使用百度地图，请先启动BMKMapManager
    _mapManager = [[BMKMapManager alloc] init];
    
    /**
     百度地图SDK所有API均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
     默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
     如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
     */
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
        NSLog(@"经纬度类型设置成功");
    } else {
        NSLog(@"经纬度类型设置失败");
    }
    
    //启动引擎并设置AK并设置delegate
    BOOL result = [_mapManager start:KBMKSDKKEY generalDelegate:nil];
    if (!result) {
        NSLog(@"启动引擎失败");
    }
    
    [self registNotification];
    
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:KDefaultUserTokenKey];
    if (token.length == 0) {
        [self configLoginRootVC];
    }
    else{
        [self configureMainViewController];
    }
    
    
    return YES;
}

- (void)registNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureMainViewController) name:UserLoginSuccessNotify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configLoginRootVC) name:UserLogoutSuccessNotify object:nil];
}

- (void)configLoginRootVC{
    self.window.rootViewController = nil;
    self.mainViewController = nil;
    
    LoginViewController * vc = [[LoginViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

- (void)configureMainViewController {
    MainViewController * mainVC = [[MainViewController alloc] init];
    self.mainViewController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    LeftMenuViewController * menuVC = [[LeftMenuViewController alloc]init];
    [[DYLeftSlipManager sharedManager] setLeftViewController:menuVC coverViewController:self.mainViewController];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.window.rootViewController = nil;
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
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


@end
