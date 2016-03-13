//
//  BCDNewsViewController.m
//  BCDNews
//
//  Created by bigcd on 16/3/6.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDNewsViewController.h"
#import "BCDNewsSubViewController.h"
#import "BCDHomeHeadButton.h"
#import "BCDLeftTagViewController.h"
#import "BCDRightTagViewController.h"
@interface BCDNewsViewController ()<UIScrollViewDelegate>

/** 顶部的所有标签 */
@property (nonatomic, weak) UIScrollView *titlesView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
/** 可变数组容器 */
@property (nonatomic, strong) NSMutableArray *viewArr;


@end

@implementation BCDNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 不自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    // 背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏标题 
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"top_navi_bell_normal" highImage:@"top_navi_bell_highlight" target:self action:@selector(clickLeftItem)];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"search_icon" highImage:@"search_icon" target:self action:@selector(clickRightItem)];
    
}
- (void)clickLeftItem
{
    BCDLeftTagViewController *vc = [[BCDLeftTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickRightItem
{
    BCDRightTagViewController *vc = [[BCDRightTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  初始化子控制器 -----------------------------------
 */
- (void)setupChidViewControlles{
    BCDNewsSubViewController *headline = [[BCDNewsSubViewController alloc] init];
    headline.title = @"头条";
    headline.type = BCDNewsTypeHeadline;
    [self addChildViewController:headline];
    BCDNewsSubViewController *recreation = [[BCDNewsSubViewController alloc] init];
    recreation.title = @"娱乐";
    recreation.type = BCDNewsTypeRecreation;
    [self addChildViewController:recreation];
    BCDNewsSubViewController *tiyu = [[BCDNewsSubViewController alloc] init];
    tiyu.title = @"体育";
    tiyu.type = BCDNewsTypeRecreation;
    [self addChildViewController:tiyu];
    BCDNewsSubViewController *hot = [[BCDNewsSubViewController alloc] init];
    hot.title = @"热点";
    hot.type = BCDNewsTypeRecreation;
    [self addChildViewController:hot];
    BCDNewsSubViewController *science = [[BCDNewsSubViewController alloc] init];
    science.title = @"科技";
    science.type = BCDNewsTypeRecreation;
    [self addChildViewController:science];
    BCDNewsSubViewController *caijin = [[BCDNewsSubViewController alloc] init];
    caijin.title = @"财经";
    caijin.type = BCDNewsTypeRecreation;
    [self addChildViewController:caijin];
    BCDNewsSubViewController *read = [[BCDNewsSubViewController alloc] init];
    read.title = @"阅读";
    read.type = BCDNewsTypeRecreation;
    [self addChildViewController:read];
    BCDNewsSubViewController *tuijian = [[BCDNewsSubViewController alloc] init];
    tuijian.title = @"推荐";
    tuijian.type = BCDNewsTypeRecreation;
    [self addChildViewController:tuijian];
    
}
/**
 *  设置顶部标签栏  -----------------------------------
 */
- (void)setupTitlesView
{
    CGFloat width = self.view.width / 5;
    CGFloat height = BCDTitilesViewH;
    
    
    // 标签栏整体
    UIScrollView *titlesView = ({
        UIScrollView *view = [[UIScrollView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.showsHorizontalScrollIndicator = NO;
        view.width = self.view.width - 40;
        view.height = height;
#warning 不知道怎么了，默认被调下了,这里有问题，不过用笨方法解决了
        view.x = BCDTitilesViewLeftW;
        view.y = 0;
        view.contentSize = CGSizeMake(width * self.childViewControllers.count, BCDTitilesViewH);
        [self.view addSubview:view];
        view;
    });
    self.titlesView = titlesView;
    
    // 内部子标签
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        BCDHomeHeadButton *button = [BCDHomeHeadButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x =   i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titlesClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            // 默认比例
            button.scale = 1.0;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
        }
    }
    // 左边
    UIImageView *leftVhutterIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_left_more"]];
    [self.view addSubview:leftVhutterIV];
    [leftVhutterIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(45, height));
    }];
    // 右边
    UIImageView *rightVhutterIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_right_more"]];
    [self.view addSubview:rightVhutterIV];
    [rightVhutterIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(BCDTitilesViewRightW, height));
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"home_header_add"] forState:UIControlStateNormal];
    [rightVhutterIV addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rightVhutterIV);
        make.right.mas_equalTo(5);
    }];
    
}
- (void)titlesClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
//    [UIView animateWithDuration:0.1 animations:^{
//        self.selectedButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    }];
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}
/**
 *  设置底部的scrollview  -----------------------------------
 */
- (void)setupContentView{
    
    UIScrollView *contentView = ({
        UIScrollView *view = [[UIScrollView alloc] init];
        view.delegate = self;
        view.frame = self.view.bounds;
        view.pagingEnabled = YES;
        [self.view insertSubview:view atIndex:0];
        view.contentSize = CGSizeMake(view.width * self.childViewControllers.count, 0);
        view;
    });
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    // 控制顶部对应的标题居中显示位置
    /** 居中公式：对应的中心点的x值-scrollView的一半*/
    BCDHomeHeadButton *label = self.titlesView.subviews[index];
    CGPoint titleOffset = self.titlesView.contentOffset;
    // 计算公式:对应的label的中心X值 - scrollView宽度的一半
    titleOffset.x = label.center.x - scrollView.frame.size.width * 0.5 + 35;
    
    /** 左边超出处理*/
    if (titleOffset.x < 0) titleOffset.x = 0;
    
    /** 右边超出处理*/
    CGFloat maxTitleOffsetX = self.titlesView.contentSize.width - scrollView.frame.size.width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    
    [self.titlesView setContentOffset:titleOffset animated:YES];
    
    [scrollView addSubview:vc.view];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titlesClick:self.titlesView.subviews[index]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 左边视图与右边视图占屏幕的比例
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    BCDHomeHeadButton *leftButton = self.titlesView.subviews[leftIndex];
    
    // 获得需要操作的右边label 并处理处理数组越界问题
    // titlesView里面不只有button
    NSInteger rightIndex = leftIndex + 1;
    BCDHomeHeadButton *rightButton = (rightIndex == self.titlesView.subviews.count - 1) ? nil: self.titlesView.subviews[rightIndex];
    
    //右边比例
    CGFloat rightScale = scale - leftIndex;
    //左边比例
    CGFloat leftScale = 1 - rightScale;
    //设置label的比例
    leftButton.scale = leftScale;
    rightButton.scale = rightScale;
}

@end







