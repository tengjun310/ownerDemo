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


@interface ChartsViewController ()<ChartViewDelegate>
{
    NSMutableArray * dataArray;
    NSMutableArray * dataArray2;
}

@property (nonatomic,strong) UIView * dipView1;

@property (nonatomic,strong) UILabel * titleLabel1;

@property (nonatomic,strong) UILabel * tipLabel1;

@property (nonatomic,strong) UIButton * chartButton;

@property (nonatomic,strong) LineChartView * lineChartView1;

@property (nonatomic,strong) UILabel * leftTimeLabel1;

@property (nonatomic,strong) UILabel * rightTimeLabel1;



@property (nonatomic,strong) UIView * dipView2;

@property (nonatomic,strong) UIImageView * logoImageView;

@property (nonatomic,strong) UILabel * titleLabel2;

@property (nonatomic,strong) UILabel * tipLabel2;

@property (nonatomic,strong) UIButton * chartButton2;

@property (nonatomic,strong) LineChartView * lineChartView2;

@property (nonatomic,strong) UILabel * leftTimeLabel2;

@property (nonatomic,strong) UILabel * rightTimeLabel2;

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
        _tipLabel1.textColor = kColorGray;
    }
    
    return _tipLabel1;
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
        xAxis.axisMinimum = 7;
//        xAxis.labelCount = 7;
//        [xAxis setLabelCount:7 force:YES];
        xAxis.drawLabelsEnabled = YES;
        xAxis.gridColor = [UIColor whiteColor];
        
        ChartYAxis *leftAxis =_lineChartView1.leftAxis;
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        leftAxis.axisLineColor = [UIColor whiteColor];
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = kColorBlack;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.drawGridLinesEnabled = YES;
        [leftAxis setLabelCount:7 force:YES];
        [_lineChartView1.viewPortHandler setMaximumScaleY: 1.f];
        [_lineChartView1.viewPortHandler setMaximumScaleX: 4*24*12/8-7];
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

- (UILabel *)titleLabel2{
    if (!_titleLabel2) {
        _titleLabel2 = [[UILabel alloc]init];
        _titleLabel2.backgroundColor = [UIColor clearColor];
        _titleLabel2.font = kFontSize28;
        _titleLabel2.textAlignment = NSTextAlignmentCenter;
        _titleLabel2.textColor = kColorAppMain;
    }
    
    return _titleLabel2;
}

- (UILabel *)tipLabel2{
    if (!_tipLabel2) {
        _tipLabel2 = [[UILabel alloc]init];
        _tipLabel2.backgroundColor = [UIColor clearColor];
        _tipLabel2.font = [UIFont systemFontOfSize:10];
        _tipLabel2.textAlignment = NSTextAlignmentLeft;
        _tipLabel2.textColor = kColorGray;
    }
    
    return _tipLabel2;
}

- (UILabel *)leftTimeLabel2{
    if (!_leftTimeLabel2) {
        _leftTimeLabel2 = [[UILabel alloc]init];
        _leftTimeLabel2.backgroundColor = [UIColor clearColor];
        _leftTimeLabel2.font = kFontSize24;
        _leftTimeLabel2.textAlignment = NSTextAlignmentLeft;
        _leftTimeLabel2.textColor = kColorGray;
    }
    
    return _leftTimeLabel2;
}

- (UILabel *)rightTimeLabel2{
    if (!_rightTimeLabel2) {
        _rightTimeLabel2 = [[UILabel alloc]init];
        _rightTimeLabel2.backgroundColor = [UIColor clearColor];
        _rightTimeLabel2.font = kFontSize24;
        _rightTimeLabel2.textAlignment = NSTextAlignmentRight;
        _rightTimeLabel2.textColor = kColorGray;
    }
    
    return _rightTimeLabel2;
}

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.backgroundColor = [UIColor clearColor];
        _logoImageView.image = [UIImage imageNamed:@"fangxiang"];
    }
    
    return _logoImageView;
}

- (UIButton *)chartButton2{
    if (!_chartButton2) {
        _chartButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _chartButton2.backgroundColor = [UIColor clearColor];
        [_chartButton2 addTarget:self action:@selector(chartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_chartButton2 setImage:[UIImage imageNamed:@"chart_icon"] forState:UIControlStateNormal];
    }
    
    return _chartButton2;
}

- (LineChartView *)lineChartView2{
    if (!_lineChartView2) {
        _lineChartView2 = [[LineChartView alloc] init];
        _lineChartView2.dragDecelerationEnabled = YES;
        _lineChartView2.dragDecelerationFrictionCoef = 0.9;
        _lineChartView2.delegate = self;
        _lineChartView2.chartDescription.enabled = NO;
        _lineChartView2.legend.enabled = NO;
        [_lineChartView2 animateWithXAxisDuration:1.0f];
        _lineChartView2.rightAxis.enabled = NO;
        _lineChartView2.doubleTapToZoomEnabled = NO;
        _lineChartView2.noDataText = @"暂未发布";
        _lineChartView2.noDataFont = kFontSize34;
        [_lineChartView2 setScaleEnabled:YES];
        _lineChartView2.pinchZoomEnabled = NO;

        ChartXAxis *xAxis =_lineChartView2.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        xAxis.axisLineColor = [UIColor whiteColor];
        xAxis.granularityEnabled = NO;
        xAxis.labelTextColor = kColorBlack;
        xAxis.drawGridLinesEnabled = YES;
        xAxis.drawLabelsEnabled = YES;

        ChartYAxis *leftAxis =_lineChartView2.leftAxis;
        leftAxis.inverted = NO;
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        leftAxis.axisLineColor = [UIColor whiteColor];
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = kColorBlack;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.drawGridLinesEnabled = YES;
        leftAxis.gridColor = [UIColor whiteColor];
    }
    
    return _lineChartView2;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dipImageView.image = [UIImage imageNamed:@"qinglang"];
    self.hiddenLeftItem = NO;
    self.title = @"图表展示";
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
    
    [self.dipView1 addSubview:self.tipLabel1];
    [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel1.mas_bottom);
        make.left.mas_equalTo(weakSelf.dipView1).mas_offset(25);
        make.size.mas_equalTo(CGSizeMake(180, 15));
    }];
    
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
    
    if (self.type == 3) {
        [self.dipView1 addSubview:self.leftTimeLabel1];
        [self.leftTimeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.lineChartView1.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView1).mas_offset(15);
            make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-15);
            make.height.mas_offset(20);
        }];
        self.leftTimeLabel1.textAlignment = NSTextAlignmentCenter;
    }
    else{
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
    }
    
    if (self.type == 5) {
        //海流显示两个图表  其他只显示一个图表
        [self.view addSubview:self.dipView2];
        [self.dipView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView1.mas_bottom).mas_offset(25);
            make.left.mas_equalTo(weakSelf.view).mas_offset(15);
            make.right.mas_equalTo(weakSelf.view).mas_offset(-15);
            make.height.mas_offset(heght);
        }];
        
        [self.dipView2 addSubview:self.titleLabel2];
        [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(40);
            make.top.mas_equalTo(weakSelf.dipView2).mas_offset(5);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-40);
            make.height.mas_offset(20);
        }];
        
        [self.dipView2 addSubview:self.chartButton2];
        [self.chartButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-10);
            make.top.mas_equalTo(weakSelf.dipView2).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.dipView2 addSubview:self.tipLabel2];
        [self.tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLabel2.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(25);
            make.size.mas_equalTo(CGSizeMake(220, 15));
        }];
        
        [self.dipView2 addSubview:self.lineChartView2];
        [self.lineChartView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tipLabel2.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(10);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-10);
            make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-20);
        }];
        
        BalloonMarker * marker2 = [[BalloonMarker alloc]
                                  initWithColor: kColorAppMain
                                  font: [UIFont systemFontOfSize:10.0f]
                                  textColor: UIColor.whiteColor
                                  insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker2.chartView = self.lineChartView2;
        marker2.minimumSize = CGSizeMake(80.f, 40.f);
        self.lineChartView2.marker = marker2;
        
        [self.dipView2 addSubview:self.logoImageView];
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dipView2);
            make.right.mas_equalTo(weakSelf.chartButton2.mas_left).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.dipView2 addSubview:self.leftTimeLabel2];
        [self.leftTimeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.lineChartView2.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(25);
            make.size.mas_equalTo(CGSizeMake(120, 20));
        }];
        
        [self.dipView2 addSubview:self.rightTimeLabel2];
        [self.rightTimeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.lineChartView2.mas_bottom);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-25);
            make.size.mas_equalTo(CGSizeMake(120, 20));
        }];
    }

    dataArray = [NSMutableArray array];

    if (self.type != 4) {
        //非海风
        self.tipLabel1.text = @"来源:由红沿河海域实测数据预报得到";
        self.leftTimeLabel1.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
        self.rightTimeLabel1.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
        
        switch (self.type) {
            case 1:
            {
                self.titleLabel1.text = @"水位走势图";
                [self getWaterLevelData];
            }
                break;
            case 2:
            {
                self.chartButton.hidden = YES;
                self.titleLabel1.text = @"波高走势图";
                [self getSeaTemData];
            }
                break;
            case 3:
            {
                self.titleLabel1.text = @"海温走势图";
                self.leftTimeLabel1.text = [NSString stringWithFormat:@"%@至%@",[CommonUtils formatTime:[NSDate dateWithTimeInterval:-29*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"],[CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"]];
                self.chartButton.hidden = YES;
                [self getSeaTemData];
            }
                break;
            case 5:
            {
                dataArray2 = [NSMutableArray array];

                self.titleLabel1.text = @"流速走势图";
                self.titleLabel2.text = @"流向走势图";
                
                self.leftTimeLabel2.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
                self.rightTimeLabel2.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
                [self getSeaStremSpeedData];
            }
                break;

            default:
                break;
        }
    }
    else{
        self.titleLabel1.text = @"海风走势图";
        self.leftTimeLabel1.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
        self.rightTimeLabel1.text = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"];
        [self getSeaTemData];
    }
}

- (void)updateFirstLineChartViewData{
    NSMutableArray* dataValues = [[NSMutableArray alloc] init];
    NSMutableArray* xValues = [[NSMutableArray alloc] init];
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
                    data.icon = [UIImage imageNamed:@"point"];
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
            }
                break;
            case 3:
            {
                //海温
                SeaDataInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"3";
                data = [[ChartDataEntry alloc] initWithX:i y:model.sstdata.doubleValue data:model];
            }
                break;
            case 4:
            {
                //海风
                SeaDataInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"4";
                data = [[ChartDataEntry alloc] initWithX:i y:model.waveheight.doubleValue data:model];
                data.icon = [self imageString:model.swdirection];
            }
                break;
            case 5:
            {
                //海流
                SeaStreamInfoModel * model = [dataArray objectAtIndex:i];
                model.type = @"1";
                data = [[ChartDataEntry alloc] initWithX:i y:model.wavespeed.doubleValue data:model];
            }
                break;

            default:
                break;
        }
        [dataValues addObject:data];
    }
    
    self.lineChartView1.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xValues];
    
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
        set1.highlightColor = [UIColor clearColor];
        NSMutableArray * dataSets = [NSMutableArray array];
        [dataSets addObject:set1];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData * data= [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont systemFontOfSize:10.f]];//文字字体
        [data setValueTextColor:kColorBlack];//文字颜色
        self.lineChartView1.data = data;
    }
    if (self.type == 1) {
        [self.lineChartView1 moveViewToX:2*24*12];
    }
}

- (void)updateSecondLineChartViewData{
    NSMutableArray* dataValues = [[NSMutableArray alloc] init];
    NSMutableArray* xValues = [[NSMutableArray alloc] init];
    for (int i=0; i<dataArray2.count; i++) {
        ChartDataEntry * data;
        SeaStreamInfoModel * model = [dataArray2 objectAtIndex:i];
        model.type = @"2";
        data = [[ChartDataEntry alloc] initWithX:i y:model.wavedfrom.doubleValue data:model];
        [xValues addObject:model.time];
        [dataValues addObject:data];
    }
    
    self.lineChartView2.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xValues];

    LineChartDataSet *set1 = nil;
    //请注意这里，如果你的图表以前绘制过，那么这里直接重新给data赋值就行了。
    //如果没有，那么要先定义set的属性。
    if (self.lineChartView2.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.lineChartView2.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1=(LineChartDataSet*)self.lineChartView2.data.dataSets[0];
        set1.values = dataValues;
        //通知data去更新
        [self.lineChartView2.data notifyDataChanged];
        //通知图表去更新
        [self.lineChartView2 notifyDataSetChanged];
    }else{
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc] initWithValues:dataValues];
        //自定义set的各种属性
        //设置折线的样式
        set1.mode = LineChartModeCubicBezier;
        set1.drawIconsEnabled = NO;
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        set1.drawValuesEnabled = NO;//是否在拐点处显示数据
        set1.drawIconsEnabled = NO;
        [set1 setCircleColor:kColorAppMain];
        [set1 setColor:kColorAppMain];//折线颜色
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.circleRadius = 3;
        set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        set1.highlightColor = [UIColor clearColor];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData * data= [[LineChartData alloc] initWithDataSets:@[set1]];
        [data setValueFont:[UIFont systemFontOfSize:6.f]];//文字字体
        [data setValueTextColor:kColorBlack];//文字颜色
        self.lineChartView2.data = data;
    }
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
        if (sender == self.chartButton) {
            vc.type = 2;
            vc.titleStr = @"流速数据展示";
        }
        else{
            vc.type = 3;
            vc.titleStr = @"流向数据展示";
        }
    }
    vc.dataArray = dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getWaterLevelData{
    NSString * str = @"";
    NSString * startDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-2*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString * endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    str = [NSString stringWithFormat:@"marine/getWaterLevel?fstarttime=%@&fendtime=%@",startDateStr,endDateStr];
    
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
            if (self.type == 5) {
                [self->dataArray2 removeAllObjects];
            }
            for (NSDictionary * data in contentArr) {
                SeaStreamInfoModel * infoModel = [[SeaStreamInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray addObject:infoModel];
                if (self.type == 5) {
                    SeaStreamInfoModel * infoModel2 = [[SeaStreamInfoModel alloc] initWithDictionary:data error:nil];
                    [self->dataArray2 addObject:infoModel2];
                }
            }
            [self updateFirstLineChartViewData];
            if (self.type == 5) {
                [self updateSecondLineChartViewData];
            }
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)getSeaTemData{
    NSString * str = @"";
    NSString * dateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:-29*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString * endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    str = [NSString stringWithFormat:@"marine/getMarineData?fstarttime=%@&fendtime=%@",dateStr,endDateStr];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            
            NSArray * contentArr = [dic objectForKey:@"content"];
            [self->dataArray removeAllObjects];
            for (NSDictionary * data in contentArr) {
                SeaDataInfoModel * infoModel = [[SeaDataInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray addObject:infoModel];
                if (self.tipLabel1.text.length == 0) {
                    self.tipLabel1.text = [NSString stringWithFormat:@"来源:%@%@",infoModel.source,infoModel.fstarttime];
                }
            }
            [self updateFirstLineChartViewData];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    
}


@end
