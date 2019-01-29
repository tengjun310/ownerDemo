//
//  ListInfoViewController.h
//  WMDProject
//
//  Created by teng jun on 2018/12/24.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListInfoViewController : BaseViewController

@property (nonatomic,copy) NSString * titleStr;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,assign) int type;//1 水位  2 流速  3 海温 4 波高  5 海风

@end

NS_ASSUME_NONNULL_END
