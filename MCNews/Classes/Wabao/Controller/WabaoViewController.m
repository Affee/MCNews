//
//  WabaoViewController.m
//  MCNews
//
//  Created by Affee on 2018/2/27.
//  Copyright © 2018年 affee. All rights reserved.
//

#import "WabaoViewController.h"
#import "WRNavigationBar.h"
//#import "MCBaseViewController.h"
#import "DetailViewController.h"
#import "TimeCell.h"
#import "IncomeCell.h"
#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define NAV_HEIGHT 64
#define KKRGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


@interface WabaoViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataArray;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation WabaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    _dataArray=@[@[@"游戏",@"收入记录"],@[@"意见",@"消息信息"],@[@"关于",@"关于我们"],@[@"设置",@"检查更新"]];
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
    
    self.customNavBar.hidden = YES;
    self.customNavBar.title = @"奥黛丽·赫本";
    [self.customNavBar wr_setBottomLineHidden:YES];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    // 设置初始导航栏透明度
//    [self.customNavBar wr_setBackgroundAlpha:0];
//    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    //    //    分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorInset = UIEdgeInsetsMake(18, 0, 0, 0);//分割线
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = KKRGBA(230, 230, 230, 0.8);

}
#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count+2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        IncomeCell *inCell = [IncomeCell GetCellWithTableView:tableView];
        inCell.allTitleLabel.text = @"昨日挖矿收入(MC6)";
        inCell.allComeinLabel.text = @"123.231";
        inCell.otherComeIn.text = @"123.523";
        inCell.otherTitleLable.text = @"今日挖矿收入(MC6)";
        return inCell;
    }else if (indexPath.row == 0){
        TimeCell *inCell = [TimeCell GetCellWithTableView:tableView];
        return inCell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:nil];
        NSArray *array=_dataArray[indexPath.row-2];
        cell.imageView.image=[UIImage imageNamed:array[0]];
        cell.textLabel.text=array[1];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                   reuseIdentifier:nil];
//    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
//    cell.textLabel.text = str;
//    [cell.imageView setImage:[UIImage imageNamed:@"游戏"]];
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 80;
    }else if (indexPath.row == 0){
        return 180;
    }else{
        return 48;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [DetailViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    NSString *str = [NSString stringWithFormat:@"右划返回查看效果 %zd",indexPath.row];
//    vc.customNavBar.title = str;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
