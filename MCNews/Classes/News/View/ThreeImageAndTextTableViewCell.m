//
//  ThreeImageAndTextTableViewCell.m
//  ZunYiApp
//
//  Created by LaiWang on 2017/3/10.
//  Copyright © 2017年 BBH. All rights reserved.
//

#import "ThreeImageAndTextTableViewCell.h"

@implementation ThreeImageAndTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        self.selectionStyle = NO;
        
        _imgWidthF = (f_Device_w-15*2-5*2)/3.0;
        
        [self addSubview:self.titleLable];
        [self addSubview:self.newsImgV1];
        [self addSubview:self.newsImgV2];
        [self addSubview:self.newsImgV3];
        
        
    }
    return self;
}
//图片
-(UIImageView *)newsImgV1
{
    if (_newsImgV1 == nil) {
        _newsImgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, _imgWidthF, _imgWidthF*0.48)];
        [_newsImgV1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    return _newsImgV1;
}
-(UIImageView *)newsImgV2
{
    if (_newsImgV2 == nil) {
        _newsImgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(_newsImgV1.right+5, 50, _imgWidthF, _imgWidthF*0.48)];
        [_newsImgV2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    return _newsImgV2;
}
-(UIImageView *)newsImgV3
{
    if (_newsImgV3 == nil) {
        _newsImgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(_newsImgV2.right+5, 50, _imgWidthF, _imgWidthF*0.48)];
        [_newsImgV3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    return _newsImgV3;
}
//文字
-(UILabel *)titleLable
{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, f_Device_w-20, 30)];
        _titleLable.font = [UIFont systemFontOfSize:FONT_SIZE-1];
        
        _titleLable.text = @"这是一个只有一张图片的Cell,这是一个只有一张图片的Cell,这是一个只有一张图片的Cell";
    }
    return _titleLable;
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
