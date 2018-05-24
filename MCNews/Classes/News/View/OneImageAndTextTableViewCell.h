//
//  OneImageAndTextTableViewCell.h
//  ZunYiApp
//
//  Created by LaiWang on 2017/3/10.
//  Copyright © 2017年 BBH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface OneImageAndTextTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *newsImgV;//新闻图片
@property(nonatomic,strong)UIImageView *playImgV;//播放图
@property(nonatomic,strong)UILabel *titleLable;//新闻标题
@property(nonatomic,strong)UILabel *whereNewsLabel;//新闻来源

@property(nonatomic,strong)NSDictionary *dataDic;//新闻数据

@property(nonatomic,strong)NSDictionary *collectionDic;//收藏数据

@end
