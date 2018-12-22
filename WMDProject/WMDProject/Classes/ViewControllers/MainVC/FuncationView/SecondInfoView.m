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
        _weateherInfoLabel.numberOfLines = 3;
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
        make.size.mas_equalTo(CGSizeMake(130, 140));
    }];
    
    [self addSubview:self.symbolLabel];
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.weateherInfoLabel.mas_top).mas_offset(15);
        make.left.mas_equalTo(weakSelf.weateherInfoLabel.mas_centerX).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 45));
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
    
    self.infoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getYujingListInfo)];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshShowWeather) name:@"refreshShowWeatherNotify" object:nil];
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

- (void)refreshShowWeather{
    NSString * str5 = [NSString stringWithFormat:@"%@",[WMDUserManager shareInstance].currentWeaInfoModel.nowtmp];
    if ([str5 containsString:KTemperatureSymbol]) {
        str5 = [str5 substringToIndex:str5.length-1];
    }
    NSString * str6 = [NSString stringWithFormat:@"%@ %@ %@ %@",[WMDUserManager shareInstance].currentWeaInfoModel.daytmp,[WMDUserManager shareInstance].currentWeaInfoModel.status,[WMDUserManager shareInstance].currentWeaInfoModel.wind,[WMDUserManager shareInstance].currentWeaInfoModel.windGrade];
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
                         range:NSMakeRange(0, str5.length)];
    self.weateherInfoLabel.attributedText = labelAttrStr;
}

- (void)startSecondInfoViewDataRequest{
    self.tipInfoLabel.text = @"中潮";
    
    dataArray = [NSMutableArray array];
    
    [self getYujingListInfo];
}

- (void)getYujingListInfo{
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
}

#pragma mark -- tableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
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
    
    SeaWranInfoModel * infoModel = [dataArray objectAtIndex:indexPath.row];
    cell.leftLabel.text = infoModel.title;
    cell.dateLabel.text = infoModel.publishTime;
    //    cell.dateLabel.text = [NSString stringWithFormat:@"11月12号\n15:30"];
    NSString * str = [NSString stringWithFormat:@"%@",infoModel.durTime];
    str = [str stringByReplacingOccurrencesOfString:@"大于" withString:@">"];
    str = [str stringByReplacingOccurrencesOfString:@"小于" withString:@"<"];
    cell.timeLabel.text = str;

    cell.warnLabel.text = infoModel.status;
    cell.warnLabel.textColor = [UIColor whiteColor];
    if ([infoModel.status isEqualToString:@"红色"]) {
        cell.warnLabel.backgroundColor = kColorRed;
    }
    else if ([infoModel.status isEqualToString:@"蓝色"]){
        cell.warnLabel.backgroundColor = kColorAppMain;
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
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(secondInfoViewTableviewDidSelect:)]) {
        SeaWranInfoModel * model = [dataArray objectAtIndex:indexPath.row];
        [self.delegate secondInfoViewTableviewDidSelect:model];
    }
}

@end
