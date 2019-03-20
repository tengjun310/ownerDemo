//
//  AppDelegate.h
//  testCharts
//
//  Created by Shannon MYang on 2018/4/19.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController * mainViewController;

UIKIT_EXTERN NSString * const UserLoginSuccessNotify;
UIKIT_EXTERN NSString * const UserLogoutSuccessNotify;
UIKIT_EXTERN NSString * const CheckoutAPPVersionNotify;
UIKIT_EXTERN NSString * const APPDidBecomeActiveNotify;

@end

