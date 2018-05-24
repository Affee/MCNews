//
//  UIButton+EdgeInsetsSpacing.m
//  TongHang
//
//  Created by kulu on 16/12/1.
//  Copyright © 2016年 kulu. All rights reserved.
//

#import "UIButton+EdgeInsetsSpacing.h"

@implementation UIButton (EdgeInsetsSpacing)

-(void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageAndTitleSpace:(CGFloat)space
{
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0f;
    CGFloat labelHeight = 0.0f;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    }
    else
    {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    UIEdgeInsets imageEdgeInstes = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInstes = UIEdgeInsetsZero;
    switch (style)
    {
        case ButtonEdgeInsetsStyleTop:
        {
//            imageEdgeInstes = UIEdgeInsetsMake(-labelHeight-space/2, 0, 0, -(imageWidth+labelWidth)/2);
            imageEdgeInstes = UIEdgeInsetsMake(-labelHeight-space/2, 0, 0, -labelWidth);
            labelEdgeInstes = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2, 0);
        }
            break;
        case ButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInstes = UIEdgeInsetsMake(0, -space/2, 0, space/2);
            labelEdgeInstes = UIEdgeInsetsMake(0, space/2, 0, -space/2);
        }
            break;
        case ButtonEdgeInsetsStyleBottom:
        {
            //imageEdgeInstes = UIEdgeInsetsMake(0, 0, -labelHeight-space/2, -(labelWidth+imageWidth)/2);
            imageEdgeInstes = UIEdgeInsetsMake(0, 0, -labelHeight-space/2, -labelWidth);
            labelEdgeInstes = UIEdgeInsetsMake(-imageHeight-space/2, -imageWidth, 0, 0);
        }
            break;
        case ButtonEdgeInsetsStyleRight:
        {
            imageEdgeInstes = UIEdgeInsetsMake(0, labelWidth+space/2, 0, -labelWidth-space/2);
            labelEdgeInstes = UIEdgeInsetsMake(0, -imageWidth-space/2, 0, imageWidth+space/2);
        }
            break;
        default:
            break;
    }
    
    self.imageEdgeInsets = imageEdgeInstes;
    self.titleEdgeInsets = labelEdgeInstes;
    
}

@end
