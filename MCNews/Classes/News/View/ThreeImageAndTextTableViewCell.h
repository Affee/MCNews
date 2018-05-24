//
//  ThreeImageAndTextTableViewCell.h
//  ZunYiApp
//
//  Created by LaiWang on 2017/3/10.
//  Copyright © 2017年 BBH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface ThreeImageAndTextTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLable;//新闻标题
@property(nonatomic,assign)CGFloat imgWidthF;//图片宽度
@property(nonatomic,strong)UIImageView *newsImgV1;//新闻图片
@property(nonatomic,strong)UIImageView *newsImgV2;//新闻图片
@property(nonatomic,strong)UIImageView *newsImgV3;//新闻图片

@end
