//
//  FirstInfoView.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "FirstInfoView.h"
#import "FirstViewInfoTableViewCell.h"
#import "WeatherInfoModel.h"
#import "SeaStreamInfoModel.h"
#import "SeaWaterLevelInfoModel.h"
#import "SeaDataInfoModel.h"

@interface FirstInfoView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDate * nowDate;
    NSDate * nextDate1;
    NSDate * nextDate2;
    NSDate * nextDate3;
    NSMutableDictionary * weatherInfoDic;
    NSMutableDictionary * seaStreamInfoDic;
    NSMutableDictionary * seaInfoDic;
    NSMutableDictionary * seaWaterLevelInfoDic;
}
@end

@implementation FirstInfoView

- (UIButton *)userButton{
    if (!_userButton) {
        _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userButton.backgroundColor = [UIColor clearColor];
        [_userButton setImage:[UIImage imageNamed:@"ico_user"] forState:UIControlStateNormal];
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
        [_chartButton setImage:[UIImage imageNamed:@"icon_small_tubiao"] forState:UIControlStateNormal];
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

- (UILabel *)symbolLabel{
    if (!_symbolLabel) {
        _symbolLabel = [[UILabel alloc] init];
        _symbolLabel.backgroundColor = [UIColor clearColor];
        _symbolLabel.font = [UIFont systemFontOfSize:40];
        _symbolLabel.textColor = [UIColor whiteColor];
        _symbolLabel.textAlignment = NSTextAlignmentLeft;
        _symbolLabel.text = KTemperatureSymbol;
    }
    
    return _symbolLabel;
}

- (UISegmentedControl *)daysSegmentedControl{
    if (!_daysSegmentedControl) {
        _daysSegmentedControl = [[UISegmentedControl alloc] init];
        _daysSegmentedControl.backgroundColor = [UIColor clearColor];
        _daysSegmentedControl.tintColor = [UIColor whiteColor];
        [_daysSegmentedControl addTarget:self action:@selector(segmentedControlClick:) forControlEvents:UIControlEventValueChanged];
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
    
    self.chartButton.imageEdgeInsets = UIEdgeInsetsMake(5, 55, 5, 5);
    self.chartButton.titleEdgeInsets = UIEdgeInsetsMake(8, -70, 5, 0);
    
    [self addSubview:self.weatherInfoLabel];
    [self.weatherInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.weatherInfoButton.mas_bottom).mas_offset(25);
        make.left.right.mas_equalTo(weakSelf);
        make.height.mas_offset(100);
    }];
    
    [self addSubview:self.symbolLabel];
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.weatherInfoLabel.mas_top);
        make.left.mas_equalTo(weakSelf.weatherInfoLabel.mas_centerX).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 45));
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
    
    self.infoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startWeatherInfoRequest)];
}

- (void)startWeatherInfoRequest{
    weatherInfoDic = nil;
    weatherInfoDic = [NSMutableDictionary  dictionary];
    seaStreamInfoDic = nil;
    seaStreamInfoDic = [NSMutableDictionary  dictionary];
    seaInfoDic = nil;
    seaInfoDic = [NSMutableDictionary  dictionary];
    seaWaterLevelInfoDic = nil;
    seaWaterLevelInfoDic = [NSMutableDictionary  dictionary];

    nowDate = [NSDate date];
    nextDate1 = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    NSString * nextDateStr1 = [CommonUtils formatTime:nextDate1 FormatStyle:@"MM月dd日"];
    nextDate2 = [NSDate dateWithTimeIntervalSinceNow:2*24*60*60];
    NSString * nextDateStr2 = [CommonUtils formatTime:nextDate2 FormatStyle:@"MM月dd日"];
    nextDate3 = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
    NSString * nextDateStr3 = [CommonUtils formatTime:nextDate3 FormatStyle:@"MM月dd日"];
    
    [self.daysSegmentedControl removeAllSegments];
    [self.daysSegmentedControl insertSegmentWithTitle:@"今天" atIndex:0 animated:NO];
    [self.daysSegmentedControl insertSegmentWithTitle:nextDateStr1 atIndex:1 animated:NO];
    [self.daysSegmentedControl insertSegmentWithTitle:nextDateStr2 atIndex:2 animated:NO];
    [self.daysSegmentedControl insertSegmentWithTitle:nextDateStr3 atIndex:3 animated:NO];
    self.daysSegmentedControl.selectedSegmentIndex = 0;

    [self getWeatherInfo:nowDate];
    [self getSeaStremSpeedData:nowDate];
    [self getSeaData:nowDate];
    [self getSeaWaterLevel:nowDate];
    [self refreshWeatherButtonInfoUI];
}

- (void)refreshWeatherButtonInfoUI{
    NSString * str1 = @"大连瓦房店市";
    
    NSString * dateStr = [CommonUtils formatTime:[NSDate date] FormatStyle:@"MM月dd号"];
    NSString * weekStr = [CommonUtils weekdayCompletedStringFromDate:[NSDate date]];
    NSString * str2 = [NSString stringWithFormat:@"%@ %@",dateStr,weekStr];
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
}

- (void)refreshWeatherInfoUI:(NSDate *)date{
    WeatherInfoModel * model = [weatherInfoDic objectForKey:date];
    
    NSString * str5 = [NSString stringWithFormat:@"%@",model.nowtmp];
    if ([str5 containsString:KTemperatureSymbol]) {
        str5 = [str5 substringToIndex:str5.length-1];
    }
    NSString * str6 = [NSString stringWithFormat:@"%@ %@ %@ %@",model.daytmp,model.status,model.wind,model.windGrade];
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
    
    if (model.nowtmp.length > 2) {
        [self.symbolLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.weatherInfoLabel.mas_centerX).mas_offset(38);
        }];
    }
}

#pragma mark -- button events

- (void)buttonClickEvents:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(firstViewButtonClick:Date:)]) {
        NSDate * date;
        if (self.daysSegmentedControl.selectedSegmentIndex == 0) {
            date = nowDate;
        }
        else if (self.daysSegmentedControl.selectedSegmentIndex == 1){
            date = nextDate1;
        }
        else if (self.daysSegmentedControl.selectedSegmentIndex == 2){
            date = nextDate2;
        }
        else{
            date = nextDate3;
        }
        [self.delegate firstViewButtonClick:sender Date:date];
    }
}

- (void)segmentedControlClick:(UISegmentedControl *)sender{
    if ([self.delegate respondsToSelector:@selector(firstViewSegmentedControlClick:)]) {
        [self.delegate firstViewSegmentedControlClick:sender];
    }
    
    //判断天气数据是否已经请求到
    NSDate * date;
    if (sender.selectedSegmentIndex == 0) {
        date = nowDate;
    }
    else if (sender.selectedSegmentIndex == 1){
        date = nextDate1;
    }
    else if (sender.selectedSegmentIndex == 2){
        date = nextDate2;
    }
    else{
        date = nextDate3;
    }
    
    //天气数据
    WeatherInfoModel * model = [weatherInfoDic objectForKey:date];
    if (!model) {
        [self getWeatherInfo:date];
    }
    else{
        [self refreshWeatherInfoUI:date];
    }
    
    //海流数据
    SeaStreamInfoModel * streamModel = [seaStreamInfoDic objectForKey:date];
    if (!streamModel) {
        [self getSeaStremSpeedData:date];
    }
    else{
        NSIndexPath * path = [NSIndexPath indexPathForRow:4 inSection:0];
        [self.infoTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }

    //海波、海温、海风数据
    SeaDataInfoModel * seaModel = [seaInfoDic objectForKey:date];
    if (!seaModel) {
        [self getSeaData:date];
    }
    else{
        NSIndexPath * path1 = [NSIndexPath indexPathForRow:1 inSection:0];
        NSIndexPath * path2 = [NSIndexPath indexPathForRow:2 inSection:0];
        NSIndexPath * path3 = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.infoTableView reloadRowsAtIndexPaths:@[path1,path2,path3] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    //水位数据
    NSArray * arr = [seaWaterLevelInfoDic objectForKey:date];
    if (IsNilNull(arr) || arr.count == 0) {
        [self getSeaWaterLevel:date];
    }
    else{
        NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.infoTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark -- request
- (void)getWeatherInfo:(NSDate *)date{
    NSString * str = [NSString stringWithFormat:@"marine/getWeather?fstarttime=%@",[CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd HH:mm:ss"]];

    [HttpClient asyncSendPostRequest:str Parmas:@{} SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSDictionary * contentDic = [dic objectForKey:@"content"];
            WeatherInfoModel * infoModel = [[WeatherInfoModel alloc] initWithDictionary:contentDic error:nil];
            [self->weatherInfoDic setObject:infoModel forKey:date];
            [self refreshWeatherInfoUI:date];
            if (date == self->nowDate) {
                //发通知 更新做菜单栏显示天气数据
                [WMDUserManager shareInstance].currentWeaInfoModel = infoModel;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshShowWeatherNotify" object:nil];
            }
        }
        [self.infoTableView.mj_header endRefreshing];
    } FailBlock:^(NSError *error) {
        [self.infoTableView.mj_header endRefreshing];
    }];
}

//海流数据
- (void)getSeaStremSpeedData:(NSDate *)date{
    NSString * str = @"";
    if (date == nowDate) {
        NSString * dateStr = [CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        str = [NSString stringWithFormat:@"marine/getSeaStream?fstarttime=%@&fendtime=%@",dateStr,dateStr];
    }
    else{
        NSString * dateStr = [CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd 00:00:00"];
        str = [NSString stringWithFormat:@"marine/getSeaStream?fstarttime=%@&fendtime=%@",dateStr,dateStr];
    }
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * contentArr = [dic objectForKey:@"content"];
            NSDictionary * info = [contentArr lastObject];
            SeaStreamInfoModel * infoModel = [[SeaStreamInfoModel alloc] initWithDictionary:info error:nil];
            [self->seaStreamInfoDic setObject:infoModel forKey:date];
            NSIndexPath * path = [NSIndexPath indexPathForRow:4 inSection:0];
            [self.infoTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

//波高、海温、海风数据
- (void)getSeaData:(NSDate *)date{
    NSString * str = @"";
    if (date == nowDate) {
        NSString * dateStr = [CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        str = [NSString stringWithFormat:@"marine/getMarineData?fstarttime=%@&fendtime=%@",dateStr,dateStr];
    }
    else{
        NSString * dateStr = [CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd 00:00:00"];
        str = [NSString stringWithFormat:@"marine/getMarineData?fstarttime=%@&fendtime=%@",dateStr,dateStr];
    }
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * contentArr = [dic objectForKey:@"content"];
            NSDictionary * info = [contentArr lastObject];
            SeaDataInfoModel * infoModel = [[SeaDataInfoModel alloc] initWithDictionary:info error:nil];
            [self->seaInfoDic setObject:infoModel forKey:date];
            NSIndexPath * path1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * path2 = [NSIndexPath indexPathForRow:2 inSection:0];
            NSIndexPath * path3 = [NSIndexPath indexPathForRow:3 inSection:0];
            [self.infoTableView reloadRowsAtIndexPaths:@[path1,path2,path3] withRowAnimation:UITableViewRowAnimationNone];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

//水位
- (void)getSeaWaterLevel:(NSDate *)date{
    NSString * str = @"";
    if (date == nowDate) {
        NSString * dateStr = [CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        str = [NSString stringWithFormat:@"marine/getTide?fstarttime=%@&fendtime=%@",dateStr,dateStr];
    }
    else{
        NSString * dateStr = [CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd 00:00:00"];
        str = [NSString stringWithFormat:@"marine/getTide?fstarttime=%@&fendtime=%@",dateStr,dateStr];
    }
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * contentArr = [dic objectForKey:@"content"];
            NSMutableArray * arr = [NSMutableArray array];
            for (NSDictionary * data in contentArr) {
                SeaWaterLevelInfoModel * model = [[SeaWaterLevelInfoModel alloc] initWithDictionary:data error:nil];
                [arr addObject:model];
            }
            [self->seaWaterLevelInfoDic setObject:arr forKey:date];
            NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.infoTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
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
    
    NSDate * date;
    if (self.daysSegmentedControl.selectedSegmentIndex == 0) {
        date = nowDate;
    }
    else if (self.daysSegmentedControl.selectedSegmentIndex == 1){
        date = nextDate1;
    }
    else if (self.daysSegmentedControl.selectedSegmentIndex == 2){
        date = nextDate2;
    }
    else {
        date = nextDate3;
    }
    
    if (indexPath.row == 0) {
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_shuiwei"];
        cell.leftLabel.text = @"水位";
        
        NSArray * arr = [seaWaterLevelInfoDic objectForKey:date];
        if (arr.count == 0) {
            return cell;
        }
        
        NSString * str1 = @"";
        NSString * str2 = @"";
        NSString * str3 = @"";
        NSString * str4 = @"";
        
        if (arr.count == 1) {
            SeaWaterLevelInfoModel * model = [arr lastObject];
            str1 = [NSString stringWithFormat:@"%@ %0.2f米",model.tidetime,[model.tideheight floatValue]];
            NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str1];
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            attch.image = [UIImage imageNamed:[model.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
            attch.bounds = CGRectMake(0, 0, 10, 10);
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attrStr insertAttributedString:string atIndex:0];
            cell.rightLabel.attributedText = attrStr;
        }
        else if (arr.count == 2){
            SeaWaterLevelInfoModel * model1 = [arr lastObject];
            SeaWaterLevelInfoModel * model2 = [arr firstObject];
            str1 = [NSString stringWithFormat:@"%@ %0.2f米",model1.tidetime,[model1.tideheight floatValue]];
            str2 = [NSString stringWithFormat:@"%@ %0.2f米",model2.tidetime,[model2.tideheight floatValue]];
            NSString * str = [NSString stringWithFormat:@"%@\n%@",str1,str2];

            NSRange range2 = [str rangeOfString:str2];

            NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            
            for (int i=0; i<2; i++) {
                NSTextAttachment *attch = [[NSTextAttachment alloc] init];
                attch.bounds = CGRectMake(0, 0, 10, 10);

                if (i == 0) {
                    attch.image = [UIImage imageNamed:[model2.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
                else{
                    attch.image = [UIImage imageNamed:[model1.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
                
                NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];

                //从后往前插  避免下标在插入图片之后错乱
                if (i == 0) {
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
        else if (arr.count == 3){
            SeaWaterLevelInfoModel * model1 = [arr lastObject];
            SeaWaterLevelInfoModel * model2 = [arr objectAtIndex:arr.count-2];
            SeaWaterLevelInfoModel * model3 = [arr firstObject];

            str1 = [NSString stringWithFormat:@"%@ %0.2f米",model1.tidetime,[model1.tideheight floatValue]];
            str2 = [NSString stringWithFormat:@"%@ %0.2f米",model2.tidetime,[model2.tideheight floatValue]];
            str3 = [NSString stringWithFormat:@"%@ %0.2f米",model3.tidetime,[model3.tideheight floatValue]];

            NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@",str1,str2,str3];
            NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            
            NSRange range3 = [str rangeOfString:str3];
            NSRange range2 = [str rangeOfString:str2];
            
            for (int i=0; i<3; i++) {
                NSTextAttachment *attch = [[NSTextAttachment alloc] init];
                attch.bounds = CGRectMake(0, 0, 10, 10);

                if (i == 0) {
                    attch.image = [UIImage imageNamed:[model3.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
                else if (i == 1){
                    attch.image = [UIImage imageNamed:[model2.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
                else{
                    attch.image = [UIImage imageNamed:[model1.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
                NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
                //从后往前插  避免下标在插入图片之后错乱
                if (i == 0) {
                    [attrStr insertAttributedString:string atIndex:range3.location];
                }
                else if (i == 1){
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
        else{
            SeaWaterLevelInfoModel * model1 = [arr lastObject];
            SeaWaterLevelInfoModel * model2 = [arr objectAtIndex:arr.count-2];
            SeaWaterLevelInfoModel * model3 = [arr objectAtIndex:arr.count-3];
            SeaWaterLevelInfoModel * model4 = [arr objectAtIndex:arr.count-4];
            str1 = [NSString stringWithFormat:@"%@ %0.2f米",model1.tidetime,[model1.tideheight floatValue]];
            str2 = [NSString stringWithFormat:@"%@ %0.2f米",model2.tidetime,[model2.tideheight floatValue]];
            str3 = [NSString stringWithFormat:@"%@ %0.2f米",model3.tidetime,[model3.tideheight floatValue]];
            str4 = [NSString stringWithFormat:@"%@ %0.2f米",model4.tidetime,[model3.tideheight floatValue]];

            NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",str1,str2,str3,str4];
            NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            
            NSRange range4 = [str rangeOfString:str4];
            NSRange range3 = [str rangeOfString:str3];
            NSRange range2 = [str rangeOfString:str2];
            
            for (int i=0; i<4; i++) {
                NSTextAttachment *attch = [[NSTextAttachment alloc] init];
                if (i == 0) {
                    attch.image = [UIImage imageNamed:[model4.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
                else if (i == 1){
                    attch.image = [UIImage imageNamed:[model3.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
                else if (i == 2){
                    attch.image = [UIImage imageNamed:[model2.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
                else{
                    attch.image = [UIImage imageNamed:[model1.tag isEqualToString:@"高潮"]?@"ico_shuiwei_shang":@"ico_shuiwei_xia"];
                }
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
    }
    else if (indexPath.row == 1){
        SeaDataInfoModel * infoModel = [seaInfoDic objectForKey:date];
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_bogao"];
        cell.leftLabel.text = @"波高";
        cell.rightLabel.text = [NSString stringWithFormat:@"%@米",infoModel.waveheight];
    }
    else if (indexPath.row == 2){
        SeaDataInfoModel * infoModel = [seaInfoDic objectForKey:date];
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_haiwen"];
        cell.leftLabel.text = @"海温";
        cell.rightLabel.text = [NSString stringWithFormat:@"%@%@",infoModel.sstdata,KTemperatureSymbol];
    }
    else if (indexPath.row == 3){
        SeaDataInfoModel * infoModel = [seaInfoDic objectForKey:date];
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_haifeng"];
        cell.leftLabel.text = @"海风";
        cell.rightLabel.text = [NSString stringWithFormat:@"%@m/s %@",infoModel.swspeed,infoModel.wavedfrom];
    }
    else{
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_liusuliuxiang"];
        cell.leftLabel.text = [NSString stringWithFormat:@"海流"];
        
        SeaStreamInfoModel * infoModel = [seaStreamInfoDic objectForKey:date];
        NSString * str = [NSString stringWithFormat:@"%@m/s %@%@",infoModel.wavespeed,infoModel.wavedfrom,KTemperatureSymbolSimple];
        cell.rightLabel.text = str;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tableviewDidSelectRow:Date:)]) {
        NSDate * date;
        if (self.daysSegmentedControl.selectedSegmentIndex == 0) {
            date = nowDate;
        }
        else if (self.daysSegmentedControl.selectedSegmentIndex == 1){
            date = nextDate1;
        }
        else if (self.daysSegmentedControl.selectedSegmentIndex == 2){
            date = nextDate2;
        }
        else{
            date = nextDate3;
        }
        [self.delegate tableviewDidSelectRow:indexPath.row Date:date];
    }
}

@end
