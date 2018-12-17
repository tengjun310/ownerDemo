//
//  NSString+Pinyin.m
//  JobSeeker
//
//  Created by 孙建文 on 15/6/2.
//  Copyright (c) 2015年 Nanjing Pipapai Network Technology Co., Ltd. All rights reserved.
//

#import "NSString+Pinyin.h"

@implementation NSString (Pinyin)

-(NSString *)hanziToPinyin{
    CFStringRef aCFString = (__bridge CFStringRef)self;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, aCFString);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    return [NSString stringWithFormat:@"%@",string];
}

@end
