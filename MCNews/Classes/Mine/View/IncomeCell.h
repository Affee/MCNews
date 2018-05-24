//
//  IncomeCell.h
//  MCNews
//
//  Created by Affee on 2018/2/27.
//  Copyright © 2018年 affee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *allComeinLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherComeIn;
@property (weak, nonatomic) IBOutlet UILabel *allTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherTitleLable;



+(instancetype)GetCellWithTableView:(UITableView *)tableView;

@end
