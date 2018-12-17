//
//  LoginViewController.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/17.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) UIImageView *dipImageView;

@property (strong, nonatomic) UIImageView *logoImageView;

@property (strong, nonatomic) UITextField *phoneTextFiled;

@property (strong, nonatomic) UITextField *codeTextFiled;

@property (strong, nonatomic) UIButton *codeButton;

@property (strong, nonatomic) UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
}

- (void)configUI{
    self.codeButton.layer.masksToBounds = YES;
    self.codeButton.layer.borderWidth = 1.0f;
    self.codeButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.codeButton.layer.cornerRadius = 4;
    
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 4;
}

- (IBAction)codeButtonClick:(id)sender {
    
}

- (IBAction)loginButtonClick:(id)sender {
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserLoginSuccessNotify object:nil];
}

@end
