//
//  ChartsViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "ChartsViewController.h"
#import "WMDProject-Bridge-Header.h"

@interface ChartsViewController ()<ChartViewDelegate>

@property (nonatomic,strong) UIView * dipView1;

@property (nonatomic,strong) UIView * dipView2;

@property (nonatomic,strong) UILabel * titleLabel1;

@property (nonatomic,strong) UILabel * titleLabel2;

@property (nonatomic,strong) UIButton * chartButton;

@property (nonatomic,strong) LineChartView * lineChartView1;

@property (nonatomic,strong) LineChartView * lineChartView2;

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

- (UIView *)dipView2{
    if (!_dipView2) {
        _dipView2 = [[UIView alloc] init];
        _dipView2.backgroundColor = [UIColor hexChangeFloat:@"ffffff" alpha:0.7];
        _dipView2.layer.masksToBounds = YES;
        _dipView2.layer.cornerRadius = 5;
    }
    
    return _dipView2;
}

- (UILabel *)titleLabel1{
    if (!_titleLabel1) {
        _titleLabel1 = [[UILabel alloc]init];
        _titleLabel1.backgroundColor = [UIColor clearColor];
        _titleLabel1.font = kFontSize28;
        _titleLabel1.textAlignment = NSTextAlignmentCenter;
        _titleLabel1.textColor = kColorAppMain;
        _titleLabel1.text = @"水位走势图";
    }
    
    return _titleLabel1;
}

- (UILabel *)titleLabel2{
    if (!_titleLabel2) {
        _titleLabel2 = [[UILabel alloc]init];
        _titleLabel2.backgroundColor = [UIColor clearColor];
        _titleLabel2.font = kFontSize28;
        _titleLabel2.textAlignment = NSTextAlignmentCenter;
        _titleLabel2.textColor = kColorAppMain;
        _titleLabel2.text = @"30天海温走势图";
    }
    
    return _titleLabel2;
}

- (UIButton *)chartButton{
    if (!_chartButton) {
        _chartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chartButton.backgroundColor = [UIColor redColor];
        [_chartButton addTarget:self action:@selector(chartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_chartButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    return _chartButton;
}

- (LineChartView *)lineChartView1{
    if (!_lineChartView1) {
        _lineChartView1 = [[LineChartView alloc] init];
        _lineChartView1.doubleTapToZoomEnabled = YES;//禁止双击缩放 有需要可以设置为YES
        _lineChartView1.gridBackgroundColor = [UIColor clearColor];//表框以及表内线条的颜色以及隐藏设置 根据自己需要调整
        _lineChartView1.borderColor = [UIColor clearColor];
        _lineChartView1.drawGridBackgroundEnabled = NO;
        _lineChartView1.drawBordersEnabled = NO;
        _lineChartView1.chartDescription.text = @"来源:来自xxx提供数据";//该表格的描述名称
        _lineChartView1.chartDescription.textColor = kColorGray;//描述字体颜色
        _lineChartView1.legend.enabled = YES;//是否显示折线的名称以及对应颜色 多条折线时必须开启 否则无法分辨
        _lineChartView1.legend.textColor = [UIColor whiteColor];//折线名称字体颜色
        
        //设置动画时间
        [_lineChartView1 animateWithXAxisDuration:1];
        
        //设置纵轴坐标显示在左边而非右边
        _lineChartView1.rightAxis.drawAxisLineEnabled = NO;
        _lineChartView1.rightAxis.drawLabelsEnabled = NO;
        //    self.chartView.rightAxis.labelTextColor = [UIColor redColor];
        
        //设置横轴坐标显示在下方 默认显示是在顶部
        _lineChartView1.xAxis.drawGridLinesEnabled = NO;
        _lineChartView1.xAxis.labelPosition = XAxisLabelPositionBottom;
        //    self.chartView.xAxis.labelTextColor = [UIColor redColor];
        _lineChartView1.xAxis.labelCount = 10;
        _lineChartView1.delegate = self;
        //    self.chartView.chartDescription.enabled = YES;
        //    self.chartView.chartDescription.text = @"测试表图";
        _lineChartView1.dragEnabled = YES;
        [_lineChartView1 setScaleEnabled:YES];
        _lineChartView1.pinchZoomEnabled = YES;
    }
    
    return _lineChartView1;
}

- (LineChartView *)lineChartView2{
    if (!_lineChartView2) {
        _lineChartView2 = [[LineChartView alloc] init];
        _lineChartView2.doubleTapToZoomEnabled = YES;//禁止双击缩放 有需要可以设置为YES
        _lineChartView2.gridBackgroundColor = [UIColor clearColor];//表框以及表内线条的颜色以及隐藏设置 根据自己需要调整
        _lineChartView2.borderColor = [UIColor clearColor];
        _lineChartView2.drawGridBackgroundEnabled = NO;
        _lineChartView2.drawBordersEnabled = NO;
        //    self.chartView.chartDescription.text = @"数值";//该表格的描述名称
        //    self.chartView.chartDescription.textColor = [UIColor blueColor];//描述字体颜色
        _lineChartView2.legend.enabled = YES;//是否显示折线的名称以及对应颜色 多条折线时必须开启 否则无法分辨
        _lineChartView2.legend.textColor = [UIColor whiteColor];//折线名称字体颜色
        
        //设置动画时间
        [_lineChartView2 animateWithXAxisDuration:1];
        
        //设置纵轴坐标显示在左边而非右边
        _lineChartView2.rightAxis.drawAxisLineEnabled = NO;
        _lineChartView2.rightAxis.drawLabelsEnabled = NO;
        //    self.chartView.rightAxis.labelTextColor = [UIColor redColor];
        
        //设置横轴坐标显示在下方 默认显示是在顶部
        _lineChartView2.xAxis.drawGridLinesEnabled = NO;
        _lineChartView2.xAxis.labelPosition = XAxisLabelPositionBottom;
        //    self.chartView.xAxis.labelTextColor = [UIColor redColor];
        _lineChartView2.xAxis.labelCount = 10;
        _lineChartView2.delegate = self;
        //    self.chartView.chartDescription.enabled = YES;
        //    self.chartView.chartDescription.text = @"测试表图";
        _lineChartView2.dragEnabled = YES;
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
    
    [self.dipView1 addSubview:self.lineChartView1];
    [self.lineChartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dipView1).mas_offset(30);
        make.left.mas_equalTo(weakSelf.dipView1).mas_offset(10);
        make.right.mas_equalTo(weakSelf.dipView1).mas_offset(-10);
        make.bottom.mas_equalTo(weakSelf.dipView1).mas_offset(-5);
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
        make.top.mas_equalTo(weakSelf.dipView2).mas_offset(5);
        make.left.right.mas_equalTo(weakSelf.dipView2);
        make.height.mas_offset(20);
    }];
    
    [self.dipView2 addSubview:self.lineChartView2];
    [self.lineChartView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dipView2).mas_offset(30);
        make.left.mas_equalTo(weakSelf.dipView2).mas_offset(10);
        make.right.mas_equalTo(weakSelf.dipView2).mas_offset(-10);
        make.bottom.mas_equalTo(weakSelf.dipView2).mas_offset(-5);
    }];
    
    [self getWaterLevelData];
    [self test];
}

- (void)test{
    
    //定义一个数组承接数据
    //对应Y轴上面需要显示的数据
    NSMutableArray* yVals = [[NSMutableArray alloc] init];
    for (int i=0; i<50; i++) {
        ChartDataEntry * data = [[ChartDataEntry alloc] initWithX:i y:random()%100+1];
        if (i%2==0) {
            data.icon = [UIImage imageNamed:@"ico_shuiwei_shang"];
        }
        else if (i%3 == 0){
            data.icon = [UIImage imageNamed:@"ico_shuiwei_xia"];
        }
        [yVals addObject:data];
    }
    
    LineChartDataSet *set1 = nil;
    //请注意这里，如果你的图表以前绘制过，那么这里直接重新给data赋值就行了。
    //如果没有，那么要先定义set的属性。
    
    if (self.lineChartView1.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.lineChartView1.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1=(LineChartDataSet*)self.lineChartView1.data.dataSets[0];
        set1.values=yVals;
        //通知data去更新
        [self.lineChartView1.data notifyDataChanged];
        //通知图表去更新
        [self.lineChartView1 notifyDataSetChanged];
    }else{
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@"温度"];
        //自定义set的各种属性
        //设置折线的样式
        set1.drawIconsEnabled = YES;
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        set1.drawValuesEnabled=YES;//是否在拐点处显示数据
        set1.valueColors=@[[UIColor whiteColor]];//折线拐点处显示数据的颜色
        [set1 setColor:[UIColor lightGrayColor]];//折线颜色
        //折线拐点样式
        set1.drawCirclesEnabled = YES;//是否绘制拐点
        set1.circleRadius = 4;
        //点击选中拐点的交互样式
        set1.highlightEnabled = NO;//选中拐点,是否开启高亮效果(显示十字线)
        //        set1.highlightColor=[UIColor redColor];//点击选中拐点的十字线的颜色
        //        set1.highlightLineWidth=1.1/[UIScreen mainScreen].scale;//十字线宽度
        //        set1.highlightLineDashLengths=@[@5,@5];//十字线的虚线样式
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray * dataSets = [NSMutableArray array];
        [dataSets addObject:set1];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData * data= [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont systemFontOfSize:6.f]];//文字字体
        [data setValueTextColor:[UIColor blackColor]];//文字颜色
        self.lineChartView1.data = data;
    }
}

- (void)chartButtonClick{
    
}

- (void)getWaterLevelData{
    NSString * str = @"";
    if (self.today) {
        NSString * dateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd HH:mm:ss"];
        str = [NSString stringWithFormat:@"marine/getWaterLevel?fstarttime=%@&fendtime=%@",dateStr,dateStr];
    }
    else{
        NSString * dateStr = [CommonUtils formatTime:self.date FormatStyle:@"yyyy-MM-dd 00:00:00"];
        str = [NSString stringWithFormat:@"marine/getWaterLevel?fstarttime=%@&fendtime=%@",dateStr,dateStr];
    }
    
    [HttpClient asyncSendPostRequest:str Parmas:nil
                        SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
                            if (succ) {
                                NSDictionary * dic = (NSDictionary *)rspData;
                                NSArray * contentArr = [dic objectForKey:@"content"];
                                
                            }
                        } FailBlock:^(NSError *error) {
                            
                        }];
}

@end
