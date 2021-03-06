//
//  WMDUserManager.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/17.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMDUserManager : NSObject

+ (WMDUserManager *)shareInstance;

@property (nonatomic,copy) NSString * tokenId;

@property (nonatomic,copy) NSString * userName;

@property (nonatomic,strong) WeatherInfoModel * currentWeaInfoModel;

@property (nonatomic,strong) WeatherInfoModel * selectWeaInfoModel;

@end

NS_ASSUME_NONNULL_END
