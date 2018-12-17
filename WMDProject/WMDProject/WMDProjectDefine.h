//
//  WMDProjectDefine.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/17.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#ifndef WMDProjectDefine_h
#define WMDProjectDefine_h

#pragma mark - 常用的宏方法
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define PRODUCT_NAME            [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"]
#define PRODUCT_VERSION         [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

#define IsNilNull(obj)          (!obj || [obj isEqual:[NSNull null]])//空判断

#define SCREEN_WIDTH            ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT           ([UIScreen mainScreen].bounds.size.height)

#define WIDTH(view)             view.frame.size.width
#define HEIGHT(view)            view.frame.size.height
#define X(view)                 view.frame.origin.x
#define Y(view)                 view.frame.origin.y
#define LEFT(view)              view.frame.origin.x
#define TOP(view)               view.frame.origin.y
#define BOTTOM(view)            (view.frame.origin.y + view.frame.size.height)
#define RIGHT(view)             (view.frame.origin.x + view.frame.size.width)

#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kStatusBarAndNavigationBarHeight (kIs_iPhoneX ? 88.f : 64.f)

#pragma mark - 常用的颜色

#define kColorBackground         [UIColor hexChangeFloat:@"f1f1f1"] //主背景色
#define kColorListBackground     [UIColor hexChangeFloat:@"f9f9f9"] //邀请列表背景色
#define kColorBlack              [UIColor hexChangeFloat:@"333333"] //字体黑
#define kColorGray               [UIColor hexChangeFloat:@"999999"] //字体灰
#define kColorRed                [UIColor hexChangeFloat:@"f24b4b"] //字体红
#define kColorPurple             [UIColor hexChangeFloat:@"605fbc"] //字体紫
#define kColorLineGray           [UIColor hexChangeFloat:@"dddddd"] //分割线灰
#define kColorAppMain           [UIColor hexChangeFloat:@"333333"] //APP主色


#pragma mark - 常用的字体
#define kFontSize34 [UIFont systemFontOfSize:17]
#define kFontSize30 [UIFont systemFontOfSize:15]
#define kFontSize28 [UIFont systemFontOfSize:14]
#define kFontSize26 [UIFont systemFontOfSize:13]
#define kFontSize24 [UIFont systemFontOfSize:12]


#pragma mark - UserDefault Key
#define KDefaultLoginNameKey        @"KDefaultLoginNameKey"
#define KDefaultPasswordKey         @"KDefaultPasswordKey"

#endif /* WMDProjectDefine_h */
