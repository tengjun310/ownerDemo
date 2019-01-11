//
//  SeaStreamInfoModel.h
//  WMDProject
//
//  Created by teng jun on 2018/12/22.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeaStreamInfoModel : JSONModel

@property (nonatomic,copy) NSString <Optional>* forecastdate;

@property (nonatomic,copy) NSString <Optional>* id;

@property (nonatomic,copy) NSString <Optional>* source;

@property (nonatomic,copy) NSString <Optional>* time;

@property (nonatomic,copy) NSString <Optional>* wavedfrom;

@property (nonatomic,copy) NSString <Optional>* wavespeed;

@property (nonatomic,copy) NSString <Optional>* imageName;

@property (nonatomic,copy) NSString <Optional>* type;

@end

NS_ASSUME_NONNULL_END
