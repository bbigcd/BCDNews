//
//  BCDNewsViewController.m
//  BCDNews
//
//  Created by bigcd on 16/3/6.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDNewsViewController.h"
#import "BCDNewsSubViewController.h"

@interface BCDNewsViewController ()

/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation BCDNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 配置导航栏
    [self setupNavigation];
    
    // 初始化子控制器
    [self setupChidViewControlles];
    
    // 设置顶部标签栏
    [self setupTitlesView];
    
    // 设置底部的scrollview
    [self setupContentView];
    
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
/**
 *  初始化子控制器 -----------------------------------
 */
- (void)setupChidViewControlles{
    BCDNewsSubViewController *headline = [[BCDNewsSubViewController alloc] init];
    headline.title = @"头条";
    headline.type = BCDNewsTypeHeadline;
    BCDNewsSubViewController *recreation = [[BCDNewsSubViewController alloc] init];
    recreation.title = @"娱乐";
    recreation.type = BCDNewsTypeRecreation;
}
/**
 *  设置顶部标签栏  -----------------------------------
 */
- (void)setupTitlesView
{
    
}
/**
 *  设置底部的scrollview  -----------------------------------
 */
- (void)setupContentView{
    
}
@end
