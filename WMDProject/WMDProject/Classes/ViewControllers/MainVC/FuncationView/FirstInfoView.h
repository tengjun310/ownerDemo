//
//  FirstInfoView.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol FirstInfoViewDelegate <NSObject>

@optional

- (void)firstViewButtonClick:(UIButton *)sender Date:(NSDate *)date;

- (void)firstViewSegmentedControlClick:(UISegmentedControl *)sender;

- (void)tableviewDidSelectRow:(NSInteger)row Date:(NSDate *)date;

@end


@interface FirstInfoView : UIView

@property (nonatomic,strong) UIButton * userButton;

@property (nonatomic,strong) UIButton * weatherInfoButton;

@property (nonatomic,strong) UILabel * symbolLabel;

@property (nonatomic,strong) UIButton * chartButton;

@property (nonatomic,strong) UILabel * weatherInfoLabel;

@property (nonatomic,strong) UILabel * temInfoLabel;

@property (nonatomic,strong) UISegmentedControl * daysSegmentedControl;

@property (nonatomic,strong) UITableView * infoTableView;

@property (nonatomic,assign) id <FirstInfoViewDelegate> delegate;

- (void)startWeatherInfoRequest;

@end

NS_ASSUME_NONNULL_END
