//
//  OnlyImageTableViewCell.m
//  ZunYiApp
//
//  Created by LaiWang on 2017/3/9.
//  Copyright © 2017年 BBH. All rights reserved.
//

#import "OnlyImageTableViewCell.h"

@implementation OnlyImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        
        [self addSubview:self.titleLable];
        [self addSubview:[UIViewUtil hengLineView:CGRectMake(0, 34, f_Device_w, 1)]];
        [self addSubview:self.newsImgV];
        [self.newsImgV addSubview:self.centerImgV];
        [self addSubview:self.whereNewsLabel];
        [self addSubview:[UIViewUtil hengLineView:CGRectMake(0, self.whereNewsLabel.bottom, f_Device_w, 10)]];
    }
    return self;
}
//文字
-(UILabel *)titleLable
{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, f_Device_w-15-70-15-15, 35)];
        _titleLable.font = [UIFont systemFontOfSize:FONT_SIZE];
    }
    return _titleLable;
}
//图片
-(UIImageView *)newsImgV
{
    if (_newsImgV == nil) {
        _newsImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, _titleLable.bottom, f_Device_w, AD_NEWS_CELL_HEIGHT-20)];
    }
    return _newsImgV;
}
//中心图
-(UIImageView *)centerImgV
{
    if (_centerImgV == nil) {
        _centerImgV = [[UIImageView alloc] initWithFrame:CGRectMake((f_Device_w-50)/2, (AD_NEWS_CELL_HEIGHT-20-50)/2, 50, 50)];
        _centerImgV.image = [UIImage imageNamed:@"zhibomoren"];
        _centerImgV.layer.cornerRadius = 25;
        _centerImgV.clipsToBounds = YES;
    }
    return _centerImgV;
}
//新闻来源
-(UILabel *)whereNewsLabel
{
    if (_whereNewsLabel == nil) {
        _whereNewsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _newsImgV.bottom, f_Device_w-30, 30)];
        _whereNewsLabel.font = [UIFont systemFontOfSize:FONT_SIZE-4];
        _whereNewsLabel.textColor = GRAY_COLOR_99;
    }
    return _whereNewsLabel;
}
#pragma mark ------- 添加数据
-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    _titleLable.text = dataDic[@"title"];
    
    [_newsImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dataDic[@"cover"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    long timeLong = [dataDic[@"createTime"] longValue];
    if ([StringUtil isEmpty:dataDic[@"newsSource"]]) {
        _whereNewsLabel.text = [NSString stringWithFormat:@"%@    %@评论    %@",dataDic[@"articleSource"],dataDic[@"commentCount"],[DateUtil createTimeToNowTimesTamp:timeLong]];
    }else{
        _whereNewsLabel.text = [NSString stringWithFormat:@"%@    %@评论    %@",dataDic[@"newsSource"],dataDic[@"commentCount"],[DateUtil createTimeToNowTimesTamp:timeLong]];
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
