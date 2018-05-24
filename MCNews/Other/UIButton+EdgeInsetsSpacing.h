//
//  UIButton+EdgeInsetsSpacing.h
//  TongHang
//
//  Created by kulu on 16/12/1.
//  Copyright © 2016年 kulu. All rights reserved.
//跟图片尺寸的大小有关系，所以要注意

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleTop, //image在上，label在下
    ButtonEdgeInsetsStyleLeft, //image在左，label在右
    ButtonEdgeInsetsStyleBottom, //image在下，label在上
    ButtonEdgeInsetsStyleRight //image在右，label在左
};

@interface UIButton (EdgeInsetsSpacing)

-(void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageAndTitleSpace:(CGFloat)space;

@end
