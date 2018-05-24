//
//  LoginModel.h
//  QMD
//
//  Created by 墨炎 on 2016/12/30.
//  Copyright © 2016年 QMD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject


+ (instancetype)sharedLoginModel;

//1.传入一个字典，初始化loginModel（实例化）
- (instancetype)initWithDictionary:(NSDictionary *)dict;


- (void)intLoginSourceWithDict:(NSDictionary *)dict;
//
//account = 13814912325;
//icon = "http://192.168.199.137/Data/pic/58621a14abc86.png";
//id = 95;
//"last_login_time" = 1483091367;
//mark = jZRw;
//"monetary_month" = "0.01";
//money = 0;
//"party_times_month" = 0;
//sign = 7ff13fffb954630662777173faa7ff8f;
//username = fjjj;
//属性
@property (nonatomic,strong)NSString *account;
@property (nonatomic,strong)NSString * username;
@property (nonatomic,strong)NSNumber *monetary_month;
//下载路径
@property (nonatomic,strong)NSString * iconUrl;
@property (nonatomic,strong)NSNumber *party_times_month;
@property (nonatomic,strong)NSString * ID;
//登陆或者时候会生成一个sign，等于也就是没有判断用户是否需要登陆和注册的依据
@property (nonatomic,strong)NSString * sign;
@property (nonatomic,assign)float nsss;
@property (nonatomic,strong)NSString * last_login_time;
@property (nonatomic,strong)NSString *money;






@end
