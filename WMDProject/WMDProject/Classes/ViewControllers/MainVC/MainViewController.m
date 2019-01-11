//
//  MainViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "MainViewController.h"
#import "ChartsViewController.h"
#import "CalendarDataViewController.h"
#import "FuncationView/FirstInfoView.h"
#import "FuncationView/SecondInfoView.h"
#import "FuncationView/ThirdInfoView.h"
#import "FuncationView/MyScrollView.h"
#import "WeatherInfoViewController.h"

@interface MainViewController ()<FirstInfoViewDelegate,SecondInfoViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) MyScrollView * infoScrollView;

@property (nonatomic,strong) FirstInfoView * firstInfoView;

@property (nonatomic,strong) SecondInfoView * secondInfoView;

@property (nonatomic,strong) ThirdInfoView * thirdInfoView;

@end

@implementation MainViewController

- (MyScrollView *)infoScrollView{
    if (!_infoScrollView) {
        _infoScrollView = [[MyScrollView alloc] init];
        _infoScrollView.backgroundColor = [UIColor clearColor];
        _infoScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
        _infoScrollView.contentOffset = CGPointMake(0, 0);
        _infoScrollView.delegate = self;
        _infoScrollView.showsVerticalScrollIndicator = NO;
        _infoScrollView.showsHorizontalScrollIndicator = NO;
        _infoScrollView.bounces = NO;
        _infoScrollView.pagingEnabled = YES;
    }
    
    return _infoScrollView;
}

- (FirstInfoView *)firstInfoView{
    if (!_firstInfoView) {
        _firstInfoView = [[FirstInfoView alloc] init];
        _firstInfoView.delegate = self;
    }
    
    return _firstInfoView;
}

- (SecondInfoView *)secondInfoView{
    if (!_secondInfoView) {
        _secondInfoView = [[SecondInfoView alloc] init];
        _secondInfoView.delegate = self;
    }
    
    return _secondInfoView;
}

- (ThirdInfoView *)thirdInfoView{
    if (!_thirdInfoView) {
        _thirdInfoView = [[ThirdInfoView alloc] init];
    }
    
    return _thirdInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configuireMainUI];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshShowWeather) name:@"refreshShowWeatherNotify" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)refreshShowWeather{
    self.dipImageView.image = [UIImage imageNamed:[WMDUserManager shareInstance].selectWeaInfoModel.imageName];
}

#pragma mark -- main UI
- (void)configuireMainUI{
    if ([[CommonUtils formatTime:[NSDate date] FormatStyle:@"HH"] intValue] >= 18 || [[CommonUtils formatTime:[NSDate date] FormatStyle:@"HH"] intValue] <= 6) {
        self.dipImageView.image = [UIImage imageNamed:@"defaultNight"];
    }
    else{
        self.dipImageView.image = [UIImage imageNamed:@"defaultDay"];
    }

    __weak typeof(self) weakSelf = self;

    [self.view addSubview:self.infoScrollView];
    [self.infoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];

    [self configureFirstViewUI];
    [self configureSecondViewUI];
    [self configureThirdViewUI];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= SCREEN_WIDTH && scrollView.contentOffset.x < SCREEN_WIDTH*2) {
        self.dipImageView.image = [UIImage imageNamed:[WMDUserManager shareInstance].currentWeaInfoModel.imageName];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    else{
        self.dipImageView.image = [UIImage imageNamed:[WMDUserManager shareInstance].selectWeaInfoModel.imageName];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

#pragma mark -- first view
- (void)configureFirstViewUI{
    __weak typeof(self) weakSelf = self;
    
    [self.infoScrollView addSubview:self.firstInfoView];
    [self.firstInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf.infoScrollView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    
    [self.firstInfoView startWeatherInfoRequest];
}

- (void)firstViewButtonClick:(UIButton *)sender Date:(nonnull NSDate *)date{
    if (sender == self.firstInfoView.userButton) {
        [[DYLeftSlipManager sharedManager] showLeftView];
    }
    else if (sender == self.firstInfoView.weatherInfoButton){
        CalendarDataViewController * vc = [[CalendarDataViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender == self.firstInfoView.chartButton){
        ChartsViewController * vc = [[ChartsViewController alloc] init];
        vc.today = NO;
        vc.date = date;
        vc.type = 1;
        if (self.firstInfoView.daysSegmentedControl.selectedSegmentIndex == 0) {
            vc.today = YES;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)firstViewSegmentedControlClick:(UISegmentedControl *)sender{
    [self refreshShowWeather];
}

- (void)tableviewDidSelectRow:(NSInteger)row Date:(nonnull NSDate *)date{
    ChartsViewController * vc = [[ChartsViewController alloc] init];
    vc.today = NO;
    vc.date = date;
    vc.type = (int)row+1;
    if (self.firstInfoView.daysSegmentedControl.selectedSegmentIndex == 0) {
        vc.today = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- second view
- (void)configureSecondViewUI{
    __weak typeof(self) weakSelf = self;
    
    [self.infoScrollView addSubview:self.secondInfoView];
    [self.secondInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.infoScrollView);
        make.left.mas_equalTo(weakSelf.firstInfoView.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    
    [self.secondInfoView startSecondInfoViewDataRequest];
}

- (void)secondInfoViewTableviewDidSelect:(SeaWranInfoModel *)infoModel{
    WeatherInfoViewController * vc = [[WeatherInfoViewController alloc] init];
    vc.typeStr = infoModel.type;
    if ([infoModel.type isEqualToString:@"hl"]){
        vc.type = WeatherInfoType_hailang;
        vc.titleStr = @"灾害性海浪";
    }
    else if ([infoModel.type isEqualToString:@"hx"]){
        vc.type = WeatherInfoType_haixiao;
        vc.titleStr = @"海啸";
    }
    else if ([infoModel.type isEqualToString:@"fb"]){
        vc.type = WeatherInfoType_fengbaochao;
        vc.titleStr = @"风暴物";
    }
    else if ([infoModel.type isEqualToString:@"hxw"]){
        vc.type = WeatherInfoType_haishengwu;
        vc.titleStr = @"海生物";
    }
    else{
        vc.type = WeatherInfoType_haibing;
        vc.titleStr = @"海冰";
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- third view
- (void)configureThirdViewUI{
    __weak typeof(self) weakSelf = self;
    
    [self.infoScrollView addSubview:self.thirdInfoView];
    [self.thirdInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.infoScrollView);
        make.left.mas_equalTo(weakSelf.secondInfoView.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
}



@end
