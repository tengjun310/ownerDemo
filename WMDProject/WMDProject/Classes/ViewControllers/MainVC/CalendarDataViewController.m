//
//  CalendarDataViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "CalendarDataViewController.h"
#import "InfoCollectionViewCell.h"
#import "SeaWaterLevelInfoModel.h"

@interface CalendarDataViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSDate * currentDate;
    NSMutableDictionary * dataDic;
    NSArray * keyArray;
}
@property (nonatomic,strong) UICollectionView * infoCollectionView;

@property (nonatomic,strong) UIView * alertView;

@property (nonatomic,strong) UIView * centerView;

@property (nonatomic,strong) UILabel * dateLabel;

@property (nonatomic,strong) UILabel * leftInfoLabel;

@property (nonatomic,strong) UILabel * rightInfoLabel;

@end


@implementation CalendarDataViewController

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor hexChangeFloat:@"000000" alpha:0.7];
    }
    
    return _alertView;
}

- (UIView *)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.masksToBounds = YES;
        _centerView.layer.cornerRadius = 5;
    }
    
    return _centerView;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.font = kFontSize28;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = kColorBlack;
        _dateLabel.numberOfLines = 2;
        _dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _dateLabel;
}

- (UILabel *)leftInfoLabel{
    if (!_leftInfoLabel) {
        _leftInfoLabel = [[UILabel alloc] init];
        _leftInfoLabel.backgroundColor = [UIColor clearColor];
        _leftInfoLabel.font = kFontSize26;
        _leftInfoLabel.textAlignment = NSTextAlignmentLeft;
        _leftInfoLabel.textColor = kColorBlack;
        _leftInfoLabel.numberOfLines = 5;
        _leftInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _leftInfoLabel;
}

- (UILabel *)rightInfoLabel{
    if (!_rightInfoLabel) {
        _rightInfoLabel = [[UILabel alloc] init];
        _rightInfoLabel.backgroundColor = [UIColor clearColor];
        _rightInfoLabel.font = kFontSize26;
        _rightInfoLabel.textAlignment = NSTextAlignmentRight;
        _rightInfoLabel.textColor = kColorBlack;
        _rightInfoLabel.numberOfLines = 5;
        _rightInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _rightInfoLabel;
}

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
        make.height.mas_offset(60);
    }];
    
    UILabel * tipLabel = [[UILabel alloc] init];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.font = kFontSize26;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentRight;
    tipLabel.text = @"潮高基准面在平均海面下1.01m";
    [topView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView).mas_offset(-5);
        make.top.mas_equalTo(topView);
        make.size.mas_equalTo(CGSizeMake(200, 15));
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
            make.top.mas_equalTo(tipLabel.mas_bottom);
            make.bottom.mas_equalTo(topView);
            make.width.mas_offset(labelWidth);
        }];
    }
    
    UICollectionViewFlowLayout * viewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.infoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-110-kStatusBarAndNavigationBarHeight) collectionViewLayout:viewLayout];
    self.infoCollectionView.backgroundColor = [UIColor clearColor];
    self.infoCollectionView.delegate = self;
    self.infoCollectionView.dataSource = self;
    self.infoCollectionView.showsVerticalScrollIndicator = NO;
    self.infoCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.infoCollectionView];
    
    UIView * dipView = [[UIView alloc] init];
    dipView.backgroundColor = kColorAppMain;
    [self.view addSubview:dipView];
    [dipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_offset(50);
    }];
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"top_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [dipView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dipView).mas_offset(80);
        make.centerY.mas_equalTo(dipView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"rightback"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [dipView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(dipView).mas_offset(-80);
        make.centerY.mas_equalTo(dipView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];

    [self.infoCollectionView registerClass:[InfoCollectionViewCell class] forCellWithReuseIdentifier:@"InfoCollectionViewCell"];
    
    dataDic = [NSMutableDictionary dictionary];
    currentDate = [NSDate date];
    self.title = [CommonUtils formatTime:currentDate FormatStyle:@"yyyy年MM月"];

    self.infoCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDataWithDate)];
    [self.infoCollectionView.mj_header beginRefreshing];
}

- (void)rightItemClick{
    if ([self.title isEqualToString:[CommonUtils formatTime:[NSDate date] FormatStyle:@"yyyy年MM月"]]) {
        return;
    }
    
    currentDate = [NSDate date];
    self.title = [CommonUtils formatTime:currentDate FormatStyle:@"yyyy年MM月"];
    [self getDataWithDate];
}

- (void)leftButtonClick{
    NSString * currentDateStr = [CommonUtils formatTime:currentDate FormatStyle:@"yyyy-MM"];
    NSString * todayDateStr = [CommonUtils formatTime:[NSDate date] FormatStyle:@"yyyy-MM"];
    if ([currentDateStr isEqualToString:todayDateStr]) {
        return;
    }
    
    NSArray * list = [currentDateStr componentsSeparatedByString:@"-"];
    int month = [[list lastObject] intValue];
    int year = [[list firstObject] intValue];
    if (month == 1) {
        month = 12;
        year = year-1;
    }
    else{
        month = month-1;
    }
    if ([[NSString stringWithFormat:@"%d-%02d",year,month] isEqualToString:[CommonUtils formatTime:[NSDate date] FormatStyle:@"yyyy-MM"]]) {
        currentDate = [NSDate date];
    }
    else {
        currentDate = [CommonUtils getFormatTime:[NSString stringWithFormat:@"%d-%02d",year,month] FormatStyle:@"yyyy-MM"];
    }
    self.title = [CommonUtils formatTime:currentDate FormatStyle:@"yyyy年MM月"];
    [self getDataWithDate];
}

- (void)rightButtonClick{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth;
    NSDateComponents * delta = [calendar components:unit fromDate:[NSDate date] toDate:currentDate options:0];
    if (delta.month == 10) {
        return;
    }
    
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:1];
    currentDate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    self.title = [CommonUtils formatTime:currentDate FormatStyle:@"yyyy年MM月"];
    [self getDataWithDate];
}

#pragma mark -- request
- (void)getDataWithDate{
    NSString * str = [NSString stringWithFormat:@"marine/getTideByMonth?tideMonth=%@",[CommonUtils formatTime:currentDate FormatStyle:@"yyyy-MM"]];
    
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            
            [self->dataDic removeAllObjects];
            self->keyArray = nil;
            
            NSDictionary * contentDic = [dic objectForKey:@"content"];
            self->keyArray = [contentDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
                if ([obj1 compare:obj2] == NSOrderedAscending) {
                    return NSOrderedAscending;
                }
                else{
                    return NSOrderedDescending;
                }
            }];
            
            [self->keyArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray * arr = [contentDic objectForKey:obj];
                NSMutableArray * list = [NSMutableArray array];
                for (NSDictionary * data in arr) {
                    SeaWaterLevelInfoModel * model = [[SeaWaterLevelInfoModel alloc] initWithDictionary:data error:nil];
                    [list addObject:model];
                }
                [self->dataDic setObject:list forKey:obj];
            }];
            
            [self.infoCollectionView reloadData];
        }
        [self.infoCollectionView.mj_header endRefreshing];
    } FailBlock:^(NSError *error) {
        [self.infoCollectionView.mj_header endRefreshing];
    }];
}

#pragma mark -- collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return keyArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InfoCollectionViewCell *cell = (InfoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"InfoCollectionViewCell" forIndexPath:indexPath];
    
    NSString * dateKey = [keyArray objectAtIndex:indexPath.row];
    NSDate * date = [CommonUtils getFormatTime:dateKey FormatStyle:@"yyyy-MM-dd"];
    
    NSString * monthDateStr = [CommonUtils formatTime:date FormatStyle:@"MM"];
    NSString * currentDateStr = [CommonUtils formatTime:currentDate FormatStyle:@"MM"];
    if ([monthDateStr isEqualToString:currentDateStr]) {
        cell.dateLabel.textColor = kColorBlack;
        cell.leftDataLabel.textColor = kColorBlack;
        cell.rightDataLabel.textColor = kColorBlack;
    }
    else{
        cell.dateLabel.textColor = kColorGray;
        cell.leftDataLabel.textColor = kColorGray;
        cell.rightDataLabel.textColor = kColorGray;
    }
    cell.dateLabel.text = [NSString stringWithFormat:@"%@\n%@",[CommonUtils formatTime:date FormatStyle:@"d"],[CommonUtils getChineseDate:date]];
    
    //判断当前cell是否是'今日'
    NSString * dayDateStr = [CommonUtils formatTime:date FormatStyle:@"yyyy-MM-dd"];
    NSString * currentDayDateStr = [CommonUtils formatTime:currentDate FormatStyle:@"yyyy-MM-dd"];

    if ([dayDateStr isEqualToString:currentDayDateStr] && [[CommonUtils formatTime:[NSDate date] FormatStyle:@"yyyy-MM"] isEqualToString:[CommonUtils formatTime:currentDate FormatStyle:@"yyyy-MM"]]) {
        cell.dipImageView.hidden = NO;
        cell.horImageView.hidden = YES;
        cell.verImageView.hidden = YES;
    }
    else{
        cell.dipImageView.hidden = YES;
        cell.horImageView.hidden = NO;
        cell.verImageView.hidden = NO;
    }
    
    NSArray * arr = [dataDic objectForKey:dateKey];
    if (arr.count) {
        NSString * dataStr = @"";
        NSString * celldateStr = @"";
        int count = arr.count<4?(int)arr.count:4;
        for (int i=0;i<count;i++) {
            SeaWaterLevelInfoModel * model = [arr objectAtIndex:i];
            if (i == 0) {
                celldateStr = [NSString stringWithFormat:@"潮时\n%@",model.tidetime];
                dataStr = [NSString stringWithFormat:@"潮高\n%@",model.tideheight];
            }
            else{
                celldateStr = [NSString stringWithFormat:@"%@\n%@",celldateStr,model.tidetime];
                dataStr = [NSString stringWithFormat:@"%@\n%@",dataStr,model.tideheight];
            }
        }
        
        //弥补不满足五行数据
        if (arr.count == 1) {
            dataStr = [NSString stringWithFormat:@"%@\n   \n   \n   ",dataStr];
            celldateStr = [NSString stringWithFormat:@"%@\n   \n   \n   ",celldateStr];
        }
        else if (arr.count == 2){
            dataStr = [NSString stringWithFormat:@"%@\n   \n   ",dataStr];
            celldateStr = [NSString stringWithFormat:@"%@\n   \n   \n   ",celldateStr];
        }
        else if (arr.count == 3){
            dataStr = [NSString stringWithFormat:@"%@\n   ",dataStr];
            celldateStr = [NSString stringWithFormat:@"%@\n   \n   \n   ",celldateStr];
        }
        
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:celldateStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距
        paragraphStyle.lineSpacing = 5.0f;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:paragraphStyle
                        range:NSMakeRange(0, celldateStr.length)];
        cell.leftDataLabel.attributedText = attrStr;

        NSMutableAttributedString * attrStr11 = [[NSMutableAttributedString alloc] initWithString:dataStr];
        
        NSMutableParagraphStyle *paragraphStyle11 = [[NSMutableParagraphStyle alloc] init];
        // 行间距
        paragraphStyle11.lineSpacing = 5.0f;
        paragraphStyle11.alignment = NSTextAlignmentRight;
        [attrStr11 addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle11
                          range:NSMakeRange(0, dataStr.length)];
        cell.rightDataLabel.attributedText = attrStr11;
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
    [self configureAlertView:indexPath];
}

- (void)configureAlertView:(NSIndexPath *)indexPath{
    if (!self.alertView.hidden) {
        __weak typeof(self) weakSelf = self;
        UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self.alertView];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(keyWindow);
        }];
        
        [self.alertView addSubview:self.centerView];
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.alertView.mas_centerX);
            make.centerY.mas_equalTo(weakSelf.alertView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(160, 160));
        }];
    
        [self.centerView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(weakSelf.centerView);
            make.height.mas_offset(50);
        }];
        
        [self.centerView addSubview:self.leftInfoLabel];
        [self.leftInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dateLabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.centerView).mas_offset(5);
            make.bottom.mas_equalTo(weakSelf.centerView).mas_offset(-5);
            make.width.mas_offset(70);
        }];
        
        [self.centerView addSubview:self.rightInfoLabel];
        [self.rightInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dateLabel.mas_bottom);
            make.right.mas_equalTo(weakSelf.centerView).mas_offset(-5);
            make.bottom.mas_equalTo(weakSelf.centerView).mas_offset(-5);
            make.width.mas_offset(70);
        }];
    
        self.alertView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAlertView)];
        [self.alertView addGestureRecognizer:tap];
    }
    else{
        self.alertView.hidden = NO;
    }
    
    NSString * dateKey = [keyArray objectAtIndex:indexPath.row];
    NSDate * date = [CommonUtils getFormatTime:dateKey FormatStyle:@"yyyy-MM-dd"];

    NSString * dayStr = [CommonUtils formatTime:date FormatStyle:@"d"];
    NSString * dayChineseStr = [CommonUtils getChineseDate:date];
    NSString * str = [NSString stringWithFormat:@"%@\n%@",dayStr,dayChineseStr];
    NSMutableAttributedString * labelAttrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距
    paragraphStyle.lineSpacing = 8.0f;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [labelAttrStr addAttribute:NSParagraphStyleAttributeName
                         value:paragraphStyle
                         range:NSMakeRange(0, str.length)];
    self.dateLabel.attributedText = labelAttrStr;

    NSArray * arr = [dataDic objectForKey:dateKey];
    if (arr.count) {
        NSString * dataStr = @"";
        NSString * celldateStr = @"";
        int count = arr.count<4?(int)arr.count:4;
        for (int i=0;i<count;i++) {
            SeaWaterLevelInfoModel * model = [arr objectAtIndex:i];
            if (i == 0) {
                celldateStr = [NSString stringWithFormat:@"潮时\n%@",model.tidetime];
                dataStr = [NSString stringWithFormat:@"潮高\n%@",model.tideheight];
            }
            else{
                celldateStr = [NSString stringWithFormat:@"%@\n%@",celldateStr,model.tidetime];
                dataStr = [NSString stringWithFormat:@"%@\n%@",dataStr,model.tideheight];
            }
        }
        
        //弥补不满足五行数据
        if (arr.count == 1) {
            dataStr = [NSString stringWithFormat:@"%@\n   \n   \n   ",dataStr];
            celldateStr = [NSString stringWithFormat:@"%@\n   \n   \n   ",celldateStr];
        }
        else if (arr.count == 2){
            dataStr = [NSString stringWithFormat:@"%@\n   \n   ",dataStr];
            celldateStr = [NSString stringWithFormat:@"%@\n   \n   \n   ",celldateStr];
        }
        else if (arr.count == 3){
            dataStr = [NSString stringWithFormat:@"%@\n   ",dataStr];
            celldateStr = [NSString stringWithFormat:@"%@\n   \n   \n   ",celldateStr];
        }
        
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:celldateStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距
        paragraphStyle.lineSpacing = 5.0f;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:paragraphStyle
                        range:NSMakeRange(0, celldateStr.length)];
        self.leftInfoLabel.attributedText = attrStr;
        
        NSMutableAttributedString * attrStr11 = [[NSMutableAttributedString alloc] initWithString:dataStr];
        
        NSMutableParagraphStyle *paragraphStyle11 = [[NSMutableParagraphStyle alloc] init];
        // 行间距
        paragraphStyle11.lineSpacing = 5.0f;
        paragraphStyle11.alignment = NSTextAlignmentRight;
        [attrStr11 addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle11
                          range:NSMakeRange(0, dataStr.length)];
        self.rightInfoLabel.attributedText = attrStr11;
    }
}

- (void)hiddenAlertView{
    [UIView animateWithDuration:.25 animations:^{
        self.alertView.hidden = YES;
    }];
}

@end
