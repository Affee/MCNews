//  Created by Affee on 2017/10/12.
//  Copyright © 2017年 affee. All rights reserved.
//


#import "TLHttpManager.h"
#import <YYCache/YYCache.h>
#import "NSJSONSerialization+TLJSON.h"
#import "AppDelegate.h"

static NSString * const TLHTTPClientRequestCache = @"TLHTTPClientRequestCache";
typedef NS_ENUM(NSUInteger, LYHTTPClientRequestType) {
    LYHTTPClientRequestTypeGET = 0,
    LYHTTPClientRequestTypePOST,
};
@implementation TLHttpManager
#pragma mark - public
//优先使用缓存
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:LYHTTPClientRequestTypeGET urlString:URLString parameters:parameters cachePolicy:TLHTTPClientReturnCacheDataThenLoad success:success failure:failure];
}
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                  cachePolicy:(TLHTTPClientRequestCachePolicy)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:LYHTTPClientRequestTypeGET urlString:URLString parameters:parameters cachePolicy:cachePolicy success:success failure:failure];
}
//优先使用缓存
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:LYHTTPClientRequestTypePOST urlString:URLString parameters:parameters cachePolicy:TLHTTPClientReturnCacheDataThenLoad success:success failure:failure];
}
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                   cachePolicy:(TLHTTPClientRequestCachePolicy)cachePolicy
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:LYHTTPClientRequestTypePOST urlString:URLString parameters:parameters cachePolicy:cachePolicy success:success failure:failure];
}

#pragma mark - private
+ (NSURLSessionDataTask *)requestMethod:(LYHTTPClientRequestType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                            cachePolicy:(TLHTTPClientRequestCachePolicy)cachePolicy
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString *cacheKey = URLString;
    if (parameters) {
        if (![NSJSONSerialization isValidJSONObject:parameters]) return nil;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [URLString stringByAppendingString:paramStr];
    }
    
    YYCache *cache = [[YYCache alloc] initWithName:TLHTTPClientRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    
    id object = [cache objectForKey:cacheKey];
    
    switch (cachePolicy) {
        case TLHTTPClientReturnCacheDataThenLoad: {//先返回缓存，同时请求
            if (object) {
                success(nil,object);
            }
            break;
        }
        case TLHTTPClientReloadIgnoringLocalCacheData: {//忽略本地缓存直接请求
            //不做处理，直接请求
            break;
        }
        case TLHTTPClientReturnCacheDataElseLoad: {//有缓存就返回缓存，没有就请求
            if (object) {//有缓存
                success(nil,object);
                return nil;
            }
            break;
        }
        case TLHTTPClientReturnCacheDataDontLoad: {//有缓存就返回缓存,从不请求（用于没有网络）
            if (object) {//有缓存
                success(nil,object);
            }
            return nil;//退出从不请求
        }
        default: {
            break;
        }
    }
    return [self requestMethod:type urlString:URLString parameters:parameters cache:cache cacheKey:cacheKey success:success failure:failure];
    
}
+ (NSURLSessionDataTask *)requestMethod:(LYHTTPClientRequestType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                                  cache:(YYCache *)cache
                               cacheKey:(NSString *)cacheKey
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    switch (type) {
        case LYHTTPClientRequestTypeGET:{
            return [[TLHttpManager sharedClient]GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }

                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
            break;
        }
        case LYHTTPClientRequestTypePOST:{
            return [[TLHttpManager sharedClient] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"%@",uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }

                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
            break;
        }
        default:
            break;
    }
}
/// URLString 应该是全url 上传单个文件
+ (NSURLSessionUploadTask *)upload:(NSString *)URLString filePath:(NSString *)filePath parameters:(id)parameters{
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSURLSessionUploadTask *uploadTask = [[TLHttpManager client] uploadTaskWithRequest:request fromFile:fileUrl progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
    return uploadTask;
}
+ (instancetype)sharedClient{
    static TLHttpManager *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [TLHttpManager client];
        sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
      //  sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        sharedClient.requestSerializer.timeoutInterval = 18;
//        [sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
         [sharedClient.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    });
    return sharedClient;
}
+ (instancetype)client{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    return [[TLHttpManager alloc] initWithBaseURL:[NSURL URLWithString:KKWebServiceBaseUrl] sessionConfiguration:configuration];
}
+ (id)getObjectWithURLString:(NSString *)URLString parameters:(id)parameters {
    NSString *cacheKey = URLString;
    if (parameters) {
        if (![NSJSONSerialization isValidJSONObject:parameters]) return nil;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [URLString stringByAppendingString:paramStr];
    }
    YYCache *cache = [[YYCache alloc] initWithName:TLHTTPClientRequestCache];
    id object = [cache objectForKey:cacheKey];
    return object;
}
+ (void)updateObjectWithURLString:(NSString *)URLString parameters:(id)parameters update:(id(^)(id object))update{
    NSString *cacheKey = URLString;
    if (parameters) {
        if (![NSJSONSerialization isValidJSONObject:parameters]) return;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [URLString stringByAppendingString:paramStr];
    }
    YYCache *cache = [[YYCache alloc] initWithName:TLHTTPClientRequestCache];
    id object = [cache objectForKey:cacheKey];
    [cache setObject:update(object) forKey:cacheKey];
}
@end
