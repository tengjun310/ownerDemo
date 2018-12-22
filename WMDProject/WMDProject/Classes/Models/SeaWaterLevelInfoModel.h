//
//  SeaWaterLevelInfoModel.h
//  WMDProject
//
//  Created by teng jun on 2018/12/22.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeaWaterLevelInfoModel : JSONModel

@property (nonatomic,copy) NSString <Optional>* forecastdate;

@property (nonatomic,copy) NSString <Optional>* tag;

@property (nonatomic,copy) NSString <Optional>* tideheight;

@property (nonatomic,copy) NSString <Optional>* tidetime;

@end

NS_ASSUME_NONNULL_END
