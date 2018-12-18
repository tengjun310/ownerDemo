//
//  MyScrollView.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    [super touchesShouldCancelInContentView:view];
    return YES;
}

@end
