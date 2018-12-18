//
//  MenuTableViewCell.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.backgroundColor = [UIColor redColor];
        //        _headImageView.image = [UIImage imageNamed:@"morentouxiang"];
    }
    
    return _logoImageView;
}

- (UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc]init];
        _line.backgroundColor = kColorLineGray;
    }
    
    return _line;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = kFontSize26;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = kColorBlack;
        _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _nameLabel.numberOfLines = 2;
    }
    
    return _nameLabel;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.font = kFontSize24;
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.textColor = kColorBlack;
    }
    
    return _infoLabel;
}

- (UIButton *)msgButton{
    if (!_msgButton) {
        _msgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _msgButton.backgroundColor = kColorAppMain;
        _msgButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_msgButton setTitle:@"登录" forState:UIControlStateNormal];
        [_msgButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_msgButton addTarget:self action:@selector(msgButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _msgButton;
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
        make.left.mas_equalTo(weakSelf.contentView).mas_offset(10);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.logoImageView.mas_right).mas_offset(5);
        make.top.mas_equalTo(weakSelf.contentView).mas_offset(5);
        make.bottom.mas_equalTo(weakSelf.contentView).mas_offset(-5);
        make.width.mas_offset(140);
    }];
    
    [self.contentView addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView).mas_offset(-10);
        make.top.mas_equalTo(weakSelf.contentView).mas_offset(5);
        make.bottom.mas_equalTo(weakSelf.contentView).mas_offset(-5);
        make.width.mas_offset(65);
    }];
    
    [self.contentView addSubview:self.msgButton];
    [self.msgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView).mas_offset(-10);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    self.msgButton.selected = NO;
    
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).mas_offset(10);
        make.right.mas_equalTo(weakSelf.contentView).mas_offset(-10);
        make.bottom.mas_equalTo(weakSelf.contentView).mas_offset(-1);
        make.height.mas_offset(1);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)msgButtonClick:(id)sender{
    self.msgButton.selected = !self.msgButton.selected;
    if (self.messageButtonClick) {
        self.messageButtonClick(self.msgButton.selected);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
