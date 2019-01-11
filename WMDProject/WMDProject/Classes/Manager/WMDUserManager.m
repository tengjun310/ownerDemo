//
//  WMDUserManager.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/17.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "WMDUserManager.h"


@interface WMDUserManager ()

@end

@implementation WMDUserManager

#pragma mark -- 完整的单例实现
+ (WMDUserManager *)shareInstance{
    static WMDUserManager * userManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[self alloc] init];
    });
    
    return userManager;
}

#pragma mark --

- (void)setTokenId:(NSString *)tokenId{
    _tokenId = tokenId;
    [[NSUserDefaults standardUserDefaults] setObject:tokenId forKey:KDefaultUserTokenKey];
}

- (void)setUserName:(NSString *)userName{
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:KDefaultLoginNameKey];
}


@end
