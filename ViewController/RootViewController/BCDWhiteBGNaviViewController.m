//
//  BCDWhiteBGNaviViewController.m
//  BCDNews
//
//  Created by bigcd on 16/3/7.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDWhiteBGNaviViewController.h"

@interface BCDWhiteBGNaviViewController ()

@end

@implementation BCDWhiteBGNaviViewController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    // 当导航栏用在CDNavigationController中, appearance设置才会生效
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:back] forBarMetrics:UIBarMetricsDefault];
}
/**
 *  当前控制器“状态栏”对应的颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"top_navigation_back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"top_navigation_back_highlighted"] forState:UIControlStateSelected];
        button.size = CGSizeMake(45, 44);
        // 让按钮的内容往左边偏移10
        //        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
