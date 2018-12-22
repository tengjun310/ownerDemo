//
//  MenuTableViewCell.h
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MessageButtonClick)(BOOL selected);

@interface MenuTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * logoImageView;

@property (nonatomic,strong) UIImageView * line;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * infoLabel;

@property (nonatomic,strong) UIButton * msgButton;

@property (nonatomic,copy) MessageButtonClick messageButtonClick;

@end

NS_ASSUME_NONNULL_END
