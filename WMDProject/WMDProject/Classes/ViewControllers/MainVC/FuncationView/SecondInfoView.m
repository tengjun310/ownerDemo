//
//  SecondInfoView.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "SecondInfoView.h"
#import "SecondInfoViewTableViewCell.h"

@interface SecondInfoView ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation SecondInfoView

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = kFontSize34;
        _titleLabel.text = @"灾害预警";
    }
    
    return _titleLabel;
}

- (UILabel *)weateherInfoLabel{
    if (!_weateherInfoLabel) {
        _weateherInfoLabel = [[UILabel alloc] init];
        _weateherInfoLabel.backgroundColor = [UIColor clearColor];
        _weateherInfoLabel.textAlignment = NSTextAlignmentLeft;
        _weateherInfoLabel.textColor = [UIColor whiteColor];
        _weateherInfoLabel.numberOfLines = 2;
        _weateherInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _weateherInfoLabel;
}

- (UILabel *)tipInfoLabel{
    if (!_tipInfoLabel) {
        _tipInfoLabel = [[UILabel alloc] init];
        _tipInfoLabel.backgroundColor = [UIColor clearColor];
        _tipInfoLabel.textAlignment = NSTextAlignmentRight;
        _tipInfoLabel.textColor = [UIColor whiteColor];
        _tipInfoLabel.font = [UIFont systemFontOfSize:30];
    }
    
    return _tipInfoLabel;
}

- (UILabel *)addressInfoLabel{
    if (!_addressInfoLabel) {
        _addressInfoLabel = [[UILabel alloc] init];
        _addressInfoLabel.backgroundColor = [UIColor clearColor];
        _addressInfoLabel.textAlignment = NSTextAlignmentLeft;
        _addressInfoLabel.textColor = [UIColor whiteColor];
        _addressInfoLabel.font = kFontSize28;
        _addressInfoLabel.text = @"红沿河核电应急部发布";
    }
    
    return _addressInfoLabel;
}

- (UITableView *)infoTableView{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc] init];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.rowHeight = 65;
        _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTableView.backgroundColor = [UIColor clearColor];
        _infoTableView.showsVerticalScrollIndicator = NO;
        _infoTableView.showsHorizontalScrollIndicator = NO;
        _infoTableView.layer.masksToBounds = YES;
        _infoTableView.layer.cornerRadius = 5;
    }
    
    return _infoTableView;
}



- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configureSecondViewUI];
    }
    
    return self;
}

- (void)configureSecondViewUI{
    __weak typeof(self) weakSelf = self;
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).mas_offset(25);
        make.left.right.mas_equalTo(weakSelf);
        make.height.mas_offset(20);
    }];
    
    [self addSubview:self.weateherInfoLabel];
    [self.weateherInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(weakSelf).mas_offset(45);
        make.size.mas_equalTo(CGSizeMake(120, 140));
    }];
    
    [self addSubview:self.tipInfoLabel];
    [self.tipInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.weateherInfoLabel.mas_bottom).mas_offset(-15);
        make.right.mas_equalTo(weakSelf).mas_offset(-25);
        make.size.mas_equalTo(CGSizeMake(65, 30));
    }];

    [self addSubview:self.addressInfoLabel];
    [self.addressInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.weateherInfoLabel.mas_bottom).mas_offset(60);
        make.left.mas_equalTo(weakSelf).mas_offset(45);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    [self addSubview:self.infoTableView];
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.addressInfoLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(weakSelf).mas_offset(20);
        make.right.mas_equalTo(weakSelf).mas_offset(-20);
        make.bottom.mas_equalTo(weakSelf).mas_offset(-10);
    }];
    
    [self configureTableViewHeaderView];
}

- (void)configureTableViewHeaderView{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 45)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, WIDTH(headerView)-30, HEIGHT(headerView))];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:11];
    label1.textColor = kColorBlack;
    label1.textAlignment = NSTextAlignmentRight;
    label1.text = @"预警状态        发布时间      预计持续时间";
    [headerView addSubview:label1];
    
    self.infoTableView.tableHeaderView = headerView;
}

- (void)startSecondInfoViewDataRequest{
#warning TESTCODE
    NSString * str5 = [NSString stringWithFormat:@"15%@",KTemperatureSymbolSimple];
    NSString * str6 = [NSString stringWithFormat:@"25-30%@ %@",KTemperatureSymbol,@"晴到多云"];
    NSString * str7 = [NSString stringWithFormat:@"%@\n%@",str5,str6];
    
    NSRange range4 = [str7 rangeOfString:str6];
    
    NSMutableAttributedString * labelAttrStr = [[NSMutableAttributedString alloc] initWithString:str7];
    
    [labelAttrStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:60],
                                  NSForegroundColorAttributeName:kColorBackground
                                  }
                          range:NSMakeRange(0, str5.length)];
    [labelAttrStr setAttributes:@{NSFontAttributeName:kFontSize28,
                                  NSForegroundColorAttributeName:kColorBackground
                                  }
                          range:range4];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距
    paragraphStyle.lineSpacing = 10.0f;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [labelAttrStr addAttribute:NSParagraphStyleAttributeName
                         value:paragraphStyle
                         range:NSMakeRange(0, str7.length)];
    self.weateherInfoLabel.attributedText = labelAttrStr;

    self.tipInfoLabel.text = @"中潮";
}

#pragma mark -- tableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"SecondInfoViewTableViewCell";
    SecondInfoViewTableViewCell * cell = (SecondInfoViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SecondInfoViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor hexChangeFloat:@"c0c4cb" alpha:.8];
    }
    else{
        cell.backgroundColor = [UIColor hexChangeFloat:@"a4abb1" alpha:.8];
    }
    
    cell.warnLabel.textColor = [UIColor whiteColor];
    if (indexPath.row == 0) {
        cell.leftLabel.text = @"灾害性海浪";
        cell.warnLabel.text = @"红色";
        cell.warnLabel.backgroundColor = kColorRed;
        cell.dateLabel.text = [NSString stringWithFormat:@"11月12号\n15:30"];
        cell.timeLabel.text = [NSString stringWithFormat:@"<24小时"];
    }
    else if (indexPath.row == 1){
        cell.leftLabel.text = @"海啸";
        cell.warnLabel.text = @"橙色";
        cell.warnLabel.backgroundColor = kColorOrige;
        cell.dateLabel.text = [NSString stringWithFormat:@"<12小时\n14:30"];
        cell.timeLabel.text = [NSString stringWithFormat:@"<12小时"];
    }
    else if (indexPath.row == 2){
        cell.leftLabel.text = @"风暴潮";
        cell.warnLabel.text = @"黄色";
        cell.warnLabel.backgroundColor = kColorYellow;
        cell.dateLabel.text = [NSString stringWithFormat:@"<12小时\n08:30"];
        cell.timeLabel.text = [NSString stringWithFormat:@"<12小时"];
    }
    else if (indexPath.row == 3){
        cell.leftLabel.text = @"海生物";
        cell.warnLabel.text = @"黄色";
        cell.warnLabel.backgroundColor = kColorYellow;
        cell.dateLabel.text = [NSString stringWithFormat:@"<12小时\n15:30"];
        cell.timeLabel.text = [NSString stringWithFormat:@"<12小时"];
    }
    else{
        cell.leftLabel.text = @"海冰";
        cell.warnLabel.text = @"解除";
        cell.warnLabel.textColor = kColorBlack;
        cell.warnLabel.backgroundColor = [UIColor whiteColor];
        cell.dateLabel.text = [NSString stringWithFormat:@"<48小时\n15:30"];
        cell.timeLabel.text = [NSString stringWithFormat:@"<48小时"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(secondInfoViewTableviewDidSelectRow:)]) {
        [self.delegate secondInfoViewTableviewDidSelectRow:indexPath.row];
    }
}

@end
