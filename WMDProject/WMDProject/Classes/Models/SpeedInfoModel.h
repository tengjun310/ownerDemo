//
//  SpeedInfoModel.h
//  WMDProject
//
//  Created by teng jun on 2019/1/11.
//  Copyright © 2019 Shannon MYang. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpeedInfoModel : JSONModel

@property (nonatomic,copy) NSString <Optional>* speed;

@property (nonatomic,copy) NSString <Optional>* rate;

@end

NS_ASSUME_NONNULL_END
