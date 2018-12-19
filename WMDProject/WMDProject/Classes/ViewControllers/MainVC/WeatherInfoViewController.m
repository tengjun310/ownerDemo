//
//  WeatherInfoViewController.m
//  WMDProject
//
//  Created by teng jun on 2018/12/19.
//  Copyright © 2018 Shannon MYang. All rights reserved.
//

#import "WeatherInfoViewController.h"
#import "WeatherInfoTableViewCell.h"

@interface WeatherInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

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
        imageStr = @"haixiao";
    }
    else if (self.type == WeatherInfoType_haishengwu){
        imageStr = @"haishengwu";
    }
    else{
        imageStr = @"haibing";
    }
    
    self.dipImageView.image = [UIImage imageNamed:imageStr];
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.infoTableView];
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).mas_offset(180);
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view).mas_offset(-15);
    }];
}

#pragma mark -- tableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    
    if (indexPath.row == 0) {
        cell.leftLabel.text = @"海浪红色警报解除";
    }
    else{
        cell.leftLabel.text = @"海浪红色警报";
    }
    
    cell.rightLabel.text = @"2018年10月27日22时";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}


@end
