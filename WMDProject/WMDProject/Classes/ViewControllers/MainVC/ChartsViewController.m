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
#import "WebViewViewController.h"


@interface ChartsViewController ()<ChartViewDelegate,IChartAxisValueFormatter>
{
    NSMutableArray * dataArray;
    NSMutableArray * dataArray2;
    NSMutableArray * dataArray4;
    NSMutableArray * xValues;
    NSMutableArray* xValues2;
    NSMutableArray * indexArray1;
    NSMutableArray * indexArray2;
    
    NSUInteger index1;
    NSUInteger index2;
    
    NSDictionary * speedInfoDic;
    
    int waterLevelCount;
}

@property (nonatomic,strong) UIButton * titleButton;

@property (nonatomic,strong) UIView * dipView1;

@property (nonatomic,strong) UILabel * tLabel;//表单位

@property (nonatomic,strong) UILabel * tipLabel1;

@property (nonatomic,strong) UIButton * chartButton;

@property (nonatomic,strong) UIButton * leftchartButton1;

@property (nonatomic,strong) UIButton * leftchartButton2;

@property (nonatomic,strong) LineChartView * lineChartView1;

//海温30天曲线图
@property (nonatomic,strong) UIView * dipView4;

@property (nonatomic,strong) UILabel * tLabel4;//表单位

@property (nonatomic,strong) UILabel * leftLabel4;

@property (nonatomic,strong) UILabel * tipLabel4;

@property (nonatomic,strong) LineChartView * lineChartView4;


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

- (UIButton *)titleButton{
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.frame = CGRectMake(0, 0, 120, 44);
        _titleButton.backgroundColor = [UIColor clearColor];
        [_titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _titleButton.titleLabel.font = kFontSize34;
        [_titleButton addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _titleButton;
}

- (UIView *)dipView1{
    if (!_dipView1) {
        _dipView1 = [[UIView alloc] init];
        _dipView1.backgroundColor = [UIColor hexChangeFloat:@"ffffff" alpha:0.7];
        _dipView1.layer.masksToBounds = YES;
        _dipView1.layer.cornerRadius = 5;
    }
    
    return _dipView1;
}

- (UILabel *)tLabel{
    if (!_tLabel) {
        _tLabel = [[UILabel alloc]init];
        _tLabel.backgroundColor = [UIColor clearColor];
        _tLabel.font = kFontSize26;
        _tLabel.textAlignment = NSTextAlignmentLeft;
        _tLabel.textColor = kColorBlack;
    }

    return _tLabel;
}

- (UILabel *)tipLabel1{
    if (!_tipLabel1) {
        _tipLabel1 = [[UILabel alloc]init];
        _tipLabel1.backgroundColor = [UIColor clearColor];
        _tipLabel1.numberOfLines = 2;
        _tipLabel1.lineBreakMode = NSLineBreakByWordWrapping;
        _tipLabel1.font = [UIFont systemFontOfSize:10];
        _tipLabel1.textAlignment = NSTextAlignmentRight;
        _tipLabel1.textColor = kColorBlack;
    }
    
    return _tipLabel1;
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
        [_leftchartButton2 setImage:[UIImage imageNamed:@"24unlock"] forState:UIControlStateHighlighted];
        [_leftchartButton2 setImage:[UIImage imageNamed:@"24unlock"] forState:UIControlStateNormal];
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
        _lineChartView1.noDataText = @"数据加载中";
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
        xAxis.drawLabelsEnabled = YES;
        xAxis.gridColor = [UIColor whiteColor];
        xAxis.valueFormatter = self;
        xAxis.avoidFirstLastClippingEnabled = YES;
        [xAxis setGranularity:1.f];
        
        ChartYAxis *leftAxis =_lineChartView1.leftAxis;
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        leftAxis.axisLineColor = [UIColor whiteColor];
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = kColorBlack;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.drawGridLinesEnabled = YES;
        [leftAxis setGranularity:0.1f];
        if (self.type != 2) {
            leftAxis.axisMinimum = 0;
        }
        NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
        rightAxisFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        rightAxisFormatter.maximumFractionDigits = 1;
        rightAxisFormatter.minimumFractionDigits = 1;
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:rightAxisFormatter];
    }
    
    return _lineChartView1;
}

- (UIView *)dipView4{
    if (!_dipView4) {
        _dipView4 = [[UIView alloc] init];
        _dipView4.backgroundColor = [UIColor hexChangeFloat:@"ffffff" alpha:0.7];
        _dipView4.layer.masksToBounds = YES;
        _dipView4.layer.cornerRadius = 5;
    }
    
    return _dipView4;
}

- (UILabel *)tLabel4{
    if (!_tLabel4) {
        _tLabel4 = [[UILabel alloc]init];
        _tLabel4.backgroundColor = [UIColor clearColor];
        _tLabel4.font = kFontSize26;
        _tLabel4.textAlignment = NSTextAlignmentLeft;
        _tLabel4.textColor = kColorBlack;
    }
    
    return _tLabel4;
}

- (UILabel *)tipLabel4{
    if (!_tipLabel4) {
        _tipLabel4 = [[UILabel alloc]init];
        _tipLabel4.backgroundColor = [UIColor clearColor];
        _tipLabel4.font = [UIFont systemFontOfSize:10];
        _tipLabel4.textAlignment = NSTextAlignmentRight;
        _tipLabel4.textColor = kColorBlack;
        _tipLabel4.numberOfLines = 2;
        _tipLabel4.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _tipLabel4;
}

- (UILabel *)leftLabel4{
    if (!_leftLabel4) {
        _leftLabel4 = [[UILabel alloc]init];
        _leftLabel4.backgroundColor = [UIColor clearColor];
        _leftLabel4.font = [UIFont systemFontOfSize:10];
        _leftLabel4.textAlignment = NSTextAlignmentLeft;
        _leftLabel4.textColor = kColorBlack;
        _leftLabel4.text = @"30天海温变化曲线";
    }
    
    return _leftLabel4;
}

- (LineChartView *)lineChartView4{
    if (!_lineChartView4) {
        _lineChartView4 = [[LineChartView alloc] init];
        _lineChartView4.dragEnabled = YES;
        _lineChartView4.dragDecelerationEnabled = NO;
        _lineChartView4.delegate = self;
        _lineChartView4.chartDescription.enabled = NO;
        _lineChartView4.legend.enabled = NO;
        _lineChartView4.doubleTapToZoomEnabled = NO;
        _lineChartView4.noDataText = @"数据加载中";
        _lineChartView4.noDataFont = kFontSize34;
        [_lineChartView4 setScaleEnabled:YES];
        _lineChartView4.pinchZoomEnabled = NO;
        _lineChartView4.rightAxis.enabled = NO;
        [_lineChartView4 animateWithXAxisDuration:1.0f];
        
        ChartXAxis *xAxis = _lineChartView4.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        xAxis.axisLineColor = [UIColor whiteColor];
        xAxis.granularityEnabled = NO;
        xAxis.labelTextColor = kColorBlack;
        xAxis.drawGridLinesEnabled = YES;
        xAxis.drawLabelsEnabled = YES;
        xAxis.gridColor = [UIColor whiteColor];
        xAxis.valueFormatter = self;
        [xAxis setGranularity:1.f];
        xAxis.avoidFirstLastClippingEnabled = YES;

        ChartYAxis *leftAxis =_lineChartView4.leftAxis;
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        leftAxis.axisLineColor = [UIColor whiteColor];
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = kColorBlack;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.drawGridLinesEnabled = YES;
        [leftAxis setGranularity:0.1f];
        NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
        rightAxisFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        rightAxisFormatter.maximumFractionDigits = 1;
        rightAxisFormatter.minimumFractionDigits = 1;
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:rightAxisFormatter];
    }
    
    return _lineChartView4;
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
    }
    
    return _dipSybomlLabel;
}

- (BarChartView *)barChartView{
    if (!_barChartView) {
        _barChartView = [[BarChartView alloc] init];
        _barChartView.delegate = self;
        _barChartView.chartDescription.enabled = NO;
        _barChartView.legend.enabled = NO;
        [_barChartView animateWithXAxisDuration:1.0f];
        _barChartView.rightAxis.enabled = NO;
        _barChartView.doubleTapToZoomEnabled = NO;
        _barChartView.noDataText = @"数据加载中";
        _barChartView.noDataFont = kFontSize34;
        [_barChartView setScaleEnabled:YES];
        _barChartView.pinchZoomEnabled = NO;
        _barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        _barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
        
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
        NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
        rightAxisFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        rightAxisFormatter.maximumFractionDigits = 3;
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:rightAxisFormatter];

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
        _radarChartView.delegate = self;
        _radarChartView.backgroundColor = [UIColor clearColor];
        _radarChartView.legend.enabled = NO;
        _radarChartView.rotationEnabled = NO;//是否允许转动
        _radarChartView.webLineWidth = 0.5;//主干线线宽
        _radarChartView.webColor = [UIColor whiteColor];//主干线线宽
        _radarChartView.innerWebLineWidth = 0.375;//边线宽度
        _radarChartView.innerWebColor = [UIColor whiteColor];//边线颜色
        _radarChartView.webAlpha = 1;//透明度

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
        
        [_radarChartView animateWithXAxisDuration:1.4 yAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
        
        _radarChartView.userInteractionEnabled = YES;
        _radarChartView.drawMarkers = YES;

        BalloonMarker * marker = [[BalloonMarker alloc]
                                  initWithColor: kColorAppMain
                                  font: [UIFont systemFontOfSize:10.0f]
                                  textColor: UIColor.whiteColor
                                  insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = _radarChartView;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        _radarChartView.marker = marker;        
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
    self.dipImageView.image = [UIImage imageNamed:@"bg_chart"];
    self.hiddenLeftItem = NO;
    
    if (self.type == 1) {
        [self.titleButton setTitle:@"潮高" forState:UIControlStateNormal];
        waterLevelCount = 12;//默认12分钟间隔
    }
    else if (self.type == 3){
        [self.titleButton setTitle:@"浪高" forState:UIControlStateNormal];
    }
    else if (self.type == 2){
        [self.titleButton setTitle:@"海温" forState:UIControlStateNormal];
    }
    else if (self.type == 4){
        [self.titleButton setTitle:@"海风" forState:UIControlStateNormal];
    }
    else{
        [self.titleButton setTitle:@"海流" forState:UIControlStateNormal];
    }
    self.navigationItem.titleView = self.titleButton;
    
    [self configureChartView];
}


- (void)configureChartView{
    __weak typeof(self) weakSelf = self;
    
    CGFloat heght = (SCREEN_HEIGHT-84-25-20)/2;
    
    //潮高 显示曲线图+直方图
    if (self.type == 1) {
        [self.view addSubview:self.dipView1];
        [self.dipView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view).mas_offset(kStatusBarAndNavigationBarHeight);
            make.left.mas_equalTo(weakSelf.view).mas_offset(15);
            make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
            make.height.mas_offset(heght);
        }];
        
        [self.dipView1 addSubview:self.chartButton];
        [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.dipView1 addSubview:self.tLabel];
        [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(20);
            make.top.mas_equalTo(weakSelf.chartButton.mas_bottom).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(40, 13));
        }];
        
        [self.dipView1 addSubview:self.leftchartButton2];
        [self.leftchartButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.chartButton.mas_right).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.dipView1 addSubview:self.leftchartButton1];
        [self.leftchartButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.leftchartButton2.mas_right).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        if (waterLevelCount == 5) {
            self.leftchartButton1.selected = YES;
        }
        else{
            self.leftchartButton1.selected = NO;
        }
        
        [self.dipView1 addSubview:self.tipLabel1];
        [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(180, 20));
        }];
        
        [self.dipView1 addSubview:self.lineChartView1];
        [self.lineChartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
            make.bottom.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
        }];
        
        BalloonMarker * marker = [[BalloonMarker alloc]
                                  initWithColor: kColorAppMain
                                  font: [UIFont systemFontOfSize:10.0f]
                                  textColor: UIColor.whiteColor
                                  insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = self.lineChartView1;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        self.lineChartView1.marker = marker;
        
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
        self.leftTimeLabel2.text = @"潮高直方图:";

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
        self.tipLabel2.textAlignment = NSTextAlignmentCenter;
        
        [self.dipView2 addSubview:self.dipSybomlLabel];
        [self.dipSybomlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-25);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(20, 12));
        }];
        self.dipSybomlLabel.text = @"m";
        
        [self.dipView2 addSubview:self.barChartView];
        [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.topSybomlLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-20);
            make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-20);
        }];
        
        BalloonMarker * barMarker = [[BalloonMarker alloc]
                                     initWithColor: kColorAppMain
                                     font: [UIFont systemFontOfSize:10.0f]
                                     textColor: UIColor.whiteColor
                                     insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        barMarker.chartView = self.barChartView;
        barMarker.minimumSize = CGSizeMake(80.f, 40.f);
        self.barChartView.marker = barMarker;
    }
    //海温 显示曲线图+曲线图
    else if (self.type == 2){
        [self.view addSubview:self.dipView1];
        [self.dipView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view).mas_offset(kStatusBarAndNavigationBarHeight);
            make.left.mas_equalTo(weakSelf.view).mas_offset(15);
            make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
            make.height.mas_offset(heght);
        }];
        
        [self.dipView1 addSubview:self.chartButton];
        [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.dipView1 addSubview:self.tLabel];
        [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(20);
            make.top.mas_equalTo(weakSelf.chartButton.mas_bottom).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(40, 13));
        }];
        
        [self.dipView1 addSubview:self.tipLabel1];
        [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(180, 30));
        }];
        
        [self.dipView1 addSubview:self.lineChartView1];
        [self.lineChartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
            make.bottom.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
        }];
        
        BalloonMarker * marker = [[BalloonMarker alloc]
                                  initWithColor: kColorAppMain
                                  font: [UIFont systemFontOfSize:10.0f]
                                  textColor: UIColor.whiteColor
                                  insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = self.lineChartView1;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        self.lineChartView1.marker = marker;

        [self.view addSubview:self.dipView4];
        [self.dipView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView1.mas_bottom).mas_offset(25);
            make.left.mas_equalTo(weakSelf.view).mas_offset(15);
            make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
            make.height.mas_offset(heght);
        }];
        
        [self.dipView4 addSubview:self.leftLabel4];
        [self.leftLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView4).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView4).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        [self.dipView4 addSubview:self.tLabel4];
        [self.tLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView4).mas_offset(20);
            make.top.mas_equalTo(weakSelf.leftLabel4.mas_bottom).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(40, 13));
        }];
        
        [self.dipView4 addSubview:self.tipLabel4];
        [self.tipLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView4).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView4).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(180, 30));
        }];
        
        [self.dipView4 addSubview:self.lineChartView4];
        [self.lineChartView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tLabel4.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView4).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView4).mas_offset(-10);
            make.bottom.mas_equalTo(weakSelf.dipView4).mas_offset(-10);
        }];
        
        BalloonMarker * marker4 = [[BalloonMarker alloc]
                                   initWithColor: kColorAppMain
                                   font: [UIFont systemFontOfSize:10.0f]
                                   textColor: UIColor.whiteColor
                                   insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker4.chartView = self.lineChartView4;
        marker4.minimumSize = CGSizeMake(80.f, 40.f);
        self.lineChartView4.marker = marker4;
    }
    //波高 显示曲线图+玫瑰图
    else if (self.type == 3){
        [self.view addSubview:self.dipView1];
        [self.dipView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view).mas_offset(kStatusBarAndNavigationBarHeight);
            make.left.mas_equalTo(weakSelf.view).mas_offset(15);
            make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
            make.height.mas_offset(heght);
        }];
        
        [self.dipView1 addSubview:self.chartButton];
        [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.dipView1 addSubview:self.tLabel];
        [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(20);
            make.top.mas_equalTo(weakSelf.chartButton.mas_bottom).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(40, 13));
        }];
        
        [self.dipView1 addSubview:self.tipLabel1];
        [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(180, 30));
        }];
        
        [self.dipView1 addSubview:self.lineChartView1];
        [self.lineChartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
            make.bottom.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
        }];
        
        BalloonMarker * marker = [[BalloonMarker alloc]
                                  initWithColor: kColorAppMain
                                  font: [UIFont systemFontOfSize:10.0f]
                                  textColor: UIColor.whiteColor
                                  insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = self.lineChartView1;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        self.lineChartView1.marker = marker;

        [self configureRadarChartView];
    }
    //海风 显示曲线图+玫瑰图
    else if (self.type == 4){
        [self.view addSubview:self.dipView1];
        [self.dipView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view).mas_offset(kStatusBarAndNavigationBarHeight);
            make.left.mas_equalTo(weakSelf.view).mas_offset(15);
            make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
            make.height.mas_offset(heght);
        }];
        
        [self.dipView1 addSubview:self.chartButton];
        [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.dipView1 addSubview:self.tLabel];
        [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(20);
            make.top.mas_equalTo(weakSelf.chartButton.mas_bottom).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(40, 13));
        }];
        
        [self.dipView1 addSubview:self.tipLabel1];
        [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(180, 20));
        }];
        
        [self.tipLabel1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(180, 30));
        }];
        
        [self.dipView1 addSubview:self.lineChartView1];
        [self.lineChartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
            make.bottom.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
        }];
        
        BalloonMarker * marker = [[BalloonMarker alloc]
                                  initWithColor: kColorAppMain
                                  font: [UIFont systemFontOfSize:10.0f]
                                  textColor: UIColor.whiteColor
                                  insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = self.lineChartView1;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        self.lineChartView1.marker = marker;
        
        [self configureRadarChartView];
    }
    //海流 显示曲线图+直方图
    else{
        [self.view addSubview:self.dipView1];
        [self.dipView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view).mas_offset(kStatusBarAndNavigationBarHeight);
            make.left.mas_equalTo(weakSelf.view).mas_offset(15);
            make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
            make.height.mas_offset(heght);
        }];
        
        [self.dipView1 addSubview:self.chartButton];
        [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.dipView1 addSubview:self.tLabel];
        [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(20);
            make.top.mas_equalTo(weakSelf.chartButton.mas_bottom).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(40, 13));
        }];
        
        [self.dipView1 addSubview:self.tipLabel1];
        [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView1).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(180, 20));
        }];
        
        [self.dipView1 addSubview:self.lineChartView1];
        [self.lineChartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
            make.bottom.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
        }];
        
        BalloonMarker * marker = [[BalloonMarker alloc]
                                  initWithColor: kColorAppMain
                                  font: [UIFont systemFontOfSize:10.0f]
                                  textColor: UIColor.whiteColor
                                  insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = self.lineChartView1;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        self.lineChartView1.marker = marker;
        
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
        self.leftTimeLabel2.text = @"潮高直方图:";
        
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
        self.tipLabel2.textAlignment = NSTextAlignmentCenter;
        
        [self.dipView2 addSubview:self.dipSybomlLabel];
        [self.dipSybomlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-25);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-8);
            make.size.mas_equalTo(CGSizeMake(20, 12));
        }];
        self.dipSybomlLabel.text = @"m/s";
        
        [self.dipView2 addSubview:self.barChartView];
        [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.topSybomlLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-20);
            make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-20);
        }];
        
        BalloonMarker * barMarker = [[BalloonMarker alloc]
                                     initWithColor: kColorAppMain
                                     font: [UIFont systemFontOfSize:10.0f]
                                     textColor: UIColor.whiteColor
                                     insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        barMarker.chartView = self.barChartView;
        barMarker.minimumSize = CGSizeMake(80.f, 40.f);
        self.barChartView.marker = barMarker;
    }
    
    //1 水位  3 波高 2 海温  4 海风 5 海流
    if (self.type == 1) {
        [self.tLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_equalTo(30);
        }];
        self.tLabel.text = @"m";
    }
    else if (self.type == 2){
        dataArray4 = [NSMutableArray array];
        [self.tLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_equalTo(30);
        }];
        self.tLabel.text = @"℃";

        [self.tLabel4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView4).mas_equalTo(25);
        }];
        self.tLabel4.text = @"℃";
    }
    else if (self.type == 3) {
        [self.tLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView1).mas_equalTo(30);
        }];
        self.tLabel.text = @"m";
    }
    else{
        self.tLabel.text = @"m/s";
    }
    
    dataArray = [NSMutableArray array];
    dataArray2 = [NSMutableArray array];
    xValues = [NSMutableArray array];
    xValues2 = [NSMutableArray array];
    indexArray1 = [NSMutableArray array];
    indexArray2 = [NSMutableArray array];

    if (self.type != 4) {
        //非海风
        self.tipLabel1.text = @"红沿河海域实测数据预报";

        switch (self.type) {
            case 1:
            {
                [self getWaterLevelData];
                [self getStreamHistogram];
                [self getMarineStatistics];
            }
                break;
            case 2:
            {
                [self getSeaTemData];
                [self get30SeaTemData];
            }
                break;
            case 3:
            {
                [self configureRadarChartView];
                [self get30DaysSeaData];
                [self getMarineStatistics];
                [self getSeaTemData];
            }
                break;
            case 5:
            {
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
        [self configureRadarChartView];
        [self get30DaysSeaData];
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
    
    if (self.type == 3) {
        [self.dipView3 addSubview:self.radarChartView];
        [self.radarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView3).mas_offset(25);
            make.right.mas_equalTo(weakSelf.dipView3).mas_offset(-110);
            make.left.mas_equalTo(weakSelf.dipView3).mas_offset(10);
            make.bottom.mas_equalTo(weakSelf.dipView3).mas_offset(-5);
        }];
        
        [self.dipView3 addSubview:self.speedInfoLabel];
        [self.speedInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.dipView3);
            make.right.mas_equalTo(weakSelf.dipView3).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(100, 65));
        }];
    }
    else{
        [self.dipView3 addSubview:self.radarChartView];
        [self.radarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView3).mas_offset(30);
            make.right.mas_equalTo(weakSelf.dipView3).mas_offset(-10);
            make.left.mas_equalTo(weakSelf.dipView3).mas_offset(110);
            make.bottom.mas_equalTo(weakSelf.dipView3).mas_offset(-5);
        }];
        
        [self.dipView3 addSubview:self.speedInfoLabel];
        [self.speedInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.dipView3);
            make.left.mas_equalTo(weakSelf.dipView3).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 65));
        }];
    }
    
    self.leftTimeLabel3.text = self.type==4?@"风向玫瑰图":@"浪向玫瑰图";
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
                NSString * dateStr = [NSString stringWithFormat:@"%@\n%@",model.tidetime,[model.forecastdate substringWithRange:NSMakeRange(5, 5)]];
                [xValues addObject:dateStr];
            }
                break;
            case 2:
            {
                //海温
                SeaDataInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"3";
                data = [[ChartDataEntry alloc] initWithX:i y:model.sstdata.doubleValue data:model];
                NSString * dateStr = [NSString stringWithFormat:@"%@\n%@",model.time,[model.forecasttime substringWithRange:NSMakeRange(5, 5)]];
                [xValues addObject:dateStr];
            }
                break;
            case 3:
            {
                //波高
                SeaDataInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"2";
                data = [[ChartDataEntry alloc] initWithX:i y:model.waveheight.doubleValue data:model];
                data.icon = [self imageString:model.wavedfrom];
                NSString * dateStr = [NSString stringWithFormat:@"%@\n%@",model.time,[model.forecasttime substringWithRange:NSMakeRange(5, 5)]];
                [xValues addObject:dateStr];
            }
                break;
            case 4:
            {
                //海风
                SeaDataInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"4";
                data = [[ChartDataEntry alloc] initWithX:i y:model.swspeed.doubleValue data:model];
                data.icon = [self imageString:model.swImageName];
                NSString * dateStr = [NSString stringWithFormat:@"%@\n%@",model.time,[model.forecasttime substringWithRange:NSMakeRange(5, 5)]];
                [xValues addObject:dateStr];
            }
                break;
            case 5:
            {
                //海流
                SeaStreamInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"1";
                data = [[ChartDataEntry alloc] initWithX:i y:model.wavespeed.doubleValue data:model];
                data.icon = [self imageString:model.imageName];
                NSString * dateStr = [NSString stringWithFormat:@"%@\n%@",model.time,[model.forecastdate substringWithRange:NSMakeRange(5, 5)]];
                [xValues addObject:dateStr];
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
//        if (self.type != 2) {
//            set1.mode = LineChartModeCubicBezier;
//        }
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        set1.drawIconsEnabled = YES;
        if (self.type == 1 || self.type == 2) {
            set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        }
        else{
            set1.drawValuesEnabled = NO;//是否在拐点处显示数据
        }
        [set1 setCircleColor:kColorAppMain];
        if (self.type == 2) {
            [set1 setColor:kColorOrige];//折线颜色
        }
        else{
            [set1 setColor:kColorAppMain];//折线颜色
        }
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
    
    if (self.type == 1 || self.type == 5) {
        if (self.type == 5) {
            [self.lineChartView1 zoomToCenterWithScaleX:3.9 scaleY:1];
        }
        else{
            [self.lineChartView1 zoomToCenterWithScaleX:4 scaleY:1];
        }
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
    }
}

- (void)updateFirstLineChartView4Data{
    NSMutableArray* dataValues = [[NSMutableArray alloc] init];
    [xValues2 removeAllObjects];
    for (int i=0; i<dataArray4.count; i++) {
        ChartDataEntry * data;
        //海温
        SeaDataInfoModel * model = [dataArray4 objectAtIndex:i];
        model.type = @"3";
        data = [[ChartDataEntry alloc] initWithX:i y:model.sstdata.doubleValue data:model];
        NSString * dateStr = [NSString stringWithFormat:@"%@\n%@",model.time,[model.forecasttime substringWithRange:NSMakeRange(5, 5)]];
        [xValues2 addObject:dateStr];
        [dataValues addObject:data];
    }
    
    LineChartDataSet *set1 = nil;
    //请注意这里，如果你的图表以前绘制过，那么这里直接重新给data赋值就行了。
    //如果没有，那么要先定义set的属性。
    if (self.lineChartView4.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.lineChartView4.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1=(LineChartDataSet*)self.lineChartView4.data.dataSets[0];
        set1.values = dataValues;
        //通知data去更新
        [self.lineChartView4.data notifyDataChanged];
        //通知图表去更新
        [self.lineChartView4 notifyDataSetChanged];
    }else{
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc] initWithValues:dataValues];
        //自定义set的各种属性
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        set1.drawIconsEnabled = YES;
        set1.drawValuesEnabled = NO;//是否在拐点处显示数据
        [set1 setCircleColor:kColorAppMain];
        [set1 setColor:kColorOrige];//折线颜色
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.circleRadius = 0;
        set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        NSMutableArray * dataSets = [NSMutableArray array];
        [dataSets addObject:set1];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData * data= [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont systemFontOfSize:10.f]];//文字字体
        [data setValueTextColor:kColorBlack];//文字颜色
        self.lineChartView4.data = data;
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
    set1.highlightEnabled = YES;
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
    set1.drawHighlightCircleEnabled = YES;
    set1.highlightColor = [UIColor clearColor];

    //data
    RadarChartData * data = [[RadarChartData alloc] initWithDataSets:@[set1]];
    self.radarChartView.data = data;
    self.radarChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xVals];
}

- (void)refreshSpeedLabelInfo{
    NSString * str1;
    NSString * str2;
    NSString * str3;
    
    if (self.type == 1) {
        str1 = [NSString stringWithFormat:@"最大潮高:%@m",[speedInfoDic objectForKey:@"maxValue"]];
        str2 = [NSString stringWithFormat:@"平均潮高:%@m",[speedInfoDic objectForKey:@"avg"]];
        str3 = [NSString stringWithFormat:@"最小潮高:%@m",[speedInfoDic objectForKey:@"minValue"]];
    }
    else if (self.type == 3) {
        str1 = [NSString stringWithFormat:@"最大浪高:%@m",[speedInfoDic objectForKey:@"maxValue"]];
        str2 = [NSString stringWithFormat:@"平均浪高:%@m",[speedInfoDic objectForKey:@"avg"]];
        str3 = [NSString stringWithFormat:@"最小浪高:%@m",[speedInfoDic objectForKey:@"minValue"]];
    }
    else if (self.type == 4){
        str1 = [NSString stringWithFormat:@"最大风速:%@m/s",[speedInfoDic objectForKey:@"maxValue"]];
        str2 = [NSString stringWithFormat:@"平均风速:%@m/s",[speedInfoDic objectForKey:@"avg"]];
        str3 = [NSString stringWithFormat:@"最小风速:%@m/s",[speedInfoDic objectForKey:@"minValue"]];
    }
    else{
        str1 = [NSString stringWithFormat:@"最大流速:%@m/s",[speedInfoDic objectForKey:@"maxValue"]];
        str2 = [NSString stringWithFormat:@"平均流速:%@m/s",[speedInfoDic objectForKey:@"avg"]];
        str3 = [NSString stringWithFormat:@"最小流速:%@m/s",[speedInfoDic objectForKey:@"minValue"]];
    }
    
    if (self.type == 3 || self.type == 4) {
        NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@",str1,str2,str3];
        NSMutableAttributedString * labelAttrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距
        paragraphStyle.lineSpacing = 5.0f;
        if (self.type == 4) {
            paragraphStyle.alignment = NSTextAlignmentLeft;
        }
        else{
            paragraphStyle.alignment = NSTextAlignmentRight;
        }
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

- (void)titleButtonClick{
    WebViewViewController * vc = [[WebViewViewController alloc] init];
    vc.urlStr = @"http://47.104.94.101:16888/haiyang/h5/helpDetail/14";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chartButtonClick:(UIButton *)sender{
    ListInfoViewController * vc = [[ListInfoViewController alloc] init];
    if (sender == self.chartButton) {
        if (self.type == 1 ) {
            vc.type = 1;
            vc.titleStr = @"潮高数据列表";
        }
        else if (self.type == 2){
            vc.type = 3;
            vc.titleStr = @"海温数据列表";
        }
        else if (self.type == 4) {
            vc.type = 5;
            vc.titleStr = @"海风数据列表";
        }
        else if (self.type == 5){
            vc.type = 2;
            vc.titleStr = @"海流数据列表";
        }
        else if (self.type == 3){
            vc.type = 4;
            vc.titleStr = @"浪高数据列表";
        }
        vc.dataArray = dataArray;
    }
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
    self.leftchartButton1 = nil;
    self.leftchartButton2 = nil;
    self.chartButton = nil;
    self.lineChartView1 = nil;

    [self configureChartView];
}

- (void)getWaterLevelData{
    NSString * str = @"";
    NSString * startDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString * endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
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
    NSString * endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
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
    dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    str = [NSString stringWithFormat:@"marine/getMarineData?fstarttime=%@&fendtime=%@",dateStr,endDateStr];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            
            NSArray * contentArr = [dic objectForKey:@"content"];
            [self->dataArray removeAllObjects];
            for (NSDictionary * data in contentArr) {
                SeaDataInfoModel * infoModel = [[SeaDataInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray addObject:infoModel];
                self.tipLabel1.text = [NSString stringWithFormat:@"%@\n%@发布",[NSString stringWithFormat:@"%@网",infoModel.source],[CommonUtils formatTime:[CommonUtils getFormatTime:infoModel.fstarttime FormatStyle:@"yyyy-MM-dd HH:mm:ss"] FormatStyle:@"yyyy-MM-dd"]];
            }
            [self updateFirstLineChartViewData];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)get30SeaTemData{
    NSString * str = @"";
    NSString * dateStr;
    NSString * endDateStr;
    dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-30*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    endDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
    str = [NSString stringWithFormat:@"marine/getMarineData?fstarttime=%@&fendtime=%@",dateStr,endDateStr];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            
            NSArray * contentArr = [dic objectForKey:@"content"];
            [self->dataArray4 removeAllObjects];
            for (NSDictionary * data in contentArr) {
                SeaDataInfoModel * infoModel = [[SeaDataInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray4 addObject:infoModel];
                self.tipLabel4.text = [NSString stringWithFormat:@"%@\n%@发布",[NSString stringWithFormat:@"%@网",infoModel.source],[CommonUtils formatTime:[CommonUtils getFormatTime:infoModel.fstarttime FormatStyle:@"yyyy-MM-dd HH:mm:ss"] FormatStyle:@"yyyy-MM-dd"]];
            }
            [self updateFirstLineChartView4Data];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)get30DaysSeaData{
    NSString *dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-30*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString *endDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString *str = [NSString stringWithFormat:@"marine/getDirectionData?fstarttime=%@&fendtime=%@&type=%@",dateStr,endDateStr,self.type==3?@"hl":@"hf"];
    
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
    if (self.type == 1) {
        typeStr = @"cg";
        dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
        endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    }
    else if (self.type == 3) {
        typeStr = @"hl";
    }
    else if (self.type == 4){
        typeStr = @"hf";
    }
    else if (self.type == 5){
        dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
        endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
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
    NSString *endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString *str = [NSString stringWithFormat:@"marine/getStreamHistogram?fstarttime=%@&fendtime=%@&type=%@",dateStr,endDateStr,self.type==1?@"cg":@"hl"];
    
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

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    if (axis == self.lineChartView1.xAxis) {
        if (xValues.count == 0) {
            return @"";
        }
        if (value >= xValues.count) {
            return @"";
        }

        [indexArray1 addObject:[NSNumber numberWithDouble:value]];
        
        return [xValues objectAtIndex:value];
    }
    else{
        if (xValues2.count == 0) {
            return @"";
        }
        if (value >= xValues2.count) {
            return @"";
        }
        [indexArray2 addObject:[NSNumber numberWithDouble:value]];
        
        return [xValues2 objectAtIndex:value];
    }
}

@end
