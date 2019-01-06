//
//  SeaDataInfoModel.h
//  WMDProject
//
//  Created by teng jun on 2018/12/23.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeaDataInfoModel : JSONModel

@property (nonatomic,copy) NSString <Optional>* cellcode;

@property (nonatomic,copy) NSString <Optional>* forecasttime;

@property (nonatomic,copy) NSString <Optional>* fstarttime;

@property (nonatomic,copy) NSString <Optional>* id;

@property (nonatomic,copy) NSString <Optional>* source;

@property (nonatomic,copy) NSString <Optional>* sstdata;

@property (nonatomic,copy) NSString <Optional>* swdirection;

@property (nonatomic,copy) NSString <Optional>* swspeed;

@property (nonatomic,copy) NSString <Optional>* wavedfrom;

@property (nonatomic,copy) NSString <Optional>* waveheight;

@property (nonatomic,copy) NSString <Optional>* type;//2 波高  3 海温 4 海风

@end

NS_ASSUME_NONNULL_END
