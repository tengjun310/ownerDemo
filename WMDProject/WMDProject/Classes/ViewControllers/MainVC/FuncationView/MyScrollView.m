//
//  MyScrollView.m
//  WMDProject
//
//  Created by yaoyoumiao on 2018/12/18.
//  Copyright © 2018年 Shannon MYang. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

//view是用户点击的视图
//- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
//{
////     获取一个UITouch
//    UITouch *touch = [touches anyObject];
//    // 获取当前的位置
//    CGPoint current = [touch locationInView:self];
//    CGFloat x = [UIScreen mainScreen].bounds.size.width;
//    if (current.x >= x + 10) {
//        //在地图上
//        NSLog(@"在地图上, 不滚动, view class is %@", view.class);
//        return YES;
//    }
//    else {
//        return [super touchesShouldBegin:touches withEvent:event inContentView:view];
//    }
//}
//
//- (BOOL)touchesShouldCancelInContentView:(UIView *)view
//{
//    NSLog(@"cancle class is %@", view.class);
//    if ([view isKindOfClass:NSClassFromString(@"TapDetectingView")]) {
//        return NO;
//    }
//    else {
//        return [super touchesShouldCancelInContentView:view];
//        return YES;
//    }
//}

@end
