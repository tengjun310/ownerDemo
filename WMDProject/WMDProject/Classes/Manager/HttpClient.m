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
    //检测网络连接  无网络直接返回
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        NSError * error = [NSError errorWithDomain:@"无网络连接" code:-1 userInfo:nil];
        failblock(error);
        return;
    }
    
//    NSString * ip = [[NSUserDefaults standardUserDefaults] objectForKey:KDefaultServiceIpKey];
//    int port = [[[NSUserDefaults standardUserDefaults] objectForKey:KDefaultServicePortKey] intValue];
//    NSString * contextStr = [[NSUserDefaults standardUserDefaults] objectForKey:KDefaultServiceContextKey];
//    NSString * serverHost = [NSString stringWithFormat:@"http://%@:%d/%@/",ip,port,contextStr];
    
    NSString * strUrl = [@"" stringByAppendingString:url];
    
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
        id value = [rspDic objectForKey:@"result"];
        if ([[rspDic objectForKey:@"code"] intValue] != 0) {
            successblock(NO,[rspDic objectForKey:@"desc"],value);
            return;
        }
        successblock(YES,@"",value);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failblock(error);
    }];
}

@end
