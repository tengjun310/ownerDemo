//
//  SecondInfoView.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeaWranInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SecondInfoViewDelegate <NSObject>

@optional

- (void)secondInfoViewTableviewDidSelect:(SeaWranInfoModel *)infoModel;

@end


@interface SecondInfoView : UIView

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * weateherInfoLabel;

@property (nonatomic,strong) UILabel * symbolLabel;

@property (nonatomic,strong) UILabel * tipInfoLabel;

@property (nonatomic,strong) UILabel * addressInfoLabel;

@property (nonatomic,strong) UITableView * infoTableView;

@property (nonatomic,assign) id <SecondInfoViewDelegate> delegate;

- (void)startSecondInfoViewDataRequest;

@end

NS_ASSUME_NONNULL_END
