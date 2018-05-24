//
//  NewsViewController.h
//  MCNews
//
//  Created by Affee on 2018/2/27.
//  Copyright © 2018年 affee. All rights reserved.
//

#import "MCBaseViewController.h"
#import "WMPageController.h"

typedef NS_ENUM(NSUInteger, WMMenuViewPosition) {
    WMMenuViewPositionDefault,
    WMMenuViewPositionBottom,
};

@interface NewsViewController : WMPageController

@property (nonatomic, assign) WMMenuViewPosition menuViewPosition;


/** 单例defaultHVCNavi */
+ (UINavigationController *)defaultHomeNavi;


@end
