//
//  UIBarButtonItem+BCDExtension.h
//  BCDNews
//
//  Created by bigcd on 16/3/7.
//  Copyright © 2016年 bbigcd. All rights reserved.
//  自定义UIBarButtonItem分类

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BCDExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
