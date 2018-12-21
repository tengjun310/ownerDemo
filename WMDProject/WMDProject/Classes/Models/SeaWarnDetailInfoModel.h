//
//  SeaWarnDetailInfoModel.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/21.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeaWarnDetailInfoModel : JSONModel

@property (nonatomic,copy) NSString <Optional>* contact;

@property (nonatomic,copy) NSString <Optional>* context;

@property (nonatomic,copy) NSString <Optional>* fax;

@property (nonatomic,copy) NSString <Optional>* id;

@property (nonatomic,copy) NSString <Optional>* identifier;

@property (nonatomic,copy) NSString <Optional>* publishTime;

@property (nonatomic,copy) NSString <Optional>* sign;

@property (nonatomic,copy) NSString <Optional>* source;

@property (nonatomic,copy) NSString <Optional>* tag;

@property (nonatomic,copy) NSString <Optional>* title;

@property (nonatomic,copy) NSString <Optional>* type;

@property (nonatomic,copy) NSString <Optional>* url;

@property (nonatomic,copy) NSString <Optional>* website;

@end

NS_ASSUME_NONNULL_END
