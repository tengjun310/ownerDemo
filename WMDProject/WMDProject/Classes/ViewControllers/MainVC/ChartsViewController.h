//
//  ChartsViewController.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartsViewController : BaseViewController

@property (nonatomic,strong) NSDate * date;

@property (nonatomic,assign) BOOL today;

@property (nonatomic,assign) int type;//1 水位  2 海流

@end

NS_ASSUME_NONNULL_END
