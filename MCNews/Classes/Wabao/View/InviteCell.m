//
//  InviteCell.m
//  MCNews
//
//  Created by Affee on 2018/3/5.
//  Copyright © 2018年 affee. All rights reserved.
//

#import "InviteCell.h"

@implementation InviteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)GetCellWithTableView:(UITableView *)tableView
{
    static NSString *identfire=@"InviteCell";
    InviteCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"InviteCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
