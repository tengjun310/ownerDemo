//
//  WeatherInfoModel.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/21.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherInfoModel : JSONModel

@property (nonatomic,copy) NSString <Optional>* daytmp;

@property (nonatomic,copy) NSString <Optional>* nowtmp;

@property (nonatomic,copy) NSString <Optional>* status;

@property (nonatomic,copy) NSString <Optional>* wind;

@property (nonatomic,copy) NSString <Optional>* windGrade;

@property (nonatomic,copy) NSString <Optional>* imageName;

@property (nonatomic,copy) NSString <Optional>* seaLevel;

@property (nonatomic,copy) NSString <Optional>* url;


@end

NS_ASSUME_NONNULL_END
