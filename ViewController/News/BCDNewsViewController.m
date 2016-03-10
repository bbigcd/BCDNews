//
//  BCDNewsViewController.m
//  BCDNews
//
//  Created by bigcd on 16/3/6.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDNewsViewController.h"

@interface BCDNewsViewController ()

@end

@implementation BCDNewsViewController

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
    // 设置导航栏标题 
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"top_navi_bell_normal" highImage:@"top_navi_bell_highlight" target:self action:@selector(clickLeftItem)];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"search_icon" highImage:@"search_icon" target:self action:@selector(clickRightItem)];
}
- (void)clickLeftItem
{
    BCDLog(@"clickLeftItem");
}
- (void)clickRightItem
{
    BCDLog(@"clickRightItem");
}
@end
