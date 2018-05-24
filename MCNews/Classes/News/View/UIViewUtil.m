//
//  UIViewUtil.m
//  HRShealth
//
//  Created by qscxwei on 16/6/16.
//  Copyright © 2016年 qscxwei. All rights reserved.
//  视图公共

#import "UIViewUtil.h"

@implementation UIViewUtil

//添加分割线
+(UIView *)hengLineView:(CGRect)frame
{
    UIView *hengLineView = [[UIView alloc] initWithFrame:frame];
    hengLineView.backgroundColor = BACK_COLOR;
    return hengLineView;
}

@end
