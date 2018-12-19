//
//  ThirdInfoView.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "ThirdInfoView.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface ThirdInfoView ()

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIButton * leftButton;

@property (nonatomic,strong) UIButton * rightButton;

@property (nonatomic,strong) BMKMapView * mapView;

@end

@implementation ThirdInfoView

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kColorBlack;
        _titleLabel.font = kFontSize34;
        _titleLabel.text = @"红沿河核电站";
    }
    
    return _titleLabel;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = [UIColor clearColor];
        [_leftButton setTitle:@"标准地图" forState:UIControlStateNormal];
        [_leftButton setTitleColor:kColorAppMain forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_leftButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage createImageWithColor:kColorAppMain] forState:UIControlStateSelected];
        _leftButton.titleLabel.font = kFontSize26;
        _leftButton.layer.masksToBounds = YES;
        _leftButton.layer.cornerRadius = 4;
        _leftButton.layer.borderColor = kColorAppMain.CGColor;
        _leftButton.layer.borderWidth = 1.0f;
        [_leftButton addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor clearColor];
        [_rightButton setTitle:@"卫星地图" forState:UIControlStateNormal];
        [_rightButton setTitleColor:kColorAppMain forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_rightButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage createImageWithColor:kColorAppMain] forState:UIControlStateSelected];
        _rightButton.titleLabel.font = kFontSize26;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.cornerRadius = 4;
        _rightButton.layer.borderColor = kColorAppMain.CGColor;
        _rightButton.layer.borderWidth = 1.0f;
        [_rightButton addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightButton;
}

- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] init];
    }
    
    return _mapView;
}

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configureThirdViewUI];
    }
    
    return self;
}

- (void)configureThirdViewUI{
    __weak typeof(self) weakSelf = self;
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).mas_offset(20);
        make.left.right.mas_equalTo(weakSelf);
        make.height.mas_offset(20);
    }];
    
    CGFloat buttonWidth = (SCREEN_WIDTH-30*2-10)/2;
    
    [self addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(weakSelf).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(buttonWidth, 30));
    }];

    [self addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(weakSelf.leftButton.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(buttonWidth, 30));
    }];
    
    [self addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.leftButton.mas_bottom).mas_offset(15);
        make.left.right.bottom.mas_equalTo(weakSelf);
    }];
    
    self.leftButton.selected = YES;
    self.mapView.mapType = BMKMapTypeStandard;
}

- (void)buttonClickEvents:(UIButton *)sender{
    if (sender == self.leftButton) {
        self.leftButton.selected = YES;
        self.rightButton.selected = NO;
        self.mapView.mapType = BMKMapTypeStandard;
//        [self.mapView mapForceRefresh];
    }
    else{
        self.leftButton.selected = NO;
        self.rightButton.selected = YES;
        self.mapView.mapType = BMKMapTypeSatellite;
    }
}

@end
