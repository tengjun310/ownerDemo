//
//  InfoCollectionViewCell.h
//  WMDProject
//
//  Created by teng jun on 2018/12/20.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView * dipImageView;

@property (nonatomic,strong) UILabel * dateLabel;

@property (nonatomic,strong) UILabel * leftDataLabel;

@property (nonatomic,strong) UILabel * rightDataLabel;

@property (nonatomic,strong) UIImageView * horImageView;

@property (nonatomic,strong) UIImageView * verImageView;

@end

NS_ASSUME_NONNULL_END
