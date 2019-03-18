//
//  BaseViewController.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic,strong) UIImageView * dipImageView;

@property (nonatomic,assign) BOOL hiddenLeftItem;//默认为yes

- (void)leftItemClick;

@end

NS_ASSUME_NONNULL_END
