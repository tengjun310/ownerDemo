//
//  WeatherInfoViewController.h
//  WMDProject
//
//  Created by teng jun on 2018/12/19.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    WeatherInfoType_hailang = 0,
    WeatherInfoType_haixiao = 1,
    WeatherInfoType_fengbaochao = 2,
    WeatherInfoType_haishengwu = 3,
    WeatherInfoType_haibing = 4,
}WeatherInfoType;


@interface WeatherInfoViewController : BaseViewController

@property (nonatomic,assign) WeatherInfoType type;

@property (nonatomic,copy) NSString * titleStr;

@end

NS_ASSUME_NONNULL_END
