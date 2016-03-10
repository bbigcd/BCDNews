//
//  BCDTopicsViewController.m
//  BCDNews
//
//  Created by bigcd on 16/3/6.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDTopicsViewController.h"

@interface BCDTopicsViewController ()

@end

@implementation BCDTopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 配置导航栏
    [self setupNavigation];
}

/**
 * 设置导航栏   -----------------------------------
 */
- (void)setupNavigation
{
    // 设置导航栏右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"top_navigation_readerplus" highImage:@"top_navigation_readerplus_highlighted" target:self action:@selector(clickRightItem)];
}
- (void)clickRightItem
{
    BCDLog(@"clickRightItem");
}
@end
