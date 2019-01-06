//
//  WeatherInfoViewController.m
//  WMDProject
//
//  Created by teng jun on 2018/12/19.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "WeatherInfoViewController.h"
#import "WeatherInfoTableViewCell.h"
#import "SeaWarnDetailInfoModel.h"
#import "WebViewViewController.h"

@interface WeatherInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dataArray;
}
@property (nonatomic,strong) UITableView * infoTableView;


@end

@implementation WeatherInfoViewController

- (UITableView *)infoTableView{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc] init];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.rowHeight = 50;
        _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTableView.backgroundColor = [UIColor clearColor];
        _infoTableView.showsVerticalScrollIndicator = NO;
        _infoTableView.showsHorizontalScrollIndicator = NO;
    }
    
    return _infoTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureUI];
}

- (void)configureUI{
    self.title = self.titleStr;
    self.hiddenLeftItem = NO;
    NSString * imageStr = @"";
    if (self.type == WeatherInfoType_hailang) {
        imageStr = @"hailang";
    }
    else if (self.type == WeatherInfoType_haixiao){
        imageStr = @"haixiao";
    }
    else if (self.type == WeatherInfoType_fengbaochao){
        imageStr = @"fengbaochao";
    }
    else if (self.type == WeatherInfoType_haishengwu){
        imageStr = @"haishengwu";
    }
    else{
        imageStr = @"haibing";
    }
    
    self.dipImageView.image = [UIImage imageNamed:imageStr];
    
    dataArray = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.infoTableView];
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).mas_offset(180);
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view).mas_offset(-15);
    }];
    
    self.infoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getWeatherDetailInfo)];
    [self.infoTableView.mj_header beginRefreshing];
}

- (void)getWeatherDetailInfo{
    NSString * str = [NSString stringWithFormat:@"marine/getWarnDetail?type=%@",self.typeStr];
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            [self->dataArray removeAllObjects];
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * arr = [dic objectForKey:@"content"];
            for (NSDictionary * data in arr) {
                SeaWarnDetailInfoModel * model = [[SeaWarnDetailInfoModel alloc] initWithDictionary:data error:nil];
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
    static NSString * cellId = @"WeatherInfoTableViewCell";
    WeatherInfoTableViewCell * cell = (WeatherInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WeatherInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor hexChangeFloat:@"c5c5c7" alpha:0.7];
    }
    else{
        cell.backgroundColor = [UIColor hexChangeFloat:@"a3a3a5" alpha:0.7];
    }
    
    SeaWarnDetailInfoModel * infoModel = [dataArray objectAtIndex:indexPath.row];
    cell.leftLabel.text = infoModel.title;
    if ([infoModel.tag isEqualToString:@"红色"]) {
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_hongse"];
    }
    else if ([infoModel.tag isEqualToString:@"蓝色"]){
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_lanse"];
    }
    else if ([infoModel.tag isEqualToString:@"橙色"]){
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_lanse"];
    }
    else if ([infoModel.tag isEqualToString:@"黄色"]){
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_cs"];
    }
    else {
        cell.logoImageView.image = [UIImage imageNamed:@"icon_small_jeichu"];
    }
    
    NSDate * date = [CommonUtils getFormatTime:infoModel.publishTime FormatStyle:@"yyyy-MM-dd HH:mm"];
    NSString * dateStr = [CommonUtils formatTime:date FormatStyle:@"yyyy年MM月dd日HH时"];
    cell.rightLabel.text = dateStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SeaWarnDetailInfoModel * infoModel = [dataArray objectAtIndex:indexPath.row];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:infoModel.url]];

//    WebViewViewController * vc = [[WebViewViewController alloc] init];
//    vc.urlStr = infoModel.url;
//    [self.navigationController pushViewController:vc animated:YES];
}


@end
