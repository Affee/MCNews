//
//  OnlyImageTableViewCell.h
//  ZunYiApp
//
//  Created by LaiWang on 2017/3/9.
//  Copyright © 2017年 BBH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface OnlyImageTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLable;//标题
@property(nonatomic,strong)UIImageView *newsImgV;//图片
@property(nonatomic,strong)UIImageView *centerImgV;//中间图片
@property(nonatomic,strong)UILabel *whereNewsLabel;//新闻来源

@property(nonatomic,strong)NSDictionary *dataDic;//新闻数据

@end
