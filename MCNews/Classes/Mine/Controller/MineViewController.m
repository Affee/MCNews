//
//  MineViewController.m
//  MCNews
//
//  Created by Affee on 2018/2/27.
//  Copyright © 2018年 affee. All rights reserved.
//

#define KKScreenBounds    [UIScreen mainScreen].bounds
#define KKScreenSize      [UIScreen mainScreen].bounds.size
#define KKScreenWidth     KKScreenSize.width
#define KKScreenHeight    KKScreenSize.height

#define KKRGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 280
#define NAV_HEIGHT 64

#import "MineViewController.h"
#import "IncomeCell.h"
#import "DetailViewController.h"
#import "WRNavigationBar.h"
#import "ImageCell.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor lightGrayColor];
      _dataArray=@[@[@"游戏",@"收入记录"],@[@"意见",@"消息信息"],@[@"关于",@"关于我们"],@[@"设置",@"检查更新"]];
    [super viewDidLoad];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
    [self.customNavBar wr_setBottomLineHidden:YES];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    // 设置导航栏显示图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"imageNav"];
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:0];
    
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
        inCell.allTitleLabel.text = @"总计挖矿收入(MC6)";
        inCell.allComeinLabel.text = @"8888.888";
        inCell.otherComeIn.text = @"8848.4396";
        inCell.otherTitleLable.text = @"昨日挖矿收入(MC6)";
        return inCell;
    }else if (indexPath.row == 0){
        ImageCell *inCell = [ImageCell GetCellWithTableView:tableView];
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
    vc.view.backgroundColor = [UIColor redColor];
//    vc.customNavBar.tintColor = [UIColor yellowColor];
    NSString *str = [NSString stringWithFormat:@"我是第几行%zd",indexPath.row];
    
//    NSArray *array=_dataArray[indexPath.row-2];
//    vc.customNavBar.title = array[1];
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

//- (UIImageView *)topView
//{
//    if (_topView == nil) {
//        _topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image7"]];
//        _topView.frame = CGRectMake(0, 0, self.view.frame.size.width, IMAGE_HEIGHT);
//    }
//    return _topView;
//}




//-(UITableView *)tableView
//{
//    if (!_tableView) {
//        UITableView *tableView = [[UITableView alloc]init];
//        [self.view addSubview:_tableView = tableView];
//    }
//    return _tableView;
//}
//-(void)initTableView
//{
//    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KKScreenSize.width, KKScreenSize.height) style:UITableViewStylePlain];
////     self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
//    _tableView.backgroundColor = KKRGBA(243, 243, 243, 1);
//    _tableView.delegate=self;
//    _tableView.dataSource=self;
//    //    分割线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);//分割线
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    //    顶部距离调整
//    [self.view addSubview:_tableView];
//}
//-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (section == 0) return 2;
//    return 4;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01f;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            return 120;
//        }else{
//            return 80;
//        }
//    }else{
//        return 48;
//    }
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            static NSString *Wcell=@"Wcell";
//            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Wcell];
//            if (!cell) {
//                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Wcell];
//            }
//            cell.backgroundColor = [UIColor yellowColor];
//            cell.textLabel.text = @"祝生意兴隆";
////            cell.detailTextLabel.text = @"德玛西亚";
//            cell.textLabel.font = [UIFont systemFontOfSize:16];
////            cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
//            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//            cell.selectionStyle=UITableViewCellSelectionStyleNone;
//            cell.imageView.image = [UIImage imageNamed:@"关于"];
//            CGSize imageSize = CGSizeMake(60, 60);
//            UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
//            CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
//            [cell.imageView.image drawInRect:imageRect];
//            cell.textLabel.font = [UIFont systemFontOfSize:14];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsGetImageFromCurrentImageContext();
//            return cell;
//        }else
//        {
//            IncomeCell *inCell = [IncomeCell GetCellWithTableView:tableView];
//            return inCell;
//        }
//    }else if (indexPath.section == 1){
//        static NSString *Wcell=@"Wcell";
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Wcell];
//        if (!cell) {
//            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Wcell];
//        }
//        NSArray *array=_dataArray[indexPath.row];
//        cell.imageView.image=[UIImage imageNamed:array[0]];
//        cell.textLabel.text=array[1];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        //        修改图片大小
//        CGSize imageSize = CGSizeMake(30, 30);
//        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
//        CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
//        [cell.imageView.image drawInRect:imageRect];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsGetImageFromCurrentImageContext();
//        return cell;
//    }else{
//
//    }
//    return nil;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    DetailViewController *detailVC = [DetailViewController new];
//    detailVC.view.backgroundColor = [UIColor whiteColor];
//    detailVC.title = @"弄啥哩";
//    [self.navigationController pushViewController:detailVC animated:YES];
//}
@end
