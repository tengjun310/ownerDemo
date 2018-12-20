//
//  HttpClient.m
//  YDHS
//
//  Created by yaoyoumiao on 2018/1/16.
//  Copyright © 2018年 陆浩. All rights reserved.
//

#import "HttpClient.h"
#import "JSONModel.h"


@interface HYHTTPSessionManager : NSObject

+ (AFHTTPSessionManager *)sharedHTTPSession;

@end


@implementation HYHTTPSessionManager

static AFHTTPSessionManager *manager ;

+ (AFHTTPSessionManager *)sharedHTTPSession {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}

@end


@implementation HttpClient

+ (void)asyncSendPostRequest:(NSString *)url Parmas:(id)data SuccessBlock:(void (^)(BOOL ,NSString *, id))successblock FailBlock:(void (^)(NSError *))failblock{
    
    NSString * strUrl = [KHttpHost stringByAppendingString:url];
    
    AFHTTPSessionManager * manager = [HYHTTPSessionManager sharedHTTPSession];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:strUrl parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (IsNilNull(responseObject)) {
            successblock(NO,@"返回空数据",nil);
            return;
        }
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            successblock(NO,@"数据格式错误",nil);
            return;
        }
        
        NSDictionary * rspDic = (NSDictionary *)responseObject;
        id value = [rspDic objectForKey:@"code"];
        if ([value intValue] != 0) {
            successblock(NO,[rspDic objectForKey:@"msg"],rspDic);
            return;
        }
        successblock(YES,@"",rspDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failblock(error);
    }];
}

@end
