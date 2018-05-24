//  Created by Affee on 2017/10/12.
//  Copyright © 2017年 affee. All rights reserved.
//

#import "AFHTTPSessionManager.h"
typedef NS_ENUM(NSUInteger, TLHTTPClientRequestCachePolicy){
    TLHTTPClientReturnCacheDataThenLoad = 0,///< 有缓存就先返回缓存，同步请求数据
    TLHTTPClientReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
    TLHTTPClientReturnCacheDataElseLoad,///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    TLHTTPClientReturnCacheDataDontLoad,///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};
@interface TLHttpManager : AFHTTPSessionManager
+ (instancetype)sharedClient;
/// 默认 LYHTTPClientReturnCacheDataThenLoad 的缓存方式
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                  cachePolicy:(TLHTTPClientRequestCachePolicy)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/// 默认 LYHTTPClientReturnCacheDataThenLoad 的缓存方式
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                   cachePolicy:(TLHTTPClientRequestCachePolicy)cachePolicy
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 *  获取某一个接口的缓存
 *  @param URLString  接口名称
 *  @param parameters 接口参数
 *
 *  @return 缓存对象
 */
+ (id)getObjectWithURLString:(NSString *)URLString parameters:(id)parameters;
/**
 *  更改某一个接口的缓存,需要用可变数组或者可变字典来接收object，最后再将更新后的数组或者字典赋值给object
 *
 *  @param URLString  接口名称
 *  @param parameters 接口参数
 *  @param update     更新对象
 */
+ (void)updateObjectWithURLString:(NSString *)URLString parameters:(id)parameters update:(id (^)(id object))update;
@end
