//
//  LeftMenuViewController.m
//  ZXProject
//
//  Created by yaoyoumiao on 2018/7/31.
//  Copyright © 2018年 Huaiye. All rights reserved.
//

#import "LeftMenuViewController.h"

//菜单cell
@interface MenuTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * leftImageView;

@property (nonatomic,strong) UILabel * titleLabel;

@end

@implementation MenuTableViewCell

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.backgroundColor = [UIColor clearColor];
    }
    
    return _leftImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = kFontSize30;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = kColorBlack;
    }
    
    return _titleLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.leftImageView];
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(30);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(17, 18));
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(15);
            make.right.mas_equalTo(self.contentView).mas_offset(-30);
            make.height.mas_offset(20);
        }];
    }
    
    return self;
}

@end





@interface LeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * infoTableView;

@property (nonatomic,strong) UIView * headerView;

@property (nonatomic,strong) UIImageView * circleImageView;

@property (nonatomic,strong) UIImageView * headImageView;

@property (nonatomic,strong) UILabel * nameLabel;


@property (nonatomic,strong) UIView * footerView;

@property (nonatomic,strong) UIImageView * logoImageView;

@property (nonatomic,strong) UILabel * titleLabel;


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
        _headImageView.backgroundColor = [UIColor clearColor];
        _headImageView.image = [UIImage imageNamed:@"morentouxiang"];
    }
    
    return _headImageView;
}

- (UIImageView *)circleImageView{
    if (!_circleImageView) {
        _circleImageView = [[UIImageView alloc]init];
        _circleImageView.backgroundColor = [UIColor clearColor];
    }
    
    return _circleImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = kFontSize34;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = kColorBlack;
        _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _nameLabel.numberOfLines = 0;
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

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.backgroundColor = [UIColor clearColor];
        _logoImageView.image = [UIImage imageNamed:@"logo_caidan"];
    }
    
    return _logoImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = kFontSize28;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kColorBlack;
    }
    
    return _titleLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureUI];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)configureUI{
    self.view.backgroundColor = [UIColor hexChangeFloat:@"ffffff"];
    
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_offset(200);
    }];
    
    [self.headerView addSubview:self.circleImageView];
    [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView).mas_offset(50);
        make.centerX.mas_equalTo(self.headerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    self.circleImageView.layer.masksToBounds = YES;
    self.circleImageView.layer.cornerRadius = 30.0f;
    self.circleImageView.layer.borderColor = [UIColor hexChangeFloat:@"666666"].CGColor;
    self.circleImageView.layer.borderWidth = 1.0f;

    [self.headerView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.circleImageView);
        make.size.mas_equalTo(CGSizeMake(58, 58));
    }];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 29.0f;
    
    [self.headerView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.headerView);
        make.top.mas_equalTo(self.circleImageView.mas_bottom).mas_offset(18);
        make.height.mas_offset(60);
    }];
    
//    NSString * str1 = [HYSdpClientManager shareInstance].userInfo.strUserName;
//    NSString * str2 = [NSString stringWithFormat:@"人员ID:%@",[HYSdpClientManager shareInstance].userInfo.strUserID];
//    NSString * str = [NSString stringWithFormat:@"%@\n%@",str1,str2];
//    NSRange range2 = [str rangeOfString:str2];
//
//    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
//
//    [attrStr setAttributes:@{NSFontAttributeName:kFontSize34,
//                             NSForegroundColorAttributeName:kColorBlack
//                             }
//                     range:NSMakeRange(0, str1.length)];
//    [attrStr setAttributes:@{NSFontAttributeName:kFontSize28,
//                             NSForegroundColorAttributeName:kColorGray
//                             }
//                     range:range2];
//
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    // 行间距
//    paragraphStyle.lineSpacing = 10.0f;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    [attrStr addAttribute:NSParagraphStyleAttributeName
//                    value:paragraphStyle
//                    range:NSMakeRange(0, str.length)];
//    self.nameLabel.attributedText = attrStr;
//    self.nameLabel.text = [HYSdpClientManager shareInstance].userInfo.strUserName;
    
    [self.view addSubview:self.infoTableView];
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(SCREEN_HEIGHT-200-100);
    }];
    
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(100);
    }];
    
    [self.footerView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.footerView).mas_offset(15);
        make.centerX.mas_equalTo(self.footerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;

    [self.footerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.footerView);
        make.bottom.mas_equalTo(self.footerView).mas_offset(-30);
        make.height.mas_offset(15);
    }];
    self.titleLabel.text = @"VMS视频监控客户端";
}

#pragma mark -- tableview delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"MenuTableViewCell";
    MenuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSString * imageStr = @"";
    NSString * titleStr = @"";
    
    switch (indexPath.row) {
        case 0:
            imageStr = @"ico_shikuangyulan";
            titleStr = @"实况预览";
            break;
        case 1:
            imageStr = @"ico_yuanchenhuifang";
            titleStr = @"远程回放";
            break;
        case 2:
            imageStr = @"ico_xiaoxizhongxin";
            titleStr = @"消息中心";
            break;
        case 3:
            imageStr = @"ico_beidiluxiang";
            titleStr = @"本地录像";
            break;
        case 4:
            imageStr = @"ico_shezhi";
            titleStr = @"设置";
            break;
        case 5:
            imageStr = @"ico_guanyu";
            titleStr = @"关于";
            break;

        default:
            break;
    }
    
    cell.leftImageView.image = [UIImage imageNamed:imageStr];
    cell.titleLabel.text = titleStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[DYLeftSlipManager sharedManager] dismissLeftView];
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
        [CommonUtils showPromptViewInWindowWithTitle:@"功能暂未开放" afterDelay:HudShowTime];
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        UIViewController * vc;
        
//        switch (indexPath.row) {
//            case 3:
//                vc = [[LocalVideoPicController alloc] init];
//                break;
//            case 4:
//                vc = [[SettingMainViewController alloc] initWithNibName:@"SettingMainViewController" bundle:nil];
//                break;
//            case 5:
//                vc = [[YDHSAboutViewController alloc] initWithNibName:@"YDHSAboutViewController" bundle:nil];
//                break;
//
//            default:
//                break;
//        }
        
//        [appDelegate.mainNavController pushViewController:vc animated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
