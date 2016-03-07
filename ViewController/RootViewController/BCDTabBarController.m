//
//  BCDTabBarController.m
//  BCDNews
//
//  Created by bigcd on 16/3/6.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDTabBarController.h"
#import "BCDRedBGNaviViewController.h"
#import "BCDNewsViewController.h"
#import "BCDReaderViewController.h"
#import "BCDMediaViewController.h"
#import "BCDTopicsViewController.h"
#import "BCDMeViewController.h"

@interface BCDTabBarController ()

@end

@implementation BCDTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    // NSForegroundColorAttributeName 相对于 NSBackgroundColorAttributeName
    attribute[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttribute = [NSMutableDictionary dictionary];
    selectedAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttribute[NSForegroundColorAttributeName] = [UIColor bottomTabBarTitleSeletedColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 添加子控制器 */
    [self setupChildVC:[[BCDNewsViewController alloc] init] title:@"新闻" image:@"tabbar_icon_news_normal" selectedImage:@"tabbar_icon_news_highlight"];
    [self setupChildVC:[[BCDReaderViewController alloc] init] title:@"阅读" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];
    [self setupChildVC:[[BCDMediaViewController alloc] init] title:@"视听" image:@"tabbar_icon_media_normal" selectedImage:@"tabbar_icon_media_highlight"];
    [self setupChildVC:[[BCDTopicsViewController alloc] init] title:@"话题" image:@"tabbar_icon_bar_normal" selectedImage:@"tabbar_icon_bar_highlight"];
    [self setupChildVC:[[BCDMeViewController alloc] init] title:@"我" image:@"tabbar_icon_me_normal" selectedImage:@"tabbar_icon_me_highlight"];
}
/**
 *  初始化控制器
 */
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    /** 设置文字和图片 */
//    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    /** 包装一个导航控制器，添加导航控制器为tabbarcontroller的自控制器 */
    BCDRedBGNaviViewController *navi = [[BCDRedBGNaviViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:navi];
}


@end
