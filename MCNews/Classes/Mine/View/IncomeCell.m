//
//  IncomeCell.m
//  MCNews
//
//  Created by Affee on 2018/2/27.
//  Copyright © 2018年 affee. All rights reserved.
//

#import "IncomeCell.h"

@implementation IncomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+(instancetype)GetCellWithTableView:(UITableView *)tableView
{
    static NSString *identfire=@"IncomeCell";
    IncomeCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"IncomeCell" owner:nil options:nil] firstObject];
    }  
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
