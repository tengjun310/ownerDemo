//
//  BaseViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UIBarButtonItem * leftItem;
}
@end

@implementation BaseViewController

- (UIImageView *)dipImageView {
    if (!_dipImageView) {
        _dipImageView = [[UIImageView alloc] init];
        _dipImageView.backgroundColor = [UIColor clearColor];
    }
    
    return _dipImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColorBackground;
    
    //更改导航栏  透明
    //通过插入空image把背景变透明
    //去掉系统底线，使用自定义底线
    UIImage * clearImage = [[UIImage alloc]init];
    [self.navigationController.navigationBar setBackgroundImage:clearImage forBarMetrics:UIBarMetricsDefault];
    
    UIImage * lineClearImage = [[UIImage alloc]init];
    [self.navigationController.navigationBar setShadowImage:lineClearImage];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_back"] style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;

    __weak typeof(self) weakSelf = self;

    [self.view addSubview:self.dipImageView];
    [self.dipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    self.hiddenLeftItem = YES;
}

- (void)setHiddenLeftItem:(BOOL)hiddenLeftItem{
    _hiddenLeftItem = hiddenLeftItem;
    if (hiddenLeftItem) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    else{
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
