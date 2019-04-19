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
{
    NSMutableArray * dataArray;
}

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
        _weateherInfoLabel.numberOfLines = 0;
        _weateherInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _weateherInfoLabel;
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

- (UILabel *)tipInfoLabel{
    if (!_tipInfoLabel) {
        _tipInfoLabel = [[UILabel alloc] init];
        _tipInfoLabel.backgroundColor = [UIColor clearColor];
        _tipInfoLabel.textAlignment = NSTextAlignmentRight;
        _tipInfoLabel.textColor = [UIColor whiteColor];
        _tipInfoLabel.font = [UIFont systemFontOfSize:20];
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
    
    CGFloat top = 25;
    if ([[UIScreen mainScreen] currentMode].size.height == 1792 || [[UIScreen mainScreen] currentMode].size.height>=2436) {
        top = 35;
    }

    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).mas_offset(top);
        make.left.right.mas_equalTo(weakSelf);
        make.height.mas_offset(20);
    }];
    
    [self addSubview:self.weateherInfoLabel];
    [self.weateherInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(weakSelf).mas_offset(SCREEN_WIDTH>320?40:30);
        make.size.mas_equalTo(CGSizeMake(130, 140));
    }];
    
    [self addSubview:self.symbolLabel];
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.weateherInfoLabel.mas_top).mas_offset(15);
        make.left.mas_equalTo(weakSelf.weateherInfoLabel.mas_centerX).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 45));
    }];
    
    [self addSubview:self.tipInfoLabel];
    [self.tipInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.weateherInfoLabel.mas_bottom).mas_offset(-15);
        make.right.mas_equalTo(weakSelf).mas_offset(-25);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];

    [self addSubview:self.addressInfoLabel];
    [self.addressInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.weateherInfoLabel.mas_bottom).mas_offset(60);
        make.left.mas_equalTo(weakSelf).mas_offset(SCREEN_WIDTH>320?20:10);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    [self addSubview:self.infoTableView];
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.addressInfoLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(weakSelf).mas_offset(SCREEN_WIDTH>320?20:10);
        make.right.mas_equalTo(weakSelf).mas_offset(SCREEN_WIDTH>320?-20:-10);
        make.bottom.mas_equalTo(weakSelf).mas_offset(-10);
    }];
    
    self.infoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getYujingListInfo)];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshShowWeather) name:@"refreshShowWeatherNotify" object:nil];
}

- (void)refreshShowWeather{
    NSString * str5 = [NSString stringWithFormat:@" %@",[WMDUserManager shareInstance].currentWeaInfoModel.nowtmp];
    NSString * str6 = [NSString stringWithFormat:@"%@ %@",[WMDUserManager shareInstance].currentWeaInfoModel.daytmp,[WMDUserManager shareInstance].currentWeaInfoModel.status];
    NSString * str7 = [NSString stringWithFormat:@"%@ %@",[WMDUserManager shareInstance].currentWeaInfoModel.wind,[WMDUserManager shareInstance].currentWeaInfoModel.windGrade];
    NSString * str8 = [NSString stringWithFormat:@"%@\n%@\n%@",str5,str6,str7];
    NSRange range4 = [str8 rangeOfString:str6];
    NSRange range5 = [str8 rangeOfString:str7];

    NSMutableAttributedString * labelAttrStr = [[NSMutableAttributedString alloc] initWithString:str8];
    
    [labelAttrStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:60],
                                  NSForegroundColorAttributeName:kColorBackground
                                  }
                          range:NSMakeRange(0, str5.length)];
    [labelAttrStr setAttributes:@{NSFontAttributeName:kFontSize28,
                                  NSForegroundColorAttributeName:kColorBackground
                                  }
                          range:range4];
    [labelAttrStr setAttributes:@{NSFontAttributeName:kFontSize28,
                                  NSForegroundColorAttributeName:kColorBackground
                                  }
                          range:range5];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距
    paragraphStyle.lineSpacing = 10.0f;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [labelAttrStr addAttribute:NSParagraphStyleAttributeName
                         value:paragraphStyle
                         range:NSMakeRange(0, str5.length)];
    self.weateherInfoLabel.attributedText = labelAttrStr;
    
    if ([WMDUserManager shareInstance].currentWeaInfoModel.nowtmp.length > 2) {
        [self.symbolLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.weateherInfoLabel.mas_centerX).mas_offset(38);
        }];
    }
    else if ([WMDUserManager shareInstance].currentWeaInfoModel.nowtmp.length == 1){
        [self.symbolLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.weateherInfoLabel.mas_centerX).mas_offset(-15);
        }];
    }
    else{
        [self.symbolLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.weateherInfoLabel.mas_centerX).mas_offset(5);
        }];
    }
}

- (void)startSecondInfoViewDataRequest{
    dataArray = [NSMutableArray array];
    
    [self getYujingListInfo];
}

- (void)getYujingListInfo{
    //刷新当前天气数据
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNowTempleture" object:nil];
    
    NSString * str = [NSString stringWithFormat:@"marine/getWarnInfo?type=%@",@""];
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            [self->dataArray removeAllObjects];
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * contentArray = [dic objectForKey:@"content"];
            for (NSDictionary * data in contentArray) {
                SeaWranInfoModel * model = [[SeaWranInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray addObject:model];
            }
            [self.infoTableView reloadData];
        }
        [self.infoTableView.mj_header endRefreshing];
    } FailBlock:^(NSError *error) {
        [self.infoTableView.mj_header endRefreshing];
    }];
    
    [self getStreamStatusInfo];
}

- (void)getStreamStatusInfo{
    NSString * str = [NSString stringWithFormat:@"marine/getStreamStratus"];
    [HttpClient asyncSendGetRequest:str SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSString * statusStr = [[dic objectForKey:@"content"] objectForKey:@"status"];
            self.tipInfoLabel.text = statusStr;
        }
    } FailBlock:^(NSError *error) {
        self.tipInfoLabel.text = @"";
    }];
}

#pragma mark -- tableView delegate & datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 30;
    }
    
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"SecondInfoViewTableViewCell";
    SecondInfoViewTableViewCell * cell = (SecondInfoViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SecondInfoViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.leftLabel.hidden = NO;
    cell.leftLabel.textColor = [UIColor colorWithRed:0 green:32/255.0 blue:96/255.0 alpha:1];
    cell.warnLabel.textColor = [UIColor colorWithRed:0 green:32/255.0 blue:96/255.0 alpha:1];
    cell.warnLabel.font = kFontSize26;
    cell.dateLabel.textColor = [UIColor colorWithRed:0 green:32/255.0 blue:96/255.0 alpha:1];
    cell.dateLabel.font = kFontSize26;
    cell.timeLabel.textColor = [UIColor colorWithRed:0 green:32/255.0 blue:96/255.0 alpha:1];
    cell.timeLabel.font = SCREEN_WIDTH>320?kFontSize26:[UIFont systemFontOfSize:11];

    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.leftLabel.hidden = YES;
        cell.warnLabel.backgroundColor = [UIColor clearColor];
        cell.warnLabel.textColor = kColorBlack;
        cell.warnLabel.text = @"预警状态";
        cell.dateLabel.textColor = kColorBlack;
        cell.dateLabel.text = @"发布时间";
        cell.timeLabel.textColor = kColorBlack;
        cell.timeLabel.text = @"预计持续时间";
        cell.warnLabel.font = kFontSize24;
        cell.dateLabel.font = kFontSize24;
        cell.timeLabel.font = [UIFont systemFontOfSize:11];
    }
    else{
        if ((indexPath.row-1)%2 == 0) {
            cell.backgroundColor = [UIColor hexChangeFloat:@"c0c4cb" alpha:.8];
        }
        else{
            cell.backgroundColor = [UIColor hexChangeFloat:@"a4abb1" alpha:.8];
        }
        
        cell.warnLabel.textColor = [UIColor whiteColor];
        
        SeaWranInfoModel * infoModel = [dataArray objectAtIndex:indexPath.row-1];
        cell.leftLabel.text = infoModel.title;
        cell.dateLabel.text = infoModel.publishTime;
        //    cell.dateLabel.text = [NSString stringWithFormat:@"11月12号\n15:30"];
        NSString * str = [NSString stringWithFormat:@"%@",infoModel.durTime];
//        str = [str stringByReplacingOccurrencesOfString:@"大于" withString:@">"];
//        str = [str stringByReplacingOccurrencesOfString:@"小于" withString:@"<"];
        cell.timeLabel.text = str;
        
        cell.warnLabel.text = infoModel.status;
        cell.warnLabel.textColor = [UIColor whiteColor];
        if ([infoModel.status isEqualToString:@"红色"]) {
            cell.warnLabel.backgroundColor = kColorRed;
        }
        else if ([infoModel.status isEqualToString:@"蓝色"]){
            cell.warnLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:255/255 alpha:1];
        }
        else if ([infoModel.status isEqualToString:@"橙色"]){
            cell.warnLabel.backgroundColor = kColorOrige;
        }
        else if ([infoModel.status isEqualToString:@"黄色"]){
            cell.warnLabel.backgroundColor = kColorYellow;
        }
        else {
            cell.warnLabel.backgroundColor = [UIColor whiteColor];
            cell.warnLabel.textColor = kColorBlack;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(secondInfoViewTableviewDidSelect:)]) {
        SeaWranInfoModel * model = [dataArray objectAtIndex:indexPath.row-1];
        [self.delegate secondInfoViewTableviewDidSelect:model];
    }
}

@end
