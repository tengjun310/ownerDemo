//
//  ChartsViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "ChartsViewController.h"
#import "WMDProject-Bridge-Header.h"
#import "ListInfoViewController.h"
#import "SeaWaterLevelInfoModel.h"
#import "SeaStreamInfoModel.h"
#import "SeaDataInfoModel.h"


@interface ChartsViewController ()<ChartViewDelegate,IChartAxisValueFormatter>
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
        _lineChartView1.dragDecelerationEnabled = YES;
        _lineChartView1.dragDecelerationFrictionCoef = 0.9;
        ChartXAxis *xAxis =_lineChartView1.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        xAxis.axisLineColor = [UIColor whiteColor];
        xAxis.granularityEnabled = NO;
        xAxis.labelTextColor = kColorBlack;
        xAxis.drawGridLinesEnabled = NO;
        
        _lineChartView1.rightAxis.enabled = NO;
        ChartYAxis *leftAxis =_lineChartView1.leftAxis;
        leftAxis.inverted = NO;
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        leftAxis.axisLineColor = [UIColor whiteColor];
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = kColorBlack;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.forceLabelsEnabled = NO;
        _lineChartView1.chartDescription.enabled = NO;
        _lineChartView1.legend.enabled = NO;
        [_lineChartView1 animateWithXAxisDuration:1.0f];
        
        _lineChartView1.doubleTapToZoomEnabled = NO;
        _lineChartView1.noDataText = @"暂无数据";
        _lineChartView1.noDataFont = kFontSize34;
        [_lineChartView1 setScaleEnabled:YES];
        _lineChartView1.pinchZoomEnabled = YES;
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
        ChartXAxis *xAxis =_lineChartView2.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        xAxis.axisLineColor = [UIColor whiteColor];
        if (self.type == 1) {
            xAxis.drawLabelsEnabled = NO;
        }
        else{
            xAxis.drawLabelsEnabled = YES;
        }
        xAxis.granularityEnabled = NO;
        xAxis.labelTextColor = kColorBlack;
        xAxis.drawGridLinesEnabled = NO;
        
        _lineChartView2.rightAxis.enabled = NO;
        ChartYAxis *leftAxis =_lineChartView2.leftAxis;
        leftAxis.inverted = NO;
        if (self.type == 1) {
            leftAxis.drawGridLinesEnabled = NO;
        }
        else{
            leftAxis.drawGridLinesEnabled = YES;
        }
        leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
        leftAxis.axisLineColor = [UIColor whiteColor];
        leftAxis.gridColor = [UIColor whiteColor];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = kColorBlack;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.forceLabelsEnabled = NO;
        _lineChartView2.chartDescription.enabled = NO;
        _lineChartView2.legend.enabled = NO;
        [_lineChartView2 animateWithXAxisDuration:1.0f];
        
        _lineChartView2.doubleTapToZoomEnabled = NO;
        _lineChartView2.noDataText = @"暂无数据";
        _lineChartView2.noDataFont = kFontSize34;
        [_lineChartView2 setScaleEnabled:YES];
        _lineChartView2.pinchZoomEnabled = YES;
    }
    
    return _lineChartView2;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dipImageView.image = [UIImage imageNamed:@"hailang"];
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
        make.size.mas_equalTo(CGSizeMake(180, 15));
    }];

    [self.dipView2 addSubview:self.lineChartView2];
    [self.lineChartView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tipLabel2.mas_bottom);
        make.left.mas_equalTo(weakSelf.dipView2).mas_offset(10);
        make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-10);
        make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-20);
    }];
    
    if (self.type == 2) {
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
    else{
        [self.dipView2 addSubview:self.leftTimeLabel2];
        [self.leftTimeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.lineChartView2.mas_bottom);
            make.left.mas_equalTo(weakSelf.dipView2).mas_offset(15);
            make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-15);
            make.height.mas_offset(20);
        }];
        self.leftTimeLabel2.textAlignment = NSTextAlignmentCenter;
    }
    

    dataArray = [NSMutableArray array];
    dataArray2 = [NSMutableArray array];

    self.tipLabel1.text = @"来源:由红沿河海域实测数据预报得到";
    self.tipLabel2.text = @"来源:由红沿河海域实测数据预报得到";
    self.leftTimeLabel1.text = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"];
    self.rightTimeLabel1.text = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"];
    
    if (self.type == 1) {
        self.titleLabel1.text = @"水位走势图";
        self.titleLabel2.text = @"30天海温走势图";
        self.leftTimeLabel2.text = [NSString stringWithFormat:@"%@至%@",[CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"],[CommonUtils formatTime:[NSDate dateWithTimeInterval:30*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd"]];
        self.chartButton2.hidden = YES;
        [self getWaterLevelData];
        [self getSeaTemData];
    }
    else{
        self.titleLabel1.text = @"流速走势图";
        self.titleLabel2.text = @"流向走势图";
        self.leftTimeLabel2.text = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"];
        self.rightTimeLabel2.text = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd"];
        [self getSeaStremSpeedData];
    }
}

- (void)updateFirstLineChartViewData{
    NSMutableArray* dataValues = [[NSMutableArray alloc] init];
    for (int i=0; i<dataArray.count; i++) {
        if (self.type == 1) {
            SeaWaterLevelInfoModel * model = [dataArray objectAtIndex:i];
            NSDate * date = [CommonUtils getFormatTime:model.tidetime FormatStyle:@"HH:mm"];
            NSString * hourStr = [CommonUtils formatTime:date FormatStyle:@"HH"];
            NSString * minStr = [CommonUtils formatTime:date FormatStyle:@"mm"];
            CGFloat t = minStr.doubleValue/60;
            ChartDataEntry * data = [[ChartDataEntry alloc] initWithX:hourStr.doubleValue+t y:model.tideheight.doubleValue data:model];
            if ([model.tag isEqualToString:@"高潮"]) {
                data.icon = [UIImage imageNamed:@"hlogo"];
            }
            else if ([model.tag isEqualToString:@"低潮"]){
                data.icon = [UIImage imageNamed:@"llogo"];
            }
            else{
                data.icon = [UIImage imageNamed:@"point"];
            }
            [dataValues addObject:data];
        }
        else{
            SeaStreamInfoModel * model = [dataArray objectAtIndex:i];
            NSDate * date = [CommonUtils getFormatTime:model.time FormatStyle:@"HH:mm"];
            NSString * hourStr = [CommonUtils formatTime:date FormatStyle:@"HH"];
            NSString * minStr = [CommonUtils formatTime:date FormatStyle:@"mm"];
            CGFloat t = minStr.doubleValue/60;
            ChartDataEntry * data = [[ChartDataEntry alloc] initWithX:hourStr.doubleValue+t y:model.wavespeed.doubleValue data:model];
            [dataValues addObject:data];
        }
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
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        if (self.type == 1) {
            set1.drawValuesEnabled = YES;//是否在拐点处显示数据
            set1.drawIconsEnabled = YES;
        }
        else{
            set1.drawValuesEnabled = NO;//是否在拐点处显示数据
            set1.drawIconsEnabled = NO;
        }
        [set1 setCircleColor:kColorAppMain];
        [set1 setColor:kColorAppMain];//折线颜色
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.circleRadius = 3;
        set1.highlightEnabled = NO;//选中拐点,是否开启高亮效果(显示十字线)
        NSMutableArray * dataSets = [NSMutableArray array];
        [dataSets addObject:set1];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData * data= [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont systemFontOfSize:6.f]];//文字字体
        [data setValueTextColor:kColorBlack];//文字颜色
        self.lineChartView1.data = data;
    }
}

- (void)updateSecondLineChartViewData{
    NSMutableArray* dataValues = [[NSMutableArray alloc] init];
    for (int i=0; i<dataArray2.count; i++) {
        if (self.type == 1) {
            SeaDataInfoModel * model = [dataArray2 objectAtIndex:i];
            ChartDataEntry * data = [[ChartDataEntry alloc] initWithX:i y:model.sstdata.doubleValue data:model];
            [dataValues addObject:data];
        }
        else{
            SeaStreamInfoModel * model = [dataArray objectAtIndex:i];
            NSDate * date = [CommonUtils getFormatTime:model.time FormatStyle:@"HH:mm"];
            NSString * hourStr = [CommonUtils formatTime:date FormatStyle:@"HH"];
            NSString * minStr = [CommonUtils formatTime:date FormatStyle:@"mm"];
            CGFloat t = minStr.doubleValue/60;
            ChartDataEntry * data = [[ChartDataEntry alloc] initWithX:hourStr.doubleValue+t y:model.wavedfrom.doubleValue data:model];
            [dataValues addObject:data];
        }
    }

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
        set1.drawIconsEnabled = NO;
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        set1.drawValuesEnabled = NO;//是否在拐点处显示数据
        [set1 setColor:kColorAppMain];//折线颜色
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.highlightEnabled = NO;//选中拐点,是否开启高亮效果(显示十字线)
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData * data= [[LineChartData alloc] initWithDataSets:@[set1]];
        [data setValueFont:[UIFont systemFontOfSize:6.f]];//文字字体
        [data setValueTextColor:kColorBlack];//文字颜色
        self.lineChartView2.data = data;
    }
}
- (void)chartButtonClick:(UIButton *)sender{
    ListInfoViewController * vc = [[ListInfoViewController alloc] init];
    if (self.type == 1) {
        vc.type = 1;
        vc.titleStr = @"水位数据展示";
    }
    else if (self.type == 2){
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
    if (self.today) {
        NSString * startDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
        NSString * endDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        str = [NSString stringWithFormat:@"marine/getWaterLevel?fstarttime=%@&fendtime=%@",startDateStr,endDateStr];
    }
    else{
        NSString * startDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
        NSString * endDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 23:59:59"];
        str = [NSString stringWithFormat:@"marine/getWaterLevel?fstarttime=%@&fendtime=%@",startDateStr,endDateStr];
    }
    
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
    if (self.today) {
        NSString * startDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
        NSString * endDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        str = [NSString stringWithFormat:@"marine/getSeaStream?fstarttime=%@&fendtime=%@",startDateStr,endDateStr];
    }
    else{
        NSString * startDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
        NSString * endDateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 23:59:59"];
        str = [NSString stringWithFormat:@"marine/getSeaStream?fstarttime=%@&fendtime=%@",startDateStr,endDateStr];
    }
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * contentArr = [dic objectForKey:@"content"];
            [self->dataArray removeAllObjects];
            [self->dataArray2 removeAllObjects];
            for (NSDictionary * data in contentArr) {
                SeaStreamInfoModel * infoModel = [[SeaStreamInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray addObject:infoModel];
                [self->dataArray2 addObject:infoModel];
            }
            [self updateFirstLineChartViewData];
            [self updateSecondLineChartViewData];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

- (void)getSeaTemData{
    NSString * str = @"";
    NSString * dateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
    NSString * endDateStr = [CommonUtils formatTime:[NSDate dateWithTimeInterval:30*24*60*60 sinceDate:self.date] FormatStyle:@"yyyy-MM-dd 00:00:00"];
    str = [NSString stringWithFormat:@"marine/getMarineData?fstarttime=%@&fendtime=%@",dateStr,endDateStr];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            
            NSArray * contentArr = [dic objectForKey:@"content"];
            [self->dataArray2 removeAllObjects];
            for (NSDictionary * data in contentArr) {
                SeaDataInfoModel * infoModel = [[SeaDataInfoModel alloc] initWithDictionary:data error:nil];
                [self->dataArray2 addObject:infoModel];
            }
            [self updateSecondLineChartViewData];
        }
    } FailBlock:^(NSError *error) {
        
    }];
}

@end
