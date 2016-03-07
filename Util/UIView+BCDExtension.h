//
//  UIView+BCDExtension.h
//  BCDNews
//
//  Created by bigcd on 16/3/7.
//  Copyright © 2016年 bbigcd. All rights reserved.
//  对UIView的frame重写的分类，优化

#import <UIKit/UIKit.h>

@interface UIView (BCDExtension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

+ (instancetype)viewFromXib;
@end
