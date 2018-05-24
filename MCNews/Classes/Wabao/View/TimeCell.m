 //
//  TimeCell.m
//  MCNews
//
//  Created by Affee on 2018/2/28.
//  Copyright © 2018年 affee. All rights reserved.
//

#import "TimeCell.h"

@implementation TimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self.imageView setImage:[UIImage imageNamed:@"bizhi"]];
}
+(instancetype)GetCellWithTableView:(UITableView *)tableView
{
    static NSString *identfire=@"TimeCell";
    TimeCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TimeCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
