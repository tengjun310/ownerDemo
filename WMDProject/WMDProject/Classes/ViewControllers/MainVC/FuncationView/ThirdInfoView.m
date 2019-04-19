//
//  ThirdInfoView.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "ThirdInfoView.h"

@interface ThirdInfoView ()<BMKMapViewDelegate>

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIButton * leftButton;

@property (nonatomic,strong) UIButton * rightButton;

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
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.817077, 121.485732);
        _mapView.zoomLevel = 16;
        _mapView.delegate = self;
        _mapView.zoomEnabled = YES;
        _mapView.scrollEnabled = YES;
        _mapView.gesturesEnabled = YES;
        _mapView.zoomEnabledWithTap = NO;
    }
    
    return _mapView;
}

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self configureThirdViewUI];
}

- (void)configureThirdViewUI{
    __weak typeof(self) weakSelf = self;
    
    CGFloat navHeight = 40+64;
    if ([[UIScreen mainScreen] currentMode].size.height == 1792 || [[UIScreen mainScreen] currentMode].size.height>=2436) {
        navHeight = 40+88;
    }
    
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, navHeight);
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [view addGestureRecognizer:swipe];
    
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
        make.top.mas_equalTo(weakSelf).mas_offset(0);
        make.bottom.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    
    [self sendSubviewToBack:self.mapView];
    
    self.leftButton.selected = YES;
    self.mapView.mapType = BMKMapTypeStandard;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.mapView.showMapScaleBar = YES;
        self.mapView.mapScaleBarPosition = CGPointMake(10,SCREEN_HEIGHT-40);
    });

    BMKPointAnnotation* annotation1 = [[BMKPointAnnotation alloc]init];
    annotation1.coordinate = CLLocationCoordinate2DMake(39.819405,121.488965);
    annotation1.title = @"一期取水口";
    annotation1.subtitle = @"39.819405,121.488965";
    [self.mapView addAnnotation:annotation1];
    
    BMKPointAnnotation* annotation2 = [[BMKPointAnnotation alloc]init];
    annotation2.coordinate = CLLocationCoordinate2DMake(39.817077, 121.485732);
    annotation2.title = @"二期取水口";
    annotation2.subtitle = @"39.817077, 121.485732";
    [self.mapView addAnnotation:annotation2];
    
    BMKPointAnnotation* annotation3 = [[BMKPointAnnotation alloc]init];
    annotation3.coordinate = CLLocationCoordinate2DMake(39.814861,121.484582);
    annotation3.title = @"气象站";
    annotation3.subtitle = @"39.814861,121.484582";
    [self.mapView addAnnotation:annotation3];
    
    BMKPointAnnotation* annotation4 = [[BMKPointAnnotation alloc]init];
    annotation4.coordinate = CLLocationCoordinate2DMake(39.815747,121.481995);
    annotation4.title = @"海流观测点";
    annotation4.subtitle = @"39.815747,121.481995";
    [self.mapView addAnnotation:annotation4];
    
    NSLog(@"rect %f %f",self.mapView.mapScaleBarSize.width,self.mapView.mapScaleBarSize.height);
}

- (void)swipeAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrollerViewShouldMove" object:nil];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        BMKAnnotationView *annotationView = (BMKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:reuseIndetifier];
        }
        
        annotationView.hidePaopaoWhenSelectOthers = YES;
        annotationView.hidePaopaoWhenSingleTapOnMap = YES;

        if ([annotation.title isEqualToString:@"气象站"]) {
            annotationView.image = [UIImage imageNamed:@"xh"];
        }
        else if ([annotation.title isEqualToString:@"海流观测点"]){
            annotationView.image = [UIImage imageNamed:@"dt"];
        }
        else{
            annotationView.image = [UIImage imageNamed:@"icon_gcoding"];
        }
        return annotationView;
    }
    return nil;
}

- (void)buttonClickEvents:(UIButton *)sender{
    if (sender == self.leftButton) {
        self.leftButton.selected = YES;
        self.rightButton.selected = NO;
        self.mapView.mapType = BMKMapTypeStandard;
    }
    else{
        self.leftButton.selected = NO;
        self.rightButton.selected = YES;
        self.mapView.mapType = BMKMapTypeSatellite;
    }
}

@end
