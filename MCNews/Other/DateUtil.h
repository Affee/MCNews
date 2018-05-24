//
//  DateUtil.h
//  HRShealth
//
//  Created by qscxwei on 16/5/17.
//  Copyright © 2016年 healthmanager. All rights reserved.
//  时间操作公共类

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

//获取当前日期
+(NSString *)getCurday:(NSString *)format;

//时间戳转时间格式
+(NSString *)getDateFromTimestamp:(long)timestamp format:(NSString *)format;

//根据创建新闻时的时间戳，返回新闻创建到现在相隔的时间
+(NSString *)createTimeToNowTimesTamp:(long)timestamp;

@end
