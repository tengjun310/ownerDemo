//
//  CalendarDataViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "CalendarDataViewController.h"
#import "InfoCollectionViewCell.h"

@interface CalendarDataViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSDate * currentDate;
    NSMutableDictionary * dataDic;
}
@property (nonatomic,strong) UICollectionView * infoCollectionView;

@end


@implementation CalendarDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIImage * clearImage = [UIImage createImageWithColor:kColorAppMain];
    [self.navigationController.navigationBar setBackgroundImage:clearImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    UIImage * clearImage = [[UIImage alloc]init];
    [self.navigationController.navigationBar setBackgroundImage:clearImage forBarMetrics:UIBarMetricsDefault];
}

#pragma mark -- UI
- (void)configureUI{
    self.hiddenLeftItem = NO;
    self.view.backgroundColor = kColorBackground;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"今天" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = kColorAppMain;
    [self.view addSubview:topView];
    
    __weak typeof(self) weakSelf = self;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_offset(50);
    }];
    
    CGFloat labelWidth = SCREEN_WIDTH/7;
    for (int i=0; i<7; i++) {
        UILabel * label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = kFontSize30;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            label.text = @"日";
        }
        else if (i == 1){
            label.text = @"一";
        }
        else if (i == 2){
            label.text = @"二";
        }
        else if (i == 3){
            label.text = @"三";
        }
        else if (i == 4){
            label.text = @"四";
        }
        else if (i == 5){
            label.text = @"五";
        }
        else if (i == 6){
            label.text = @"六";
        }
        [topView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView).mas_offset(labelWidth*i);
            make.top.bottom.mas_equalTo(topView);
            make.width.mas_offset(labelWidth);
        }];
    }
    
    UICollectionViewFlowLayout * viewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.infoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-100) collectionViewLayout:viewLayout];
    self.infoCollectionView.backgroundColor = [UIColor clearColor];
    self.infoCollectionView.delegate = self;
    self.infoCollectionView.dataSource = self;
    self.infoCollectionView.showsVerticalScrollIndicator = NO;
    self.infoCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.infoCollectionView];

    [self.infoCollectionView registerClass:[InfoCollectionViewCell class] forCellWithReuseIdentifier:@"InfoCollectionViewCell"];
    
    dataDic = [NSMutableDictionary dictionary];
    
    currentDate = [NSDate date];
    self.title = [CommonUtils formatTime:currentDate FormatStyle:@"yyyy年MM月"];

    self.infoCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDataWithDate)];
    [self.infoCollectionView.mj_header beginRefreshing];
}

- (void)rightItemClick{
    currentDate = [NSDate date];
    self.title = [CommonUtils formatTime:currentDate FormatStyle:@"yyyy年MM月"];

}

#pragma mark -- request
- (void)getDataWithDate{
    NSString * str = [NSString stringWithFormat:@"marine/getTideByMonth?tideMonth=%@",[CommonUtils formatTime:currentDate FormatStyle:@"yyyy-MM"]];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSArray * arr = [dic objectForKey:@"content"];
            
        }
        [self.infoCollectionView.mj_header endRefreshing];
    } FailBlock:^(NSError *error) {
        [self.infoCollectionView.mj_header endRefreshing];
    }];
}

#pragma mark -- collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 31;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InfoCollectionViewCell *cell = (InfoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"InfoCollectionViewCell" forIndexPath:indexPath];
    
    cell.dateLabel.text = @"24\n廿一";
    
    NSString * str1 = @"潮时";
    NSString * str2 = @"1145";
    NSString * str3 = @"1145";
    NSString * str4 = @"2208";
    NSString * str5 = @"2246";
    NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",str1,str2,str3,str4,str5];
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距
    paragraphStyle.lineSpacing = 8.0f;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, str1.length)];
    cell.leftDataLabel.attributedText = attrStr;

    NSString * str6 = @"潮高";
    NSString * str7 = @"-18";
    NSString * str8 = @"34";
    NSString * str9 = @"205";
    NSString * str10 = @"2246";
    NSString * str11 = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",str6,str7,str8,str9,str10];
    NSMutableAttributedString * attrStr11 = [[NSMutableAttributedString alloc] initWithString:str11];
    
    NSMutableParagraphStyle *paragraphStyle11 = [[NSMutableParagraphStyle alloc] init];
    // 行间距
    paragraphStyle11.lineSpacing = 8.0f;
    paragraphStyle11.alignment = NSTextAlignmentRight;
    [attrStr11 addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle11
                    range:NSMakeRange(0, str6.length)];
    cell.rightDataLabel.attributedText = attrStr11;
    
    if (indexPath.row == 5) {
        cell.dipImageView.hidden = NO;
        cell.horImageView.hidden = YES;
        cell.verImageView.hidden = YES;
    }
    else{
        cell.dipImageView.hidden = YES;
        cell.horImageView.hidden = NO;
        cell.verImageView.hidden = NO;
    }
    
    return cell;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/7, 135);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}

#pragma mark ---- UICollectionViewDelegate
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
