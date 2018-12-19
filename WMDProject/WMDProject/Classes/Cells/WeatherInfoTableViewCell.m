//
//  WeatherInfoTableViewCell.m
//  WMDProject
//
//  Created by teng jun on 2018/12/19.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "WeatherInfoTableViewCell.h"

@implementation WeatherInfoTableViewCell

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = kFontSize28;
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = kColorBlack;
    }
    
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = kFontSize26;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.textColor = kColorBlack;
    }
    
    return _rightLabel;
}

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.backgroundColor = [UIColor redColor];
    }
    
    return _logoImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCellUI];
    }
    
    return self;
}

- (void)configureCellUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    
    [self.contentView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).mas_offset(20);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.logoImageView.mas_right).mas_offset(20);
        make.top.bottom.mas_equalTo(weakSelf.contentView);
        make.width.mas_offset(150);
    }];

    [self.contentView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView).mas_offset(-20);
        make.top.bottom.mas_equalTo(weakSelf.contentView);
        make.width.mas_offset(150);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
