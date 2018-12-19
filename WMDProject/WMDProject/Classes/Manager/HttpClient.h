//
//  HttpClient.h
//  YDHS
//
//  Created by yaoyoumiao on 2018/1/16.
//  Copyright © 2018年 陆浩. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KHttpHost       @"http://47.104.94.101:16888/haiyang/"

@interface HttpClient : NSObject


+ (void)asyncSendPostRequest:(NSString *)url
                      Parmas:(id)data
                SuccessBlock:(void(^)(BOOL succ,NSString * msg, id rspData))successblock
                   FailBlock:(void(^)(NSError * error))failblock;

@end
