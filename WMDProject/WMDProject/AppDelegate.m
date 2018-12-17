//
//  AppDelegate.m
//  testCharts
//
//  Created by Shannon MYang on 2018/4/19.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LeftMenuViewController.h"
#import "LoginViewController.h"

NSString * const UserLoginSuccessNotify = @"UserLoginSuccessNotify";
NSString * const UserLogoutSuccessNotify = @"UserLogoutSuccessNotify";


@interface AppDelegate ()
{
    LeftMenuViewController * menuVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self registNotification];
    [self configLoginRootVC];
    
    return YES;
}

- (void)registNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureMainViewController) name:UserLoginSuccessNotify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configLoginRootVC) name:UserLogoutSuccessNotify object:nil];
}

- (void)configLoginRootVC{
    self.mainViewController = nil;
    self.window.rootViewController = nil;
    menuVC = nil;
    
    LoginViewController * loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.window.rootViewController = loginViewController;
    [self.window makeKeyAndVisible];
}

- (void)configureMainViewController {
    ViewController * mainVC = [[ViewController alloc] init];
    self.mainViewController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    menuVC = [[LeftMenuViewController alloc]init];
    [[DYLeftSlipManager sharedManager] setLeftViewController:menuVC coverViewController:self.mainViewController];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:kColorAppMain];
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
