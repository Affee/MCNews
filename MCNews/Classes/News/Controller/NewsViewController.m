//
//  NewsViewController.m
//  MCNews
//
//  Created by Affee on 2018/2/27.
//  Copyright © 2018年 affee. All rights reserved.
//

#import "NewsViewController.h"
#import "DetailViewController.h"
#import "WMPageController.h"

@interface NewsViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) NSArray *titleData;

@end

@implementation NewsViewController


#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"单曲", @"详情", @"歌词",@"歌词",@"单曲", @"详情", @"歌词",@"歌词"];
    }
    return _titleData;
}


- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 44, self.view.frame.size.width, 2.0)];
        _redView.backgroundColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    }
    return _redView;
}
#pragma mark 初始化代码
- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
//        self.menuHeight = 44;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.menuViewPosition = WMMenuViewPositionDefault;
//    self.progressViewCornerRadius = 5.0f;
//    self.menuViewStyle =  WMMenuViewPositionBottom;
//    self.progressWidth = 50;
    self.title = @"新闻";
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        [self.view addSubview:self.redView];
    }
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    switch (self.menuViewStyle) {
        case WMMenuViewStyleFlood: return 3;
        case WMMenuViewStyleSegmented: return 3;
        default: return 10;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
//    return self.titleData[index];
    switch (index % 7) {
        case 0: return @"军事";
        case 1: return @"新闻";
        case 2: return @"哈哈";
        case 3: return @"弟弟";
        case 4: return @"搞毛";
        case 5: return @"哈哈";
        case 6: return @"搞毛呢";
        case 7: return @"呵呵";
    }
    return nil;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    //    switch (index % 3) {
    //            return [[WMTableViewController alloc] init];
    ////        case 0: return [[WMTableViewController alloc] init];
    ////        case 1: return [[WMViewController alloc] init];
    ////        case 2: return [[WMCollectionViewController alloc] init];
    //    }
    //    return [[UIViewController alloc] init];
    return [[DetailViewController alloc] init];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    if (self.menuViewPosition == WMMenuViewPositionBottom) {
        menuView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        return CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    }
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    if (self.menuViewPosition == WMMenuViewPositionBottom) {
        return CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44);
    }
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += self.redView.frame.size.height;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    DetailViewController *detailVC = [DetailViewController new];
//    detailVC.view.backgroundColor = [UIColor whiteColor];
//    detailVC.customNavBar.title = @"新闻详情";
//    [self.navigationController pushViewController:detailVC animated:YES];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}

//
//+ (UINavigationController *)defaultHomeNavi {
//    static UINavigationController *navi = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
////        DetailViewController *vc = [[DetailViewController alloc]init];
//        DetailViewController *vc = [[DetailViewController alloc] initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
////        vc.keys = [self vcKeys];
////        vc.values = [self vcValues];
//        navi = [[UINavigationController alloc] initWithRootViewController:vc];
//    });
//    return navi;
//}
//
//+ (NSArray *)itemNames {
//    return @[@"最新",@"新闻",@"评测",@"导购",@"用车",@"技术",@"文化",@"改装",@"游记",];
//}
//
//+ (NSArray *)viewControllerClasses {
//    NSMutableArray *mArr = [NSMutableArray new];
//    for (int i = 0; i < [self itemNames].count; i++) {
//        [mArr addObject:[DetailViewController class]];
//    }
//    return [mArr copy];
//}
//
//+ (NSArray *)vcKeys {
//    NSMutableArray *mArr = [NSMutableArray new];
//    for (int i = 0; i < [self itemNames].count; i++) {
//        [mArr addObject:@"infoType"];
//    }
//    return [mArr copy];
//}
//
//+ (NSArray *)vcValues {
//    NSMutableArray *mArr = [NSMutableArray new];
//    for (int i = 0; i < [self itemNames].count; i++) {
//        [mArr addObject:@(i)];
//    }
//    return [mArr copy];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.title = @"新闻";
//}

@end

