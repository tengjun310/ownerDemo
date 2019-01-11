//
//  DirectionInfoModel.h
//  WMDProject
//
//  Created by teng jun on 2019/1/10.
//  Copyright © 2019 Shannon MYang. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DirectionInfoModel : JSONModel

@property (nonatomic,copy) NSString <Optional>* direction;

@property (nonatomic,copy) NSString <Optional>* rate;

@end

NS_ASSUME_NONNULL_END
