//
//  WMDUserManager.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/17.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "WMDUserManager.h"


@interface WMDUserManager ()<NSCopying,NSMutableCopying>

@end

@implementation WMDUserManager

#pragma mark -- 完整的单例实现
+ (WMDUserManager *)shareInstance{
    static WMDUserManager * userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[WMDUserManager alloc] init];
    });
    
    return userManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shareInstance];
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}

#pragma mark --






@end
