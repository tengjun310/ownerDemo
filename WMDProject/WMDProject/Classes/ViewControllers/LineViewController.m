//
//  LineViewController.m
//  testCharts
//
//  Created by Shannon MYang on 2018/4/23.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "LineViewController.h"
#import "WMDProject-Bridge-Header.h"

@interface LineViewController () <ChartViewDelegate>

@property (nonatomic, strong) LineChartView *chartView;

@end

@implementation LineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LineChart";
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self initLineChartView];
}

- (void)initLineChartView
{
    
    self.chartView = [[LineChartView alloc] initWithFrame:CGRectMake(10, 80, 345, 300)];
    [self.view addSubview:self.chartView];
    
    self.chartView.doubleTapToZoomEnabled = NO;//禁止双击缩放 有需要可以设置为YES
    self.chartView.gridBackgroundColor = [UIColor clearColor];//表框以及表内线条的颜色以及隐藏设置 根据自己需要调整
    self.chartView.borderColor = [UIColor clearColor];
    self.chartView.drawGridBackgroundEnabled = NO;
    self.chartView.drawBordersEnabled = NO;
//    self.chartView.chartDescription.text = @"数值";//该表格的描述名称
//    self.chartView.chartDescription.textColor = [UIColor blueColor];//描述字体颜色
    self.chartView.legend.enabled = YES;//是否显示折线的名称以及对应颜色 多条折线时必须开启 否则无法分辨
    self.chartView.legend.textColor = [UIColor whiteColor];//折线名称字体颜色
    
    //设置动画时间
    [self.chartView animateWithXAxisDuration:1];
    
    //设置纵轴坐标显示在左边而非右边
    self.chartView.rightAxis.drawAxisLineEnabled = NO;
    self.chartView.rightAxis.drawLabelsEnabled = NO;
//    self.chartView.rightAxis.labelTextColor = [UIColor redColor];
    
    //设置横轴坐标显示在下方 默认显示是在顶部
    self.chartView.xAxis.drawGridLinesEnabled = NO;
    self.chartView.xAxis.labelPosition = XAxisLabelPositionBottom;
//    self.chartView.xAxis.labelTextColor = [UIColor redColor];
    self.chartView.xAxis.labelCount = 10;
    
    self.chartView.delegate = self;
//    self.chartView.chartDescription.enabled = YES;
//    self.chartView.chartDescription.text = @"测试表图";
    self.chartView.dragEnabled = YES;
    [self.chartView setScaleEnabled:YES];
    self.chartView.pinchZoomEnabled = YES;
    
    //定义一个数组承接数据
    //对应Y轴上面需要显示的数据
    NSMutableArray* yVals = [[NSMutableArray alloc] init];
    for (int i=0; i<50; i++) {
        ChartDataEntry * data = [[ChartDataEntry alloc] initWithX:i y:random()%100+1];
        [yVals addObject:data];
    }

    LineChartDataSet *set1 = nil;
    //请注意这里，如果你的图表以前绘制过，那么这里直接重新给data赋值就行了。
    //如果没有，那么要先定义set的属性。
    
    if (self.chartView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.chartView.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1=(LineChartDataSet*)self.chartView.data.dataSets[0];
        set1.values=yVals;
        //通知data去更新
        [self.chartView.data notifyDataChanged];
        //通知图表去更新
        [self.chartView notifyDataSetChanged];
    }else{
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@"温度"];
        //自定义set的各种属性
        //设置折线的样式
        set1.drawIconsEnabled = NO;
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        set1.drawValuesEnabled=YES;//是否在拐点处显示数据
        set1.valueColors=@[[UIColor whiteColor]];//折线拐点处显示数据的颜色
        [set1 setColor:[UIColor lightGrayColor]];//折线颜色
        //折线拐点样式
        set1.drawCirclesEnabled = YES;//是否绘制拐点
        set1.circleRadius = 2;
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
        self.chartView.data = data;
    }
}


@end
