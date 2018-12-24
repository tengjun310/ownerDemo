//
//  ListInfoTableViewCell.m
//  WMDProject
//
//  Created by teng jun on 2018/12/24.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "ListInfoTableViewCell.h"

@implementation ListInfoTableViewCell

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.font = kFontSize26;
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.textColor = kColorAppMain;
    }
    
    return _infoLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = kFontSize26;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = kColorAppMain;
    }
    
    return _timeLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).mas_offset(15);
            make.width.mas_offset(180);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).mas_offset(-15);
            make.width.mas_offset(60);
        }];
    }
    
    return self;
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
