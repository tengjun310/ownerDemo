//
//  ListInfoViewController.m
//  WMDProject
//
//  Created by teng jun on 2018/12/24.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "ListInfoViewController.h"
#import "ListInfoTableViewCell.h"
#import "SeaWaterLevelInfoModel.h"
#import "SeaStreamInfoModel.h"
#import "SeaDataInfoModel.h"


@interface ListInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * listTableView;

@end

@implementation ListInfoViewController

- (UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.rowHeight = 40;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.backgroundColor = [UIColor clearColor];
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
        _listTableView.layer.masksToBounds = YES;
        _listTableView.layer.cornerRadius = 5;
    }
    
    return _listTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)configureUI{
    self.dipImageView.image = [UIImage imageNamed:@"bg_xingkong"];
    self.hiddenLeftItem = NO;
    self.title = self.titleStr;
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat navHeight = 64;
    CGFloat bottom = 0;
    if ([[UIScreen mainScreen] currentMode].size.height == 1792 || [[UIScreen mainScreen] currentMode].size.height>=2436) {
        navHeight = 88;
        bottom = 44;
    }
    
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).mas_offset(navHeight+20);
        make.left.mas_equalTo(weakSelf.view).mas_offset(15);
        make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
        make.bottom.mas_equalTo(weakSelf.view).mas_offset(-bottom);
    }];

}

#pragma mark -- tableView delegate & datasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 25)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 45, 25)];
    label1.textColor = kColorBlack;
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = kFontSize28;
    [view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-165, 0, 120, 25)];
    label2.textColor = kColorBlack;
    label2.textAlignment = NSTextAlignmentRight;
    label2.font = kFontSize28;
    [view addSubview:label2];
//1 水位  2 流速  3 海温 4 波高  5 海风
    if (self.type == 1) {
        label1.text = @"时间";
        label2.text = @"潮高(m)";
    }
    else if (self.type == 2){
        label1.text = @"时间";
        label2.text = @"流速(m/s)/流向(°)";
    }
    else if (self.type == 3){
        label1.text = @"时间";
        label2.text = @"海温(℃)";
    }
    else if (self.type == 4){
        label1.text = @"时间";
        label2.text = @"浪高(m)/浪向";
    }
    else{
        label1.text = @"时间";
        label2.text = @"风速(m/s)/风向";
    }
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"ListInfoTableViewCell";
    ListInfoTableViewCell * cell = (ListInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ListInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor hexChangeFloat:@"dce9f2"];
    }
    else{
        cell.backgroundColor = [UIColor hexChangeFloat:@"cadeec"];
    }
    
    cell.timeLabel.textAlignment = NSTextAlignmentLeft;
    if (self.type == 1 || self.type == 3) {
        [cell.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(45);
        }];
    }
    //1 水位  2 流速  3 海温 4 波高  5 海风
    if (self.type == 1) {
        SeaWaterLevelInfoModel * model = [self.dataArray objectAtIndex:indexPath.row];
        NSDate * date = [CommonUtils getFormatTime:model.forecastdate FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        cell.infoLabel.text = [CommonUtils formatTime:date FormatStyle:@"yyyy年MM月dd日 HH:mm"];
        cell.timeLabel.text = [NSString stringWithFormat:@"%.02f",[model.tideheight floatValue]];
    }
    else if (self.type == 2){
        SeaStreamInfoModel * model = [self.dataArray objectAtIndex:indexPath.row];
        NSDate * date = [CommonUtils getFormatTime:model.forecastdate FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        cell.infoLabel.text = [CommonUtils formatTime:date FormatStyle:@"yyyy年MM月dd日 HH:mm"];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@/%@",model.wavespeed,model.wavedfrom];
    }
    else if (self.type == 3){
        SeaDataInfoModel * model = [self.dataArray objectAtIndex:indexPath.row];
        NSDate * date = [CommonUtils getFormatTime:model.forecasttime FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        cell.infoLabel.text = [CommonUtils formatTime:date FormatStyle:@"yyyy年MM月dd日 HH:mm"];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",model.sstdata];
    }
    else if (self.type == 4){
        SeaDataInfoModel * model = [self.dataArray objectAtIndex:indexPath.row];
        NSDate * date = [CommonUtils getFormatTime:model.forecasttime FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        cell.infoLabel.text = [CommonUtils formatTime:date FormatStyle:@"yyyy年MM月dd日 HH:mm"];
        cell.timeLabel.text = [NSString stringWithFormat:@"%.1f/%@",[model.waveheight floatValue],model.wavedfrom];
    }
    else{
        SeaDataInfoModel * model = [self.dataArray objectAtIndex:indexPath.row];
        NSDate * date = [CommonUtils getFormatTime:model.forecasttime FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        cell.infoLabel.text = [CommonUtils formatTime:date FormatStyle:@"yyyy年MM月dd日 HH:mm"];
        cell.timeLabel.text = [NSString stringWithFormat:@"%.1f/%@",[model.swspeed floatValue],model.swdirection];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
