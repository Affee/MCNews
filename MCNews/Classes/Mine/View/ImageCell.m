//
//  ImageCell.m
//  MCNews
//
//  Created by Affee on 2018/2/27.
//  Copyright © 2018年 affee. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell



+(instancetype)GetCellWithTableView:(UITableView *)tableView
{
    static NSString *identfire=@"ImageCell";
    ImageCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    if (!cell) {    
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ImageCell" owner:nil options:nil] firstObject];
    }
    return cell;
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
