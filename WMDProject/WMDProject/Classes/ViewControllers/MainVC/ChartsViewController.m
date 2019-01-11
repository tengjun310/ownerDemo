//
//  ChartsViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "ChartsViewController.h"
#import "ListInfoViewController.h"
#import "SeaWaterLevelInfoModel.h"
#import "SeaStreamInfoModel.h"
#import "SeaDataInfoModel.h"
#import "WMDProject-Swift.h"
#import "DirectionInfoModel.h"
#import "SpeedInfoModel.h"


@interface ChartsViewController ()<ChartViewDelegate,IChartAxisValueFormatter>
{
    NSMutableArray * dataArray;
    NSMutableArray * dataArray2;
    NSMutableArray * xValues;
    NSMutableArray* xValues2;
    NSMutableArray * indexArray1;
    NSMutableArray * indexArray2;
    
    NSUInteger index1;
    NSUInteger index2;
    
    NSDictionary * speedInfoDic;
    
    int waterLevelCount;
}

@property (nonatomic,strong) UIView * dipView1;

@property (nonatomic,strong) UILabel * titleLabel1;

@property (nonatomic,strong) UILabel * tipLabel1;

@property (nonatomic,strong) UILabel * tipLabel;

@property (nonatomic,strong) UIButton * chartButton;

@property (nonatomic,strong) UIButton * leftchartButton1;

@property (nonatomic,strong) UIButton * leftchartButton2;

@property (nonatomic,strong) LineChartView * lineChartView1;

@property (nonatomic,strong) UILabel * leftTimeLabel1;

@property (nonatomic,strong) UILabel * rightTimeLabel1;


//直方图
@property (nonatomic,strong) UIView * dipView2;

@property (nonatomic,strong) UILabel * tipLabel2;

@property (nonatomic,strong) BarChartView *barChartView;

@property (nonatomic,strong) UILabel * leftTimeLabel2;

@property (nonatomic,strong) UILabel * rightTimeLabel2;

@property (nonatomic,strong) UILabel * topSybomlLabel;

@property (nonatomic,strong) UILabel * dipSybomlLabel;

//雷达图
@property (nonatomic,strong) UIView * dipView3;

@property (nonatomic,strong) RadarChartView * radarChartView;

@property (nonatomic,strong) UILabel * leftTimeLabel3;

@property (nonatomic,strong) UILabel * rightTimeLabel3;

@property (nonatomic,strong) UILabel * speedInfoLabel;


@end

@implementation ChartsViewController

- (UIView *)dipView1{
    if (!_dipView1) {
        _dipView1 = [[UIView alloc] init];
        _dipView1.backgroundColor = [UIColor hexChangeFloat:@"ffffff" alpha:0.7];
        _dipView1.layer.masksToBounds = YES;
        _dipView1.layer.cornerRadius = 5;
    }
    
    return _dipView1;
}

- (UILabel *)titleLabel1{
    if (!_titleLabel1) {
        _titleLabel1 = [[UILabel alloc]init];
        _titleLabel1.backgroundColor = [UIColor clearColor];
        _titleLabel1.font = kFontSize28;
        _titleLabel1.textAlignment = NSTextAlignmentCenter;
        _titleLabel1.textColor = kColorAppMain;
    }
    
    return _titleLabel1;
}

- (UILabel *)tipLabel1{
    if (!_tipLabel1) {
        _tipLabel1 = [[UILabel alloc]init];
        _tipLabel1.backgroundColor = [UIColor clearColor];
        _tipLabel1.font = [UIFont systemFontOfSize:10];
        _tipLabel1.textAlignment = NSTextAlignmentLeft;
        _tipLabel1.textColor = kColorBlack;
    }
    
    return _tipLabel1;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = [UIFont systemFontOfSize:10];
        _tipLabel.textAlignment = NSTextAlignmentRight;
        _tipLabel.textColor = kColorBlack;
    }
    
    return _tipLabel;
}

- (UILabel *)leftTimeLabel1{
    if (!_leftTimeLabel1) {
        _leftTimeLabel1 = [[UILabel alloc]init];
        _leftTimeLabel1.backgroundColor = [UIColor clearColor];
        _leftTimeLabel1.font = kFontSize24;
        _leftTimeLabel1.textAlignment = NSTextAlignmentLeft;
        _leftTimeLabel1.textColor = kColorGray;
    }
    
    return _leftTimeLabel1;
}

- (UILabel *)rightTimeLabel1{
    if (!_rightTimeLabel1) {
        _rightTimeLabel1 = [[UILabel alloc]init];
        _rightTimeLabel1.backgroundColor = [UIColor clearColor];
        _rightTimeLabel1.font = kFontSize24;
        _rightTimeLabel1.textAlignment = NSTextAlignmentRight;
        _rightTimeLabel1.textColor = kColorGray;
    }
    
    return _rightTimeLabel1;
}

- (UIButton *)chartButton{
    if (!_chartButton) {
        _chartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chartButton.backgroundColor = [UIColor clearColor];
        [_chartButton addTarget:self action:@selector(chartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_chartButton setImage:[UIImage imageNamed:@"chart_icon"] forState:UIControlStateNormal];
    }
    
    return _chartButton;
}

- (UIButton *)leftchartButton1{
    if (!_leftchartButton1) {
        _leftchartButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftchartButton1.backgroundColor = [UIColor clearColor];
        [_leftchartButton1 addTarget:self action:@selector(leftchartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftchartButton1 setImage:[UIImage imageNamed:@"twelvemin"] forState:UIControlStateNormal];
        [_leftchartButton1 setImage:[UIImage imageNamed:@"fivemin"] forState:UIControlStateSelected];
    }
    
    return _leftchartButton1;
}

- (UIButton *)leftchartButton2{
    if (!_leftchartButton2) {
        _leftchartButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftchartButton2.backgroundColor = [UIColor clearColor];
        [_leftchartButton2 addTarget:self action:@selector(leftchartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftchartButton2 setImage:[UIImage imageNamed:@"24lock"] forState:UIControlStateNormal];
        [_leftchartButton2 setImage:[UIImage imageNamed:@"24unlock"] forState:UIControlStateSelected];
    }
    
    return _leftchartButton2;
}

- (LineChartView *)lineChartView1{
    if (!_lineChartView1) {
        _lineChartView1 = [[LineChartView alloc] init];
        _lineChartView1.dragEnabled = YES;
        _lineChartView1.dragDecelerationEnabled = NO;
        _lineChartView1.delegate = self;
        _lineChartView1.chartDescription.enabled = NO;
        _lineChartView1.legend.enabled = NO;
        _lineChartView1.doubleTapToZoomEnabled = NO;
        _lineChartView1.noDataText = @"暂未发布";
        _lineChartView1.noDataFont = kFontSize34;
        [_lineChartView1 setScaleEnabled:YES];
        _lineChartView1.pinchZoomEnabled = NO;
        _lineChartView1.rightAxis.enabled = NO;
        [_lineChartView1 animateWithXAxisDuration:1.0f];
        
        ChartXAxis *xAxis = _lineChartView1.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        xAxis.axisLineColor = [UIColor whiteColor];
        xAxis.granularityEnabled = NO;
        xAxis.labelTextColor = kColorBlack;
        xAxis.drawGridLinesEnabled = YES;
//        xAxis.axisMinimum = 7;
//        xAxis.labelCount = 7;
//        [xAxis setLabelCount:7 force:YES];
        xAxis.drawLabelsEnabled = YES;
        xAxis.gridColor = [UIColor whiteColor];
        xAxis.valueFormatter = self;
        
        ChartYAxis *leftAxis =_lineChartView1.leftAxis;
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        leftAxis.axisLineColor = [UIColor whiteColor];
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = kColorBlack;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.drawGridLinesEnabled = YES;
        [leftAxis setLabelCount:7 force:YES];
        leftAxis.axisMinimum = 0;
        NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
        rightAxisFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        rightAxisFormatter.maximumFractionDigits = 2;
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:rightAxisFormatter];
        
        [_lineChartView1.viewPortHandler setMaximumScaleY:1.0f];
        
    }
    
    return _lineChartView1;
}


- (UIView *)dipView2{
    if (!_dipView2) {
        _dipView2 = [[UIView alloc] init];
        _dipView2.backgroundColor = [UIColor hexChangeFloat:@"ffffff" alpha:0.7];
        _dipView2.layer.masksToBounds = YES;
        _dipView2.layer.cornerRadius = 5;
    }
    
    return _dipView2;
}

- (UILabel *)tipLabel2{
    if (!_tipLabel2) {
        _tipLabel2 = [[UILabel alloc]init];
        _tipLabel2.backgroundColor = [UIColor clearColor];
        _tipLabel2.font = [UIFont systemFontOfSize:10];
        _tipLabel2.textAlignment = NSTextAlignmentLeft;
        _tipLabel2.textColor = kColorBlack;
    }
    
    return _tipLabel2;
}

- (UILabel *)leftTimeLabel2{
    if (!_leftTimeLabel2) {
        _leftTimeLabel2 = [[UILabel alloc]init];
        _leftTimeLabel2.backgroundColor = [UIColor clearColor];
        _leftTimeLabel2.font = kFontSize24;
        _leftTimeLabel2.textAlignment = NSTextAlignmentLeft;
        _leftTimeLabel2.textColor = kColorBlack;
        _leftTimeLabel2.text = @"流速直方图:";
    }
    
    return _leftTimeLabel2;
}

- (UILabel *)rightTimeLabel2{
    if (!_rightTimeLabel2) {
        _rightTimeLabel2 = [[UILabel alloc]init];
        _rightTimeLabel2.backgroundColor = [UIColor clearColor];
        _rightTimeLabel2.font = kFontSize24;
        _rightTimeLabel2.textAlignment = NSTextAlignmentRight;
        _rightTimeLabel2.textColor = kColorBlack;
        _rightTimeLabel2.text = @"4天数据统计值";
    }
    
    return _rightTimeLabel2;
}

- (UILabel *)topSybomlLabel{
    if (!_topSybomlLabel) {
        _topSybomlLabel = [[UILabel alloc]init];
        _topSybomlLabel.backgroundColor = [UIColor clearColor];
        _topSybomlLabel.font = kFontSize24;
        _topSybomlLabel.textAlignment = NSTextAlignmentLeft;
        _topSybomlLabel.textColor = kColorBlack;
        _topSybomlLabel.text = @"%";
    }
    
    return _topSybomlLabel;
}

- (UILabel *)dipSybomlLabel{
    if (!_dipSybomlLabel) {
        _dipSybomlLabel = [[UILabel alloc]init];
        _dipSybomlLabel.backgroundColor = [UIColor clearColor];
        _dipSybomlLabel.font = [UIFont systemFontOfSize:10];
        _dipSybomlLabel.textAlignment = NSTextAlignmentRight;
        _dipSybomlLabel.textColor = kColorBlack;
        _dipSybomlLabel.text = @"m/s";
    }
    
    return _dipSybomlLabel;
}

- (BarChartView *)barChartView{
    if (!_barChartView) {
        _barChartView = [[BarChartView alloc] init];
        _barChartView.chartDescription.enabled = NO;
        _barChartView.legend.enabled = NO;
        [_barChartView animateWithXAxisDuration:1.0f];
        _barChartView.rightAxis.enabled = NO;
        _barChartView.doubleTapToZoomEnabled = NO;
        _barChartView.noDataText = @"暂未发布";
        _barChartView.noDataFont = kFontSize34;
        [_barChartView setScaleEnabled:YES];
        _barChartView.pinchZoomEnabled = NO;
        _barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        _barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
        _barChartView.fitBars = YES;
        
        ChartXAxis *xAxis =_barChartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        xAxis.axisLineColor = [UIColor whiteColor];
        xAxis.granularityEnabled = NO;
        xAxis.labelTextColor = kColorBlack;
        xAxis.drawGridLinesEnabled = NO;
        xAxis.drawLabelsEnabled = YES;
        xAxis.valueFormatter = self;
        
        ChartYAxis *leftAxis =_barChartView.leftAxis;
        leftAxis.inverted = NO;
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        leftAxis.axisLineColor = [UIColor whiteColor];
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = kColorBlack;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.drawGridLinesEnabled = YES;
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.axisMinimum = 0;

        [_barChartView.viewPortHandler setMaximumScaleY:1.0f];
        [_barChartView.viewPortHandler setMaximumScaleX:2.3f];
    }

    return _barChartView;
}

//雷达图
- (UIView *)dipView3{
    if (!_dipView3) {
        _dipView3 = [[UIView alloc] init];
        _dipView3.backgroundColor = [UIColor hexChangeFloat:@"ffffff" alpha:0.7];
        _dipView3.layer.masksToBounds = YES;
        _dipView3.layer.cornerRadius = 5;
    }
    
    return _dipView3;
}

- (UILabel *)leftTimeLabel3{
    if (!_leftTimeLabel3) {
        _leftTimeLabel3 = [[UILabel alloc]init];
        _leftTimeLabel3.backgroundColor = [UIColor clearColor];
        _leftTimeLabel3.font = kFontSize24;
        _leftTimeLabel3.textAlignment = NSTextAlignmentLeft;
        _leftTimeLabel3.textColor = kColorBlack;
    }
    
    return _leftTimeLabel3;
}

- (UILabel *)rightTimeLabel3{
    if (!_rightTimeLabel3) {
        _rightTimeLabel3 = [[UILabel alloc]init];
        _rightTimeLabel3.backgroundColor = [UIColor clearColor];
        _rightTimeLabel3.font = kFontSize24;
        _rightTimeLabel3.textAlignment = NSTextAlignmentRight;
        _rightTimeLabel3.textColor = kColorBlack;
    }
    
    return _rightTimeLabel3;
}

- (RadarChartView *)radarChartView{
    if (!_radarChartView) {
        _radarChartView = [[RadarChartView alloc] init];
        _radarChartView.backgroundColor = [UIColor clearColor];
        _radarChartView.legend.enabled = NO;
        _radarChartView.rotationEnabled = NO;//是否允许转动
        _radarChartView.highlightPerTapEnabled = YES;
        _radarChartView.webLineWidth = 0.5;//主干线线宽
        _radarChartView.webColor = [UIColor whiteColor];//主干线线宽
        _radarChartView.innerWebLineWidth = 0.375;//边线宽度
        _radarChartView.innerWebColor = [UIColor whiteColor];//边线颜色
        _radarChartView.webAlpha = 1;//透明度
        [_radarChartView animateWithXAxisDuration:1.0f];

        ChartXAxis *xAxis = _radarChartView.xAxis;
        xAxis.labelFont = [UIFont systemFontOfSize:9];//字体
        xAxis.labelTextColor = kColorBlack;//颜色
        [xAxis setLabelPosition:XAxisLabelPositionBottomInside];
        
        ChartYAxis *yAxis = _radarChartView.yAxis;
        yAxis.labelFont = [UIFont systemFontOfSize:9];// label 字体
        yAxis.labelTextColor = kColorBlack;// label 颜色
        yAxis.axisMinimum = 0;
        NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
        rightAxisFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        rightAxisFormatter.maximumFractionDigits = 2;
        yAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:rightAxisFormatter];
    }
    
    return _radarChartView;
}

- (UILabel *)speedInfoLabel{
    if (!_speedInfoLabel) {
        _speedInfoLabel = [[UILabel alloc]init];
        _speedInfoLabel.backgroundColor = [UIColor clearColor];
        _speedInfoLabel.font = kFontSize24;
        _speedInfoLabel.textAlignment = NSTextAlignmentRight;
        _speedInfoLabel.textColor = kColorBlack;
        _speedInfoLabel.numberOfLines = 3;
        _speedInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _speedInfoLabel;
}

#pragma mark --

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dipImageView.image = [UIImage imageNamed:[WMDUserManager shareInstance].selectWeaInfoModel.imageName];
    
    self.hiddenLeftItem = NO;
    if (self.type == 1) {
        self.title = @"水位";
        waterLevelCount = 12;//默认12分钟间隔
    }
    else if (self.type == 2){
        self.title = @"浪高";
    }
    else if (self.type == 3){
        self.title = @"海温";
    }
    else if (self.type == 4){
        self.title = @"海风";
    }
    else{
        self.title = @"海流";
    }
    
    [self configureChartView];
}

- (void)configureChartView{
    __weak typeof(self) weakSelf = self;
    
    CGFloat heght = (SCREEN_HEIGHT-84-25-20)/2;
    
    [self.view addSubview:self.dipView1];
    [self.dipView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).mas_offset(kStatusBarAndNavigationBarHeight);
        make.left.mas_equalTo(weakSelf.view).mas_offset(15);
        make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
        make.height.mas_offset(heght);
    }];

    [self.dipView1 addSubview:self.titleLabel1];
    [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.dipView1).mas_offset(40);
        make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
        make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-40);
        make.height.mas_offset(20);
    }];
    
    [self.dipView1 addSubview:self.chartButton];
    [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
        make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    if (self.type == 1) {
        [self.dipView1 addSubview:self.leftchartButton1];
        [self.leftchartButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        if (waterLevelCount == 5) {
            self.leftchartButton1.selected = YES;
        }
        else{
            self.leftchartButton1.selected = NO;
        }
        
        [self.dipView1 addSubview:self.leftchartButton2];
        [self.leftchartButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.leftchartButton1.mas_right).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    
    [self.dipView1 addSubview:self.tipLabel1];
    [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel1.mas_bottom);
        make.left.mas_equalTo(weakSelf.dipView1).mas_offset(25);
        make.size.mas_equalTo(CGSizeMake(180, 15));
    }];
    
    if (self.type == 2 || self.type == 4) {
        [self.titleLabel1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
        
        if (self.type == 2) {
            [self.tipLabel1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-95-90, 20));
            }];
            
            [self.dipView1 addSubview:self.tipLabel];
            [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.titleLabel1.mas_bottom);
                make.right.mas_equalTo(weakSelf.chartButton.mas_left).mas_offset(-10);
                make.size.mas_equalTo(CGSizeMake(90, 20));
            }];
        }
        else{
            [self.chartButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(0, 0));
            }];

            [self.tipLabel1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-55-110, 20));
            }];
            
            [self.dipView1 addSubview:self.tipLabel];
            [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.titleLabel1.mas_bottom);
                make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
                make.size.mas_equalTo(CGSizeMake(90, 20));
            }];
        }
    }
    
    [self.dipView1 addSubview:self.lineChartView1];
    [self.lineChartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tipLabel1.mas_bottom);
        make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
        make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
        make.bottom.mas_equalTo(weakSelf.dipView1).mas_offset(-20);
    }];
    
    BalloonMarker * marker = [[BalloonMarker alloc]
                              initWithColor: kColorAppMain
                              font: [UIFont systemFontOfSize:10.0f]
                              textColor: UIColor.whiteColor
                              insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
    marker.chartView = self.lineChartView1;
    marker.minimumSize = CGSizeMake(80.f, 40.f);
    self.lineChartView1.marker = marker;
    
    [self.dipView1 addSubview:self.leftTimeLabel1];
    [self.leftTimeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.lineChartView1.mas_bottom);
        make.left.mas_equalTo(weakSelf.dipView1).mas_offset(25);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self.dipView1 addSubview:self.rightTimeLabel1];
    [self.rightTimeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.lineChartView1.mas_bottom);
        make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-25);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    if (self.type == 5) {
        //海流显示两个图表  其他只显示一个图表
        [self.view addSubview:self.dipView2];
        [self.dipView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView1.mas_bottom).mas_offset(25);
            make.left.mas_equalTo(weakSelf.view).mas_offset(15);
            make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
            make.height.mas_offset(heght);
        }];
        
        [self.dipView2 addSubview:self.leftTimeLabel2];
        [self.leftTimeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView2).mas_offset(5);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(120, 20));
        }];
        
        [self.dipView2 addSubview:self.rightTimeLabel2];
        [self.rightTimeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView2).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(120, 20));
        }];
        
        [self.dipView2 addSubview:self.topSybomlLabel];
        [self.topSybomlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.leftTimeLabel2.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(14, 12));
        }];

        [self.dipView2 addSubview:self.tipLabel2];
        [self.tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.dipView2);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-5);
            make.height.mas_offset(20);
        }];
        
        [self.dipView2 addSubview:self.dipSybomlLabel];
        [self.dipSybomlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-25);
            make.right.mas_equalTo(weakSelf.dipView2);
            make.size.mas_equalTo(CGSizeMake(20, 12));
        }];
        
        [self.dipView2 addSubview:self.barChartView];
        [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.topSybomlLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-20);
            make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-25);
        }];
    }

    dataArray = [NSMutableArray array];
    xValues = [NSMutableArray array];
    indexArray1 = [NSMutableArray array];
    indexArray2 = [NSMutableArray array];

    if (self.type != 4) {
        //非海风
        self.tipLabel1.text = @"来源:由红沿河海域实测数据预报得到";
        
        switch (self.type) {
            case 1:
            {
                self.titleLabel1.text = @"水位走势图";
                [self getWaterLevelData];
            }
                break;
            case 2:
            {
                dataArray2 = [NSMutableArray array];
                self.titleLabel1.text = @"浪高走势图";
                [self configureRadarChartView];
                [self get30DaysSeaTemData];
                [self getMarineStatistics];
                [self getSeaTemData];
            }
                break;
            case 3:
            {
                self.titleLabel1.text = @"海温走势图";
                self.leftTimeLabel1.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-29*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
                self.rightTimeLabel1.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
                self.chartButton.hidden = YES;
                [self getSeaTemData];
            }
                break;
            case 5:
            {
                dataArray2 = [NSMutableArray array];
                xValues2 = [NSMutableArray array];
                self.titleLabel1.text = @"流速走势图";
                [self getStreamHistogram];
                [self getMarineStatistics];
                [self getSeaStremSpeedData];
            }
                break;

            default:
                break;
        }
    }
    else{
        dataArray2 = [NSMutableArray array];

        self.chartButton.hidden = YES;
        self.titleLabel1.text = @"海风走势图";
        [self configureRadarChartView];
        [self get30DaysSeaTemData];
        [self getMarineStatistics];
        [self getSeaTemData];
    }
}

- (void)configureRadarChartView{
    __weak typeof(self) weakSelf = self;
    CGFloat heght = (SCREEN_HEIGHT-84-25-20)/2;

    [self.view addSubview:self.dipView3];
    [self.dipView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dipView1.mas_bottom).mas_offset(25);
        make.left.mas_equalTo(weakSelf.view).mas_offset(15);
        make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
        make.height.mas_offset(heght);
    }];
    
    [self.dipView3 addSubview:self.leftTimeLabel3];
    [self.leftTimeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dipView3).mas_offset(5);
        make.left.mas_equalTo(weakSelf.dipView3).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self.dipView3 addSubview:self.rightTimeLabel3];
    [self.rightTimeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dipView3).mas_offset(5);
        make.right.mas_equalTo(weakSelf.dipView3).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self.dipView3 addSubview:self.radarChartView];
    [self.radarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dipView3).mas_offset(25);
        make.left.mas_equalTo(weakSelf.dipView3).mas_offset(10);
        make.right.mas_equalTo(weakSelf.dipView3).mas_offset(-110);
        make.bottom.mas_equalTo(weakSelf.dipView3).mas_offset(-5);
    }];

    [self.dipView3 addSubview:self.speedInfoLabel];
    [self.speedInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.dipView3);
        make.right.mas_equalTo(weakSelf.dipView3).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(100, 65));
    }];
    
    BalloonMarker * marker = [[BalloonMarker alloc]
                               initWithColor: kColorAppMain
                               font: [UIFont systemFontOfSize:10.0f]
                               textColor: UIColor.whiteColor
                               insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
    marker.chartView = self.radarChartView;
    marker.minimumSize = CGSizeMake(80.f, 40.f);
    self.radarChartView.marker = marker;
    
    self.leftTimeLabel3.text = @"风向玫瑰图";
    self.rightTimeLabel3.text = @"30天数据统计值";
}

- (void)updateFirstLineChartViewData{
    NSMutableArray* dataValues = [[NSMutableArray alloc] init];
    [xValues removeAllObjects];
    for (int i=0; i<dataArray.count; i++) {
        ChartDataEntry * data;
        switch (self.type) {
            case 1:
            {
                //水位
                SeaWaterLevelInfoModel * model = [dataArray objectAtIndex:i];
                data = [[ChartDataEntry alloc] initWithX:i y:model.tideheight.doubleValue data:model tag:0];
                if ([model.tag isEqualToString:@"高潮"]) {
                    data.icon = [UIImage imageNamed:@"hlogo"];
                    data.tag = 1;
                }
                else if ([model.tag isEqualToString:@"低潮"]){
                    data.icon = [UIImage imageNamed:@"llogo"];
                    data.tag = 2;
                }
                else{
//                    data.icon = [UIImage imageNamed:@"point"];
                }
                [xValues addObject:model.tidetime];
            }
                break;
            case 2:
            {
                //波高
                SeaDataInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"2";
                data = [[ChartDataEntry alloc] initWithX:i y:model.waveheight.doubleValue data:model];
                data.icon = [self imageString:model.wavedfrom];
                [xValues addObject:model.time];
            }
                break;
            case 3:
            {
                //海温
                SeaDataInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"3";
                data = [[ChartDataEntry alloc] initWithX:i y:model.sstdata.doubleValue data:model];
                [xValues addObject:model.time];
            }
                break;
            case 4:
            {
                //海风
                SeaDataInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"4";
                data = [[ChartDataEntry alloc] initWithX:i y:model.waveheight.doubleValue data:model];
                data.icon = [self imageString:model.swdirection];
                [xValues addObject:model.time];
            }
                break;
            case 5:
            {
                //海流
                SeaStreamInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"1";
                data = [[ChartDataEntry alloc] initWithX:i y:model.wavespeed.doubleValue data:model];
                data.icon = [self imageString:model.imageName];
                [xValues addObject:model.time];
            }
                break;

            default:
                break;
        }
        [dataValues addObject:data];
    }
    
    LineChartDataSet *set1 = nil;
    //请注意这里，如果你的图表以前绘制过，那么这里直接重新给data赋值就行了。
    //如果没有，那么要先定义set的属性。
    if (self.lineChartView1.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.lineChartView1.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1=(LineChartDataSet*)self.lineChartView1.data.dataSets[0];
        set1.values = dataValues;
        //通知data去更新
        [self.lineChartView1.data notifyDataChanged];
        //通知图表去更新
        [self.lineChartView1 notifyDataSetChanged];
    }else{
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc] initWithValues:dataValues];
        //自定义set的各种属性
        //设置折线的样式
        set1.mode = LineChartModeCubicBezier;
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        set1.drawIconsEnabled = YES;
        if (self.type == 1) {
            set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        }
        else{
            set1.drawValuesEnabled = NO;//是否在拐点处显示数据
        }
        [set1 setCircleColor:kColorAppMain];
        [set1 setColor:kColorAppMain];//折线颜色
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.circleRadius = 0;
        set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
//        set1.highlightColor = [UIColor clearColor];
        NSMutableArray * dataSets = [NSMutableArray array];
        [dataSets addObject:set1];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData * data= [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont systemFontOfSize:10.f]];//文字字体
        [data setValueTextColor:kColorBlack];//文字颜色
        self.lineChartView1.data = data;
    }
    
    if (self.type != 3) {
        [self.lineChartView1 zoomToCenterWithScaleX:3 scaleY:1];
        index1 = 0;
        for (id model in dataArray) {
            index1 = [dataArray indexOfObject:model];
            if ([model isKindOfClass:[SeaWaterLevelInfoModel class]]) {
                SeaWaterLevelInfoModel * m = (SeaWaterLevelInfoModel *)model;
                if ([[m.forecastdate substringToIndex:10] isEqualToString:[CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"]]) {
                    break;
                }
            }
            else if ([model isKindOfClass:[SeaDataInfoModel class]]){
                SeaDataInfoModel * m = (SeaDataInfoModel *)model;
                if ([[m.forecasttime substringToIndex:10] isEqualToString:[CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"]]) {
                    break;
                }
            }
            else if ([model isKindOfClass:[SeaStreamInfoModel class]]){
                SeaStreamInfoModel * m = (SeaStreamInfoModel *)model;
                if ([[m.forecastdate substringToIndex:10] isEqualToString:[CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"]]) {
                    break;
                }
            }
        }
        [self.lineChartView1 moveViewToX:index1];
        [self chartTranslated:self.lineChartView1 dX:9999 dY:0];
    }
}

- (void)updateSecondLineChartViewData{
    NSMutableArray* dataValues = [[NSMutableArray alloc] init];
    [xValues2 removeAllObjects];
    for (int i=0; i<dataArray2.count; i++) {
        BarChartDataEntry * data;
        SpeedInfoModel * model = [dataArray2 objectAtIndex:i];
        data = [[BarChartDataEntry alloc] initWithX:i y:model.rate.doubleValue data:model];
        [xValues2 addObject:model.speed];
        [dataValues addObject:data];
    }
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:dataValues];
    set1.drawValuesEnabled = NO;
    set1.highlightEnabled = NO;
    UIColor * color = [UIColor hexChangeFloat:@"9DC3E6"];
    [set1 setColors:@[color]];
    [set1 setBarBorderColor:[UIColor whiteColor]];
    [set1 setValueTextColor:kColorGray];
    [set1 setValueFont:[UIFont systemFontOfSize:10]];
    set1.barBorderWidth = 1.0;

    BarChartData * data = [[BarChartData alloc] initWithDataSets:@[set1]];
    data.barWidth = 1.0f;
    [self.barChartView setData:data];
}

- (void)updateThirdRadarChartViewData{
    //每个维度的名称或描述
    NSMutableArray *xVals = [[NSMutableArray alloc] initWithObjects:@"N",@"NNE",@"NE",@"ENE",@"E",@"ESE",@"SE",@"SSE",@"S",@"SSW",@"SW",@"  WSW",@"  W",@"  WNW",@"NW",@"NNW", nil];

    //每个维度的数据
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataArray2.count; i++) {
        DirectionInfoModel * model = [dataArray2 objectAtIndex:i];
        double index = [self radarChartXIndex:model.direction];
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:index y:[model.rate floatValue] data:model];
        entry.icon = [UIImage imageNamed:@"point"];
        [yVals1 addObject:entry];
    }
    
    // dataSet
    RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithValues:yVals1 label:@""];
    set1.lineWidth = 0.5;//数据折线线宽
    [set1 setColor:kColorAppMain];//数据折线颜色
    set1.drawFilledEnabled = YES;//是否填充颜色
    set1.fillColor = kColorAppMain;
    set1.fillAlpha = 0.5;//填充透明度
    set1.drawIconsEnabled = YES;
    set1.drawValuesEnabled = NO;//是否绘制显示数据
    set1.highlightEnabled = YES;
    set1.highlightColor = [UIColor clearColor];
    //data
    RadarChartData * data = [[RadarChartData alloc] initWithDataSets:@[set1]];
    self.radarChartView.data = data;
    self.radarChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xVals];
}

- (void)refreshSpeedLabelInfo{
    NSString * str1 = self.type==2?[NSString stringWithFormat:@"最大浪高:%@m",[speedInfoDic objectForKey:@"maxValue"]]:[NSString stringWithFormat:@"最大风速:%@m/s",[speedInfoDic objectForKey:@"maxValue"]];
    NSString * str2 = self.type==2?[NSString stringWithFormat:@"平均浪高:%@m",[speedInfoDic objectForKey:@"avg"]]:[NSString stringWithFormat:@"平均风速:%@m/s",[speedInfoDic objectForKey:@"avg"]];
    NSString * str3 = self.type==2?[NSString stringWithFormat:@"最小浪高:%@m",[speedInfoDic objectForKey:@"minValue"]]:[NSString stringWithFormat:@"最小风速:%@m/s",[speedInfoDic objectForKey:@"minValue"]];
    
    if (self.type == 2) {
        NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@",str1,str2,str3];
        NSMutableAttributedString * labelAttrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距
        paragraphStyle.lineSpacing = 5.0f;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        [labelAttrStr addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, str.length)];
        self.speedInfoLabel.attributedText = labelAttrStr;
    }
    else{
        NSString * str = [NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
        self.tipLabel2.text = str;
        self.tipLabel2.font = kFontSize24;
    }
}

- (double)radarChartXIndex:(NSString *)directionStr{
    double arrayIndex = 0.0;
    NSArray *xVals = [[NSArray alloc] initWithObjects:@"N",@"NNE",@"NE",@"ENE",@"E",@"ESE",@"SE",@"SSE",@"S",@"SSW",@"SW",@"WSW",@"W",@"WNW",@"NW",@"NNW", nil];
    for (NSString * str in xVals) {
        if ([str isEqualToString:directionStr]) {
            arrayIndex = [xVals indexOfObject:str];
            break;
        }
    }
    
    return arrayIndex;
}

- (UIImage *)imageString:(NSString *)directionStr{
    UIImage * image;
    if ([directionStr isEqualToString:@"北"]) {
        image = [UIImage imageNamed:@"bei"];
    }
    else if ([directionStr isEqualToString:@"北西北、北北西"] || [directionStr isEqualToString:@"北北西"] || [directionStr isEqualToString:@"北西北"] ){
        image = [UIImage imageNamed:@"beibeixi"];
    }
    else if ([directionStr isEqualToString:@"东"]){
        image = [UIImage imageNamed:@"dong"];
    }
    else if ([directionStr isEqualToString:@"东北"]){
        image = [UIImage imageNamed:@"dongbei"];
    }
    else if ([directionStr isEqualToString:@"北东北、北北东"] || [directionStr isEqualToString:@"北东北"] || [directionStr isEqualToString:@"北北东"]){
        image = [UIImage imageNamed:@"beibeidong"];
    }
    else if ([directionStr isEqualToString:@"东东北、东北东"] || [directionStr isEqualToString:@"东东北"] || [directionStr isEqualToString:@"东北东"]){
        image = [UIImage imageNamed:@"dongbeidong"];
    }
    else if ([directionStr isEqualToString:@"东东南、东南东"] || [directionStr isEqualToString:@"东东南"] || [directionStr isEqualToString:@"东南东"]){
        image = [UIImage imageNamed:@"dongnandong"];
    }
    else if ([directionStr isEqualToString:@"东南"]){
        image = [UIImage imageNamed:@"dongnan"];
    }
    else if ([directionStr isEqualToString:@"南"]){
        image = [UIImage imageNamed:@"nan"];
    }
    else if ([directionStr isEqualToString:@"南东南、南南东"] || [directionStr isEqualToString:@"南东南"] || [directionStr isEqualToString:@"南南东"]){
        image = [UIImage imageNamed:@"nannandong"];
    }
    else if ([directionStr isEqualToString:@"南西南、南南西"] || [directionStr isEqualToString:@"南西南"] || [directionStr isEqualToString:@"南南西"]){
        image = [UIImage imageNamed:@"nannanxi"];
    }
    else if ([directionStr isEqualToString:@"西"]){
        image = [UIImage imageNamed:@"xi"];
    }
    else if ([directionStr isEqualToString:@"西北"]){
        image = [UIImage imageNamed:@"xibei"];
    }
    else if ([directionStr isEqualToString:@"西南"]){
        image = [UIImage imageNamed:@"xinan"];
    }
    else if ([directionStr isEqualToString:@"西西北、西北西"] || [directionStr isEqualToString:@"西北西"] || [directionStr isEqualToString:@"西西北"]){
        image = [UIImage imageNamed:@"xibeixi"];
    }
    else if ([directionStr isEqualToString:@"西西南、西南西"] || [directionStr isEqualToString:@"西南西"] || [directionStr isEqualToString:@"西西南"]){
        image = [UIImage imageNamed:@"xinanxi"];
    }
    
    return image;
}

- (void)chartButtonClick:(UIButton *)sender{
    ListInfoViewController * vc = [[ListInfoViewController alloc] init];
    if (self.type == 1) {
        vc.type = 1;
        vc.titleStr = @"水位数据展示";
    }
    else if (self.type == 5){
        vc.type = 2;
        vc.titleStr = @"流速流向数据展示";
    }
    else if (self.type == 2){
        vc.type = 4;
        vc.titleStr = @"浪高数据展示";
    }
    vc.dataArray = dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftchartButtonClick:(UIButton *)sender{
    if (sender == self.leftchartButton1) {
        self.leftchartButton1.selected = !self.leftchartButton1.selected;
        if (self.leftchartButton1.selected) {
            waterLevelCount = 5;
        }
        else{
            waterLevelCount = 12;
        }
        [self resetDipView1];
    }
    else{
        [self resetDipView1];
    }
}

- (void)resetDipView1{
    for (UIView * view in self.dipView1.subviews) {
        [view removeFromSuperview];
    }
    [self.dipView1 removeFromSuperview];
    self.dipView1 = nil;
    self.titleLabel1 = nil;
    self.leftchartButton1 = nil;
    self.leftchartButton2 = nil;
    self.chartButton = nil;
    self.lineChartView1 = nil;
    self.leftTimeLabel1 = nil;
    self.rightTimeLabel1 = nil;

    [self configureChartView];
}

- (void)getWaterLevelData{
    NSString * str = @"";
    NSString * startDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString * endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    str = [NSString stringWithFormat:@"marine/getWaterLevel?fstarttime=%@&fendtime=%@&type=%d",startDateStr,endDateStr,waterLevelCount];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil
                        SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
                            if (succ) {
                                NSDictionary * dic = (NSDictionary *)rspData;
                                NSArray * contentArr = [dic objectForKey:@"content"];
                                [self->dataArray removeAllObjects];
                                for (NSDictionary * data in contentArr) {
                                    SeaWaterLevelInfoModel * model = [[SeaWaterLevelInfoModel alloc] initWithDictionary:data error:nil];
                                    [self->dataArray addObject:model];
                                }
                                [self updateFirstLineChartViewData];
                            }
                        } FailBlock:^(NSError *error) {
                            
                        }];
}

- (void)getSeaStremSpeedData{
    NSString * str = @"";
    NSString * startDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString * endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    str = [NSString stringWithFormat:@"marine/getSeaStream?fstarttime=%@&fendtime=%@",startDateStr,endDateStr];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * contentArr = [dic objectForKey:@"content"];
            [self->dataArray removeAllObjects];
            for (NSDictionary * data in contentArr) {
                SeaStreamInfoModel * infoModel = [[SeaStreamInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray addObject:infoModel];
            }
            [self updateFirstLineChartViewData];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)getSeaTemData{
    NSString * str = @"";
    NSString * dateStr;
    NSString * endDateStr;
    if (self.type == 3) {
        dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-29*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
        endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
        str = [NSString stringWithFormat:@"marine/getMarineData?fstarttime=%@&fendtime=%@",dateStr,endDateStr];
    }
    else{
        dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
        endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
        str = [NSString stringWithFormat:@"marine/getMarineData?fstarttime=%@&fendtime=%@",dateStr,endDateStr];
    }
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            
            NSArray * contentArr = [dic objectForKey:@"content"];
            [self->dataArray removeAllObjects];
            for (NSDictionary * data in contentArr) {
                SeaDataInfoModel * infoModel = [[SeaDataInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray addObject:infoModel];
                if (self.type == 2 || self.type == 4) {
                    self.tipLabel1.text = [NSString stringWithFormat:@"%@发布",[CommonUtils formatTime:[CommonUtils getFormatTime:infoModel.fstarttime FormatStyle:@"yyyy-MM-dd HH:mm:ss"] FormatStyle:@"yyyy年MM月dd日 HH:mm"]];
                    self.tipLabel.text = [NSString stringWithFormat:@"%@网",infoModel.source];
                }
                if (self.tipLabel1.text.length == 0) {
                    self.tipLabel1.text = [NSString stringWithFormat:@"来源:%@%@",infoModel.source,infoModel.fstarttime];
                }
            }
            [self updateFirstLineChartViewData];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)get30DaysSeaTemData{
    NSString *dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-30*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString *endDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString *str = [NSString stringWithFormat:@"marine/getDirectionData?fstarttime=%@&fendtime=%@&type=%@",dateStr,endDateStr,self.type==2?@"hl":@"hf"];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * contentArr = [dic objectForKey:@"content"];
            [self->dataArray2 removeAllObjects];
            for (NSDictionary * data in contentArr) {
                DirectionInfoModel * infoModel = [[DirectionInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray2 addObject:infoModel];
            }
            [self updateThirdRadarChartViewData];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)getMarineStatistics{
    NSString *dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-30*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString *endDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString * typeStr;
    if (self.type == 2) {
        typeStr = @"hl";
    }
    else if (self.type == 4){
        typeStr = @"hf";
    }
    else if (self.type == 5){
        typeStr = @"ls";
    }
    NSString *str = [NSString stringWithFormat:@"marine/getMarineStatistics?fstarttime=%@&fendtime=%@&type=%@",dateStr,endDateStr,typeStr];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            self->speedInfoDic = nil;
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * arr = [dic objectForKey:@"content"];
            if (arr.count) {
                self->speedInfoDic = [arr firstObject];
                [self refreshSpeedLabelInfo];
            }
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)getStreamHistogram{
    NSString *dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString *endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString *str = [NSString stringWithFormat:@"marine/getStreamHistogram?fstarttime=%@&fendtime=%@",dateStr,endDateStr];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * arr = [dic objectForKey:@"content"];
            [self->dataArray2 removeAllObjects];
            if (arr.count) {
                for (NSDictionary * data in arr) {
                    SpeedInfoModel * model = [[SpeedInfoModel alloc] initWithDictionary:data error:nil];
                    [self->dataArray2 addObject:model];
                }
            }
            [self updateSecondLineChartViewData];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    
}

- (void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    if (dX == 0) {
        if (chartView == self.lineChartView1) {
            double firstValue = [[indexArray1 firstObject] doubleValue];
            double lastValue = [[indexArray1 lastObject] doubleValue];
            if (self.type == 1) {
                SeaWaterLevelInfoModel * firstModel = [dataArray objectAtIndex:firstValue];
                SeaWaterLevelInfoModel * lastModel = [dataArray objectAtIndex:lastValue];
                self.leftTimeLabel1.text = [firstModel.forecastdate substringToIndex:10];
                self.rightTimeLabel1.text = [lastModel.forecastdate substringToIndex:10];
            }
            else if (self.type == 2 || self.type == 3 || self.type == 4){
                SeaDataInfoModel * firstModel = [dataArray objectAtIndex:firstValue];
                SeaDataInfoModel * lastModel = [dataArray objectAtIndex:lastValue];
                self.leftTimeLabel1.text = [firstModel.forecasttime substringToIndex:10];
                self.rightTimeLabel1.text = [lastModel.forecasttime substringToIndex:10];
            }
            else if (self.type == 5){
                SeaStreamInfoModel * firstModel = [dataArray objectAtIndex:firstValue];
                SeaStreamInfoModel * lastModel = [dataArray objectAtIndex:lastValue];
                self.leftTimeLabel1.text = [firstModel.forecastdate substringToIndex:10];
                self.rightTimeLabel1.text = [lastModel.forecastdate substringToIndex:10];
            }
            [indexArray1 removeAllObjects];
        }
    }
    else if (dX == 9999){
        self.leftTimeLabel1.text = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"];
        self.rightTimeLabel1.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
    }
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    if (axis == self.lineChartView1.xAxis) {
        if (xValues.count == 0) {
            return @"";
        }
        [indexArray1 addObject:[NSNumber numberWithDouble:value]];
        
        return [xValues objectAtIndex:value];
    }
    else{
        if (xValues2.count == 0) {
            return @"";
        }
        
        [indexArray2 addObject:[NSNumber numberWithDouble:value]];
        
        return [xValues2 objectAtIndex:value];
    }
}

@end
