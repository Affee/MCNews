//
//  MCTabBarController.m
//  MCNews
//
//  Created by Affee on 2018/2/27.
//  Copyright © 2018年 affee. All rights reserved.
//

#import "MCTabBarController.h"
#import "MCBaseNavViewController.h"
#import "NewsViewController.h"
#import "VideoViewController.h"
#import "WabaoViewController.h"
#import "MineViewController.h"

@interface MCTabBarController ()

@end

@implementation MCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self BuildTab];
}
-(void)BuildTab
{
    NewsViewController *newVC = [[NewsViewController alloc]init];
    [self addChildViewController:newVC withImage:[UIImage imageNamed:@"tabbar_news"] selectedImage:[UIImage imageNamed:@"tabbar_news_hl"] withTittle:@"新闻"];
    
    VideoViewController *videoVC = [[VideoViewController alloc]init];
    [self addChildViewController:videoVC withImage:[UIImage imageNamed:@"tabbar_picture"] selectedImage:[UIImage imageNamed:@"tabbar_picture_hl"] withTittle:@"视频"];
    
    WabaoViewController *wabaoVC = [[WabaoViewController alloc]init];
    [self addChildViewController:wabaoVC withImage:[UIImage imageNamed:@"tabbar_video"] selectedImage:[UIImage imageNamed:@"tabbar_video_hl"] withTittle:@"挖宝"];
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    [self addChildViewController:mineVC withImage:[UIImage imageNamed:@"tabbar_setting"] selectedImage:[UIImage imageNamed:@"tabbar_setting_hl"] withTittle:@"我的"];
    
    
}

- (void)addChildViewController:(UIViewController *)controller withImage:(UIImage *)image selectedImage:(UIImage *)selectImage withTittle:(NSString *)tittle{
    MCBaseNavViewController *nav = [[MCBaseNavViewController alloc] initWithRootViewController:controller];
    
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];
    //    nav.tabBarItem.title = tittle;
    //    controller.navigationItem.title = tittle;
    controller.title = tittle;//这句代码相当于上面两句代码
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [self addChildViewController:nav];
}

@end
