//
//  ViewController.m
//  Soo8
//
//  Created by 赵文博 on 2016/7/22.
//  Copyright © 2016年 赵文博. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSJSONSerialization (TLJSON)
+ (nullable NSString *)stringWithJSONObject:(nonnull id)JSONObject;
+ (nullable id)objectWithJSONString:(nonnull NSString *)JSONString;
+ (nullable id)objectWithJSONData:(nonnull NSData *)JSONData;
@end
