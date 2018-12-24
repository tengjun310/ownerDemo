//
//  InfoCollectionViewCell.m
//  WMDProject
//
//  Created by teng jun on 2018/12/20.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "InfoCollectionViewCell.h"

@implementation InfoCollectionViewCell

- (UIImageView *)dipImageView{
    if (!_dipImageView) {
        _dipImageView = [[UIImageView alloc] init];
        _dipImageView.backgroundColor = [UIColor clearColor];
        _dipImageView.layer.masksToBounds = YES;
        _dipImageView.layer.borderColor = kColorRed.CGColor;
        _dipImageView.layer.borderWidth = 1;
    }
    
    return _dipImageView;
}

- (UIImageView *)horImageView{
    if (!_horImageView) {
        _horImageView = [[UIImageView alloc] init];
        _horImageView.backgroundColor = kColorLineGray;
    }
    
    return _horImageView;
}

- (UIImageView *)verImageView{
    if (!_verImageView) {
        _verImageView = [[UIImageView alloc] init];
        _verImageView.backgroundColor = kColorLineGray;
    }
    
    return _verImageView;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = kFontSize28;
        _dateLabel.textColor = kColorGray;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.numberOfLines = 2;
        _dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _dateLabel;
}

- (UILabel *)leftDataLabel{
    if (!_leftDataLabel) {
        _leftDataLabel = [[UILabel alloc] init];
        _leftDataLabel.backgroundColor = [UIColor clearColor];
        _leftDataLabel.font = [UIFont systemFontOfSize:8];
        _leftDataLabel.textColor = kColorBlack;
        _leftDataLabel.textAlignment = NSTextAlignmentLeft;
        _leftDataLabel.numberOfLines = 5;
        _leftDataLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _leftDataLabel;
}

- (UILabel *)rightDataLabel{
    if (!_rightDataLabel) {
        _rightDataLabel = [[UILabel alloc] init];
        _rightDataLabel.backgroundColor = [UIColor clearColor];
        _rightDataLabel.font = [UIFont systemFontOfSize:8];
        _rightDataLabel.textColor = kColorBlack;
        _rightDataLabel.textAlignment = NSTextAlignmentRight;
        _rightDataLabel.numberOfLines = 5;
        _rightDataLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _rightDataLabel;
}

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configureCellUI];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self configureCellUI];
}

- (void)configureCellUI{
    __weak typeof(self) weakSelf = self;
    
    [self.contentView addSubview:self.dipImageView];
    [self.dipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
    
    [self.contentView addSubview:self.horImageView];
    [self.horImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView);
        make.top.bottom.mas_equalTo(weakSelf.contentView);
        make.width.mas_offset(1);
    }];

    [self.contentView addSubview:self.verImageView];
    [self.verImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.left.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_offset(1);
    }];

    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_offset(52);
    }];
    
    [self.contentView addSubview:self.leftDataLabel];
    [self.leftDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dateLabel.mas_bottom);
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.contentView).mas_offset(2);
        make.width.mas_offset(SCREEN_WIDTH/14-2);
    }];

    [self.contentView addSubview:self.rightDataLabel];
    [self.rightDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dateLabel.mas_bottom);
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView).mas_offset(-2);
        make.width.mas_offset(SCREEN_WIDTH/14-2);
    }];
}

@end
