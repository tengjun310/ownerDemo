//
//  FirstInfoView.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "FirstInfoView.h"
#import "FirstViewInfoTableViewCell.h"

@interface FirstInfoView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDate * nextDate1;
    NSDate * nextDate2;
    NSDate * nextDate3;
    NSMutableDictionary * weatherInfoDic;
}
@end

@implementation FirstInfoView

- (UIButton *)userButton{
    if (!_userButton) {
        _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userButton.backgroundColor = [UIColor greenColor];
        [_userButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_userButton addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _userButton;
}

- (UIButton *)weatherInfoButton{
    if (!_weatherInfoButton) {
        _weatherInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weatherInfoButton.backgroundColor = [UIColor clearColor];
        [_weatherInfoButton addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        _weatherInfoButton.titleLabel.numberOfLines = 3;
        _weatherInfoButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _weatherInfoButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _weatherInfoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
    return _weatherInfoButton;
}

- (UIButton *)chartButton{
    if (!_chartButton) {
        _chartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chartButton.backgroundColor = [UIColor clearColor];
        [_chartButton setTitle:@"图表展示" forState:UIControlStateNormal];
        [_chartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _chartButton.titleLabel.font = [UIFont systemFontOfSize:13];
        //        [_chartButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_chartButton addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _chartButton;
}

- (UILabel *)weatherInfoLabel{
    if (!_weatherInfoLabel) {
        _weatherInfoLabel = [[UILabel alloc] init];
        _weatherInfoLabel.backgroundColor = [UIColor clearColor];
        _weatherInfoLabel.numberOfLines = 2;
        _weatherInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _weatherInfoLabel;
}

- (UISegmentedControl *)daysSegmentedControl{
    if (!_daysSegmentedControl) {
        _daysSegmentedControl = [[UISegmentedControl alloc] init];
        _daysSegmentedControl.backgroundColor = [UIColor clearColor];
        _daysSegmentedControl.tintColor = [UIColor whiteColor];
        [_daysSegmentedControl addTarget:self action:@selector(segmentedControlClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _daysSegmentedControl;
}

- (UITableView *)infoTableView{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc] init];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.estimatedRowHeight = 40;
        _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTableView.backgroundColor = [UIColor clearColor];
        _infoTableView.showsVerticalScrollIndicator = NO;
        _infoTableView.showsHorizontalScrollIndicator = NO;
    }
    
    return _infoTableView;
}

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self configureViewUI];
}

- (void)configureViewUI{
    __weak typeof(self) weakSelf = self;
    
    [self addSubview:self.userButton];
    [self.userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).mas_offset(38);
        make.left.mas_equalTo(weakSelf).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self addSubview:self.weatherInfoButton];
    [self.weatherInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).mas_offset(30);
        make.left.mas_equalTo(weakSelf.userButton.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 45));
    }];
    
    [self addSubview:self.chartButton];
    [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).mas_offset(30);
        make.right.mas_equalTo(weakSelf).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self addSubview:self.weatherInfoLabel];
    [self.weatherInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.weatherInfoButton.mas_bottom).mas_offset(25);
        make.left.right.mas_equalTo(weakSelf);
        make.height.mas_offset(100);
    }];
    
    [self addSubview:self.daysSegmentedControl];
    [self.daysSegmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.weatherInfoLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(260, 30));
    }];
    
    [self addSubview:self.infoTableView];
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.daysSegmentedControl.mas_bottom).mas_offset(15);
        make.bottom.mas_equalTo(weakSelf).mas_offset(-20);
        make.left.right.mas_equalTo(weakSelf);
    }];
}

- (void)startWeatherInfoRequest{
    weatherInfoDic = [NSMutableDictionary  dictionary];

    nextDate1 = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    NSString * nextDateStr1 = [CommonUtils formatTime:nextDate1 FormatStyle:@"MM月dd日"];
    nextDate2 = [NSDate dateWithTimeIntervalSinceNow:2*24*60*60];
    NSString * nextDateStr2 = [CommonUtils formatTime:nextDate2 FormatStyle:@"MM月dd日"];
    nextDate3 = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
    NSString * nextDateStr3 = [CommonUtils formatTime:nextDate3 FormatStyle:@"MM月dd日"];
    
    [self.daysSegmentedControl insertSegmentWithTitle:@"今天" atIndex:0 animated:NO];
    [self.daysSegmentedControl insertSegmentWithTitle:nextDateStr1 atIndex:1 animated:NO];
    [self.daysSegmentedControl insertSegmentWithTitle:nextDateStr2 atIndex:2 animated:NO];
    [self.daysSegmentedControl insertSegmentWithTitle:nextDateStr3 atIndex:3 animated:NO];
    self.daysSegmentedControl.selectedSegmentIndex = 0;

    [self getWeatherInfo:[NSDate date]];

    NSString * str1 = @"大连瓦房店市";
    NSString * str2 = @"11月25号 周三";
    NSString * str3 = @"瓦房店市潮汐";
    NSString * str4 = [NSString stringWithFormat:@"%@\n%@\n%@",str1,str2,str3];
    
    NSRange range2 = [str4 rangeOfString:str2];
    NSRange range3 = [str4 rangeOfString:str3];
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str4];
    
    [attrStr setAttributes:@{NSFontAttributeName:kFontSize26,
                             NSForegroundColorAttributeName:kColorGray
                             }
                     range:NSMakeRange(0, str1.length)];
    [attrStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],
                             NSForegroundColorAttributeName:kColorGray
                             }
                     range:range2];
    [attrStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],
                             NSForegroundColorAttributeName:kColorGray
                             }
                     range:range3];
    [self.weatherInfoButton setAttributedTitle:attrStr forState:UIControlStateNormal];
    
    
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
    self.weatherInfoLabel.attributedText = labelAttrStr;
}

#pragma mark -- button events

- (void)buttonClickEvents:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(firstViewButtonClick:)]) {
        [self.delegate firstViewButtonClick:sender];
    }
}

- (void)segmentedControlClick:(UISegmentedControl *)sender{
    if ([self.delegate respondsToSelector:@selector(firstViewSegmentedControlClick:)]) {
        [self.delegate firstViewSegmentedControlClick:sender];
    }
}

#pragma mark -- request
- (void)getWeatherInfo:(NSDate *)date{
    NSString * str = [NSString stringWithFormat:@"marine/getWeather?fstarttime=%@",[CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd"]];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

#pragma mark -- tableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"FirstViewInfoTableViewCell";
    FirstViewInfoTableViewCell * cell = (FirstViewInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FirstViewInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row == 0) {
        cell.leftLabel.text = @"水位";
        
        NSString * str1 = @"03:28 0.85米";
        NSString * str2 = @"08:28 0.83米";
        NSString * str3 = @"16:28 0.86米";
        NSString * str4 = @"22:28 0.88米";
        NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",str1,str2,str3,str4];
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        NSRange range4 = [str rangeOfString:str4];
        NSRange range3 = [str rangeOfString:str3];
        NSRange range2 = [str rangeOfString:str2];

        for (int i=0; i<4; i++) {
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            attch.image = [UIImage imageNamed:@"top_back"];
            attch.bounds = CGRectMake(0, 0, 10, 10);
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            //从后往前插  避免下标在插入图片之后错乱
            if (i == 0) {
                [attrStr insertAttributedString:string atIndex:range4.location];
            }
            else if (i == 1){
                [attrStr insertAttributedString:string atIndex:range3.location];
            }
            else if (i == 2){
                [attrStr insertAttributedString:string atIndex:range2.location];
            }
            else{
                [attrStr insertAttributedString:string atIndex:0];
            }
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距
        paragraphStyle.lineSpacing = 9.0f;
        paragraphStyle.alignment = NSTextAlignmentRight;
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:paragraphStyle
                        range:NSMakeRange(0, str.length)];

        cell.rightLabel.attributedText = attrStr;
        
    }
    else if (indexPath.row == 1){
        cell.leftLabel.text = @"波高";
        cell.rightLabel.text = @"1.0米";
    }
    else if (indexPath.row == 2){
        cell.leftLabel.text = @"海温";
        cell.rightLabel.text = [NSString stringWithFormat:@"1.2%@",KTemperatureSymbol];
    }
    else if (indexPath.row == 3){
        cell.leftLabel.text = @"海风";
        cell.rightLabel.text = @"南风2级";
    }
    else{
        cell.leftLabel.text = [NSString stringWithFormat:@"海流速度\n海流流向"];
        
        NSString * str = [NSString stringWithFormat:@"0.5/1.0\n20/150"];
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距
        paragraphStyle.lineSpacing = 9.0f;
        paragraphStyle.alignment = NSTextAlignmentRight;
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:paragraphStyle
                        range:NSMakeRange(0, str.length)];

        
        cell.rightLabel.text = [NSString stringWithFormat:@"0.5/1.0\n20/150"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tableviewDidSelectRow:)]) {
        [self.delegate tableviewDidSelectRow:indexPath.row];
    }
}

@end
