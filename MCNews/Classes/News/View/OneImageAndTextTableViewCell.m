//
//  OneImageAndTextTableViewCell.m
//  ZunYiApp
//
//  Created by LaiWang on 2017/3/10.
//  Copyright © 2017年 BBH. All rights reserved.
//

#import "OneImageAndTextTableViewCell.h"

@implementation OneImageAndTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        
        [self addSubview:self.newsImgV];
        [self.newsImgV addSubview:self.playImgV];
        [self addSubview:self.titleLable];
        [self addSubview:self.whereNewsLabel];
        
        [self addSubview:[UIViewUtil hengLineView:CGRectMake(0, 99, f_Device_w, 1)]];
    }
    return self;
}
//图片
-(UIImageView *)newsImgV
{
    if (_newsImgV == nil) {
        _newsImgV = [[UIImageView alloc] initWithFrame:CGRectMake(f_Device_w-15-120, (NEWS_CELL_HEIGHT-80)/2, 120, 80)];
    }
    return _newsImgV;
}
//播放图
-(UIImageView *)playImgV{
    if (!_playImgV) {
        _playImgV = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, 40, 40)];
        _playImgV.image = [UIImage imageNamed:@"video_icon"];
        _playImgV.hidden = YES;
    }
    return _playImgV;
}
//文字
-(UILabel *)titleLable
{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, f_Device_w-145-15, 16)];
        _titleLable.font = [UIFont systemFontOfSize:FONT_SIZE];
        _titleLable.numberOfLines = 2;
    }
    return _titleLable;
}
//新闻来源
-(UILabel *)whereNewsLabel
{
    if (_whereNewsLabel == nil) {
        _whereNewsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100-22, f_Device_w-145-15, 12)];
        _whereNewsLabel.font = [UIFont systemFontOfSize:FONT_SIZE-4];
        _whereNewsLabel.textColor = GRAY_COLOR_99;
    }
    return _whereNewsLabel;
}
#pragma mark ------- 新闻添加数据
-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    CGSize sizeFrame = [StringUtil sizeWithFont:dataDic[@"title"] font:[UIFont systemFontOfSize:FONT_SIZE] maxSize:CGSizeMake(f_Device_w-145-15,80)];
    _titleLable.frame = CGRectMake(15, 10, f_Device_w-145-15, sizeFrame.height);
    _titleLable.text = dataDic[@"title"];
    
    [_newsImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dataDic[@"cover"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    int typeInt = [dataDic[@"type"] intValue];
    if (typeInt == 2) {
        _playImgV.hidden = NO;
    }else{
        _playImgV.hidden = YES;
    }
    
    long timeLong = [dataDic[@"createTime"] longValue];
    if ([StringUtil isEmpty:dataDic[@"newsSource"]]) {
        _whereNewsLabel.text = [NSString stringWithFormat:@"%@    %@评论    %@",dataDic[@"articleSource"],dataDic[@"commentCount"],[DateUtil createTimeToNowTimesTamp:timeLong]];
    }else{
        _whereNewsLabel.text = [NSString stringWithFormat:@"%@    %@评论    %@",dataDic[@"newsSource"],dataDic[@"commentCount"],[DateUtil createTimeToNowTimesTamp:timeLong]];
    }
    
}
#pragma mark ------- 收藏添加数据
-(void)setCollectionDic:(NSDictionary *)collectionDic
{
    _collectionDic = collectionDic;
    
    NSDictionary *dataDic = [NSDictionary new];
    NSInteger favoritesTypeInt = [collectionDic[@"favoritesType"] integerValue];
    
    switch (favoritesTypeInt) {
        case 1:
        {
            //新闻
            dataDic = [NSDictionary dictionaryWithDictionary:collectionDic[@"news"]];
            int typeInt = [dataDic[@"type"] intValue];
            if (typeInt == 2) {
                _playImgV.hidden = NO;
            }else{
                _playImgV.hidden = YES;
            }
        }
            break;
        case 0:
        {
            //订阅号文章
            dataDic = [NSDictionary dictionaryWithDictionary:collectionDic[@"article"]];
            int typeInt = [dataDic[@"type"] intValue];
            if (typeInt == 2) {
                _playImgV.hidden = NO;
            }else{
                _playImgV.hidden = YES;
            }
        }
            break;
        case 2:
        {
            //栏目
            dataDic = [NSDictionary dictionaryWithDictionary:collectionDic[@"programme"]];
            _playImgV.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    
    CGSize sizeFrame = [StringUtil sizeWithFont:dataDic[@"title"] font:[UIFont systemFontOfSize:FONT_SIZE] maxSize:CGSizeMake(f_Device_w-145-15,80)];
    _titleLable.frame = CGRectMake(15, 10, f_Device_w-145-15, sizeFrame.height);
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
