//
//  SecondInfoViewTableViewCell.m
//  WMDProject
//
//  Created by teng jun on 2018/12/18.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "SecondInfoViewTableViewCell.h"

@implementation SecondInfoViewTableViewCell

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = kFontSize28;
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = kColorAppMain;
    }
    
    return _leftLabel;
}

- (UILabel *)warnLabel{
    if (!_warnLabel) {
        _warnLabel = [[UILabel alloc]init];
        _warnLabel.font = kFontSize26;
        _warnLabel.textAlignment = NSTextAlignmentCenter;
        _warnLabel.layer.masksToBounds = YES;
        _warnLabel.layer.cornerRadius = 4;
    }
    
    return _warnLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = kFontSize26;
        _dateLabel.textColor = kColorAppMain;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.numberOfLines = 2;
        _dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _dateLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _dateLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = kFontSize26;
        _timeLabel.textColor = kColorAppMain;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _timeLabel;
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
    
    BOOL isIPhone5 = SCREEN_WIDTH>320?NO:YES;
    
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView).mas_offset(20);
        make.left.mas_equalTo(weakSelf.contentView).mas_offset(isIPhone5?8:15);
        make.bottom.mas_equalTo(weakSelf.contentView).mas_offset(-20);
        make.width.mas_offset(75);
    }];
    
    [self.contentView addSubview:self.warnLabel];
    [self.warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftLabel.mas_right).mas_offset(isIPhone5?10:20);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.warnLabel.mas_right).mas_offset(isIPhone5?6:13);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(75, 35));
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView).mas_offset(isIPhone5?-8:-15);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(75, 30));
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
