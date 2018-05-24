//
//  LoginModel.m
//  QMD
//
//  Created by 墨炎 on 2016/12/30.
//  Copyright © 2016年 QMD. All rights reserved.
//

#import "LoginModel.h"
static LoginModel * loginModel;
@implementation LoginModel
    
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [self init]) {
//        字典中可能不包含这个字段
        _username = dict[@"username"];
        _iconUrl = dict[@"icon"];//NSString
        _monetary_month = dict[@"monetary_month"];//NSNumber

    }
    
    return self;
}

- (void)intLoginSourceWithDict:(NSDictionary *)dict{
    _username = dict[@"username"];
    _monetary_month = dict[@"monetary_month"];//NSNumber
    _last_login_time = dict[@"last_login_time"];
    _iconUrl = dict[@"icon"];//NSString
    _party_times_month = dict[@"party_times_month"];
    _money = dict[@"money"];
    _sign = dict[@"sign"];
    _ID = dict[@"id"];
    _account = dict[@"account"];
    
}
#pragma mark - 单利
+ (instancetype)sharedLoginModel{
    
    @synchronized (self) {
        if (!loginModel) {
            
            loginModel = [[self alloc] init];
        }
    }
    return loginModel;
}

@end
