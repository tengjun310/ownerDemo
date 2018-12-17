//
//  LoginViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/17.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *dipImageView;

@property (strong, nonatomic) UIImageView *logoImageView;

@property (strong, nonatomic) UIImageView *phoneTextFiledLine;

@property (strong, nonatomic) UIImageView *codeTextFiledLine;

@property (strong, nonatomic) UITextField *phoneTextFiled;

@property (strong, nonatomic) UITextField *codeTextFiled;

@property (strong, nonatomic) UIButton *codeButton;

@property (strong, nonatomic) UIButton *loginButton;

@end

@implementation LoginViewController

- (UIImageView *)dipImageView{
    if (!_dipImageView) {
        _dipImageView = [[UIImageView alloc] init];
        _dipImageView.backgroundColor = [UIColor redColor];
    }
    
    return _dipImageView;
}

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.backgroundColor = [UIColor whiteColor];
    }
    
    return _logoImageView;
}

- (UIImageView *)phoneTextFiledLine{
    if (!_phoneTextFiledLine) {
        _phoneTextFiledLine = [[UIImageView alloc] init];
        _phoneTextFiledLine.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _phoneTextFiledLine;
}

- (UIImageView *)codeTextFiledLine{
    if (!_codeTextFiledLine) {
        _codeTextFiledLine = [[UIImageView alloc] init];
        _codeTextFiledLine.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _codeTextFiledLine;
}

- (UITextField *)phoneTextFiled{
    if (!_phoneTextFiled) {
        _phoneTextFiled = [[UITextField alloc] init];
        _phoneTextFiled.backgroundColor = [UIColor clearColor];
        _phoneTextFiled.textColor = [UIColor blackColor];
        _phoneTextFiled.textAlignment = NSTextAlignmentLeft;
        _phoneTextFiled.placeholder = @"请输入手机号";
        _phoneTextFiled.font = [UIFont systemFontOfSize:14];
        _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextFiled.delegate = self;
        _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _phoneTextFiled;
}

- (UITextField *)codeTextFiled{
    if (!_codeTextFiled) {
        _codeTextFiled = [[UITextField alloc] init];
        _codeTextFiled.backgroundColor = [UIColor clearColor];
        _codeTextFiled.textColor = [UIColor blackColor];
        _codeTextFiled.textAlignment = NSTextAlignmentLeft;
        _codeTextFiled.placeholder = @"请输入验证码";
        _codeTextFiled.font = [UIFont systemFontOfSize:14];
        _codeTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextFiled.delegate = self;
        _codeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _codeTextFiled;
}

- (UIButton *)codeButton{
    if (!_codeButton) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeButton.backgroundColor = [UIColor whiteColor];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _codeButton.layer.masksToBounds = YES;
        _codeButton.layer.cornerRadius = 4;
        _codeButton.layer.borderWidth = 1.0f;
        _codeButton.layer.borderColor = [UIColor blueColor].CGColor;
        [_codeButton addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _codeButton;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor blueColor];
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 4;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _loginButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
}

- (void)configUI{
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.dipImageView];
    [self.dipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    [self.view addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).mas_offset(60);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];

    [self.view addSubview:self.phoneTextFiled];
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.logoImageView.mas_bottom).mas_offset(40);
        make.left.mas_equalTo(weakSelf.view).mas_offset(60);
        make.right.mas_equalTo(weakSelf.view).mas_offset(-60);
        make.height.mas_offset(30);
    }];
    
    [self.view addSubview:self.phoneTextFiledLine];
    [self.phoneTextFiledLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneTextFiled.mas_bottom);
        make.left.mas_equalTo(weakSelf.phoneTextFiled.mas_left);
        make.right.mas_equalTo(weakSelf.phoneTextFiled.mas_right);
        make.height.mas_offset(1);
    }];

    [self.view addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneTextFiled.mas_bottom).mas_offset(20);
        make.right.mas_equalTo(weakSelf.phoneTextFiled.mas_right);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];

    [self.view addSubview:self.codeTextFiled];
    [self.codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneTextFiled.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(weakSelf.phoneTextFiled.mas_left);
        make.right.mas_equalTo(weakSelf.codeButton.mas_left).mas_offset(-5);
        make.height.mas_offset(30);
    }];
    
    [self.view addSubview:self.codeTextFiledLine];
    [self.codeTextFiledLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.codeTextFiled.mas_bottom);
        make.left.mas_equalTo(weakSelf.codeTextFiled.mas_left);
        make.right.mas_equalTo(weakSelf.codeTextFiled.mas_right);
        make.height.mas_offset(1);
    }];

    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.codeTextFiled.mas_bottom).mas_offset(45);
        make.left.mas_equalTo(weakSelf.view).mas_offset(60);
        make.right.mas_equalTo(weakSelf.view).mas_offset(-60);
        make.height.mas_offset(40);
    }];

}

- (void)codeButtonClick:(id)sender {
    
}

- (void)loginButtonClick:(id)sender {
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserLoginSuccessNotify object:nil];
}

@end
