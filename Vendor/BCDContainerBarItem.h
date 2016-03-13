//
//  BCDContainerBarItem.h
//  BCDNews
//
//  Created by bigcd on 16/3/12.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum BCDBarItemStyle
{
    TITLE_SHOW, //首页展示类型
    EDIT_SHOW,  //编辑展示类型
    ADD_SHOW    //编辑添加展示类型
}BCDBarItemStyle;

@class BCDContainerBarItem;

@protocol BCDContainerBarDelegate <NSObject>

@optional
- (void)ContainerBarItem:(BCDContainerBarItem *)barItem clickIndex:(NSInteger)index animated:(BOOL)animated;
- (void)ContainerBarItem:(BCDContainerBarItem *)barItem clickDeleteBtn:(UIButton *)sender index:(NSInteger)index;

@end

@interface BCDContainerBarItem : UIView
/** delegate*/
@property (nonatomic, assign) id<BCDContainerBarDelegate> delegate;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 下标*/
@property (nonatomic, assign) NSInteger index;
/** 正常字体的大小*/
@property (nonatomic, assign) CGFloat normalFontSize;
/** 选择时字体大小*/
@property (nonatomic, assign) CGFloat selectedFontSize;
/** 是否被选中*/
@property (nonatomic, assign) BOOL selected;


/** 正常标题颜色 */
@property (nonatomic, strong) UIColor *normalTitleColor;
/** 选择标题颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;
/** 正常背景颜色 */
@property (nonatomic, strong) UIColor *normalBackgroundColor;
/** 选择背景颜色 */
@property (nonatomic, strong) UIColor *selectedBackgroundColor;

- (instancetype)initWithFrame:(CGRect)frame style:(BCDBarItemStyle)style;

- (void)dynamicChangeBackgroudColor:(UIColor *)color;

- (void)dynamicChangeTextColor:(UIColor *)color;

- (void)dynamicChangeTextSize:(UIFont *)font;

- (void)setItemStyle:(BCDBarItemStyle)style;

- (void)startEdit;

- (void)stopEdit;
@end
