//
//  LeftMenuViewController.m
//  ZXProject
//
//  Created by yaoyoumiao on 2018/7/31.
//  Copyright © 2018年 Huaiye. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MenuTableViewCell.h"
#import "WebViewViewController.h"

@interface LeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int status;
}

@property (nonatomic,strong) UITableView * infoTableView;

@property (nonatomic,strong) UIView * headerView;

@property (nonatomic,strong) UIImageView * headImageView;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UIView * footerView;

@property (nonatomic,strong) UIButton * logoutButton;


@end

@implementation LeftMenuViewController

- (UITableView *)infoTableView{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc]init];
        _infoTableView.backgroundColor = [UIColor clearColor];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTableView.showsVerticalScrollIndicator = NO;
        _infoTableView.scrollEnabled = NO;
    }
    
    return _infoTableView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    
    return _headerView;
}

- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.backgroundColor = kColorAppMain;
        _headImageView.image = [UIImage imageNamed:@"ico_user"];
    }
    
    return _headImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = kFontSize30;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = kColorBlack;
    }
    
    return _nameLabel;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]init];
        _footerView.backgroundColor = [UIColor clearColor];
    }
    
    return _footerView;
}

- (UIButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.backgroundColor = [UIColor clearColor];
        _logoutButton.titleLabel.font = kFontSize30;
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:kColorAppMain forState:UIControlStateNormal];
        _logoutButton.layer.masksToBounds = YES;
        _logoutButton.layer.cornerRadius = 4;
        _logoutButton.layer.borderColor = kColorAppMain.CGColor;
        _logoutButton.layer.borderWidth = 1.0f;
        [_logoutButton addTarget:self action:@selector(logoutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _logoutButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    [self getMsgButtonStatus];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshShowWeather) name:@"refreshShowWeatherNotify" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)configureUI{
    self.view.backgroundColor = [UIColor hexChangeFloat:@"f9f9f9"];
    
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_offset(200);
    }];
    
    [self.headerView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.headerView);
        make.size.mas_equalTo(CGSizeMake(58, 58));
    }];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 29.0f;
    
    [self.headerView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.headerView);
        make.top.mas_equalTo(self.headImageView.mas_bottom).mas_offset(18);
        make.height.mas_offset(20);
    }];
    
    if ([WMDUserManager shareInstance].userName.length == 0) {
        self.nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KDefaultLoginNameKey];
    }
    else{
        self.nameLabel.text = [WMDUserManager shareInstance].userName;
    }
    
    [self.view addSubview:self.infoTableView];
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(SCREEN_HEIGHT-200-100);
    }];
    self.infoTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(100);
    }];
    
    [self.footerView addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.footerView.mas_centerY);
        make.left.mas_equalTo(self.footerView).mas_offset(30);
        make.right.mas_equalTo(self.footerView).mas_offset(-30);
        make.height.mas_offset(40);
    }];
}

- (void)refreshShowWeather{
    NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.infoTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)getMsgButtonStatus{
    NSString * str = [NSString stringWithFormat:@"user/msgSwitch?phNumber=%@",[WMDUserManager shareInstance].userName];
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSDictionary * contentDic = [dic objectForKey:@"content"];
            self->status = [[contentDic objectForKey:@"status"] intValue];
            NSIndexPath * path = [NSIndexPath indexPathForRow:1 inSection:0];
            [self.infoTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        }
    } FailBlock:^(NSError *error) {
    }];
}

- (void)setMsgButtonStatus{
    NSString * str = [NSString stringWithFormat:@"user/msgSwitch?phNumber=%@&status=%d",[WMDUserManager shareInstance].userName,status];
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            NSDictionary * dic = (NSDictionary *)rspData;
            NSDictionary * contentDic = [dic objectForKey:@"content"];
            self->status = [[contentDic objectForKey:@"status"] intValue];
            NSIndexPath * path = [NSIndexPath indexPathForRow:1 inSection:0];
            [self.infoTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        }
    } FailBlock:^(NSError *error) {
    }];
}

#pragma mark -- button events
- (void)logoutButtonClick{
    MBProgressHUD * hud = [CommonUtils showLoadingViewInWindowWithTitle:@""];
    
    NSString * str = [NSString stringWithFormat:@"user/logout?phNumber=%@",[WMDUserManager shareInstance].userName];
    [HttpClient asyncSendPostRequest:str Parmas:nil SuccessBlock:^(BOOL succ, NSString *msg, id rspData) {
        if (succ) {
            [[DYLeftSlipManager sharedManager] dismissLeftView];
            [[NSNotificationCenter defaultCenter] postNotificationName:UserLogoutSuccessNotify object:nil];
        }
        else{
            hud.labelText = @"登出失败";
        }
        [hud hide:YES afterDelay:HudShowTime];
    } FailBlock:^(NSError *error) {
        hud.labelText = @"登出超时";
        [hud hide:YES afterDelay:HudShowTime];
    }];
}

#pragma mark -- tableview delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"MenuTableViewCell";
    MenuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.line.hidden = NO;
    cell.logoImageView.hidden = YES;
    cell.backgroundColor = [UIColor clearColor];

    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor hexChangeFloat:@"e1e1e1"];
        cell.msgButton.hidden = YES;
        cell.infoLabel.hidden = NO;
        cell.line.hidden = YES;
        cell.logoImageView.hidden = NO;

        cell.infoLabel.text = [WMDUserManager shareInstance].currentWeaInfoModel.daytmp;

        NSString * str1 = @"大连瓦房店市";
        
        NSString * dateStr = [CommonUtils formatTime:[NSDate date] FormatStyle:@"MM月dd号"];
        NSString * weekStr = [CommonUtils weekdayCompletedStringFromDate:[NSDate date]];
        NSString * str2 = [NSString stringWithFormat:@"%@ %@",dateStr,weekStr];
        NSString * str = [NSString stringWithFormat:@"%@\n%@",str1,str2];
        NSRange range2 = [str rangeOfString:str2];

        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];

        [attrStr setAttributes:@{NSFontAttributeName:kFontSize26,
                                 NSForegroundColorAttributeName:kColorBlack
                                 }
                         range:NSMakeRange(0, str1.length)];
        [attrStr setAttributes:@{NSFontAttributeName:kFontSize24,
                                 NSForegroundColorAttributeName:kColorGray
                                 }
                         range:range2];

        cell.nameLabel.attributedText = attrStr;

    }
    else if (indexPath.row == 1){
        cell.msgButton.hidden = NO;
        cell.infoLabel.hidden = YES;
        if (status == 0) {
            cell.msgButton.selected = YES;
        }
        else{
            cell.msgButton.selected = NO;
        }

        cell.nameLabel.text = @"消息设置";
    }
    else if (indexPath.row == 2){
        cell.msgButton.hidden = YES;
        cell.infoLabel.hidden = YES;

        cell.nameLabel.text = @"清除缓存";
    }
    else if (indexPath.row == 3){
        cell.msgButton.hidden = YES;
        cell.infoLabel.hidden = YES;
        
        cell.nameLabel.text = @"帮助中心";
    }
    else if (indexPath.row == 4){
        cell.msgButton.hidden = YES;
        cell.infoLabel.hidden = YES;
        
        cell.nameLabel.text = @"关于系统";
    }
    else{
        cell.msgButton.hidden = YES;
        cell.infoLabel.hidden = YES;
        
        cell.nameLabel.text = @"检查更新";
    }
    
    __weak typeof(self) weakSelf = self;
    [cell setMessageButtonClick:^(BOOL selected) {
        self->status = selected?0:1;
        [weakSelf setMsgButtonStatus];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [self clearMembory];
    }
    else if (indexPath.row == 3 || indexPath.row == 4){
        [[DYLeftSlipManager sharedManager] dismissLeftView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            WebViewViewController * vc = [[WebViewViewController alloc] init];
            vc.urlStr = indexPath.row == 3?@"http://47.104.94.101:16888/haiyang/h5/help":@"http://47.104.94.101:16888/haiyang/h5/about";
            [appDelegate.mainViewController pushViewController:vc animated:YES];
        });
    }
    else if (indexPath.row == 4) {
        [[DYLeftSlipManager sharedManager] dismissLeftView];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [[DYLeftSlipManager sharedManager] dismissLeftView];
        MBProgressHUD * hud = [CommonUtils showLoadingViewInWindowWithTitle:@""];
        [HSUpdateApp hs_updateWithAPPID:nil withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
            if (isUpdate) {
                [hud hide:YES];
                NSArray * arr = @[storeVersion,openUrl];
                [[NSNotificationCenter defaultCenter] postNotificationName:CheckoutAPPVersionNotify object:arr];
            }
            else{
                hud.labelText = @"当前版本是最新版本";
                [hud hide:YES afterDelay:HudShowTime];
            }
        }];
    }
}

- (void)clearMembory{
    MBProgressHUD * hud = [CommonUtils showLoadingViewInWindowWithTitle:@"正在清除..."];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSError *error = nil;//错误信息
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *subPath in subPathArray)
    {
        //如果是数据库文件，不做操作
        if ([subPath isEqualToString:@"mySql.sqlite"])
        {
            continue;
        }
        
        NSString *filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.labelText = @"清除成功";
        [hud hide:YES afterDelay:HudShowTime];
        [[DYLeftSlipManager sharedManager] dismissLeftView];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
