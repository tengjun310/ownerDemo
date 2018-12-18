//
//  FirstViewInfoTableViewCell.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "FirstViewInfoTableViewCell.h"

@implementation FirstViewInfoTableViewCell

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = kFontSize28;
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor whiteColor];
        _leftLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _leftLabel.numberOfLines = 0;
    }
    
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = kFontSize26;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.textColor = [UIColor whiteColor];
    }
    
    return _rightLabel;
}

- (UIImageView *)dipImageView{
    if (!_dipImageView) {
        _dipImageView = [[UIImageView alloc]init];
        _dipImageView.backgroundColor = [UIColor hexChangeFloat:@"000000" alpha:0.5];
    }
    
    return _dipImageView;
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
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    
    [self.contentView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView).mas_offset(20);
        make.bottom.mas_equalTo(weakSelf.contentView).mas_offset(-10);
        make.right.mas_equalTo(weakSelf.contentView).mas_offset(-30);
        make.width.mas_offset(150);
    }];
    
    [self.contentView addSubview:self.dipImageView];
    [self.dipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).mas_offset(10);
        make.right.mas_equalTo(weakSelf.contentView).mas_offset(-10);
        make.top.mas_equalTo(weakSelf.contentView).mas_offset(10);
        make.bottom.mas_equalTo(weakSelf.contentView);
    }];
    
    [self.contentView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).mas_offset(15);
        make.centerY.mas_equalTo(weakSelf.dipImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];

    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.logoImageView.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
