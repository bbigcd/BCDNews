//
//  BCDContainerBarItem.m
//  BCDNews
//
//  Created by bigcd on 16/3/12.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDContainerBarItem.h"

/** 删除按钮尺寸 */
#define BCD_DeleteButtonSize (15.0)

@interface BCDContainerBarItem ()

/** 按钮样式 */
@property (nonatomic, assign) BCDBarItemStyle itemStyle;
/** 选项按钮 */
@property (nonatomic, strong) UIButton *barItemBtn;
/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;
/** 单击手势 */
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation BCDContainerBarItem
- (instancetype)initWithFrame:(CGRect)frame style:(BCDBarItemStyle)style
{
    if (self = [super initWithFrame:frame]) {
        self.itemStyle = style;
        [self initUILayout];
    }
    return self;
}
- (void)initSet
{
    self.barItemBtn.backgroundColor = [UIColor whiteColor];
    self.barItemBtn.layer.cornerRadius = self.height / 2.0;
    self.barItemBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.barItemBtn.layer.borderWidth = 0.5;
    self.barItemBtn.layer.masksToBounds = YES;
}
- (void)initUILayout
{
    self.backgroundColor = [UIColor clearColor];
    self.barItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.barItemBtn.frame = self.bounds;
    [self.barItemBtn addTarget:self action:@selector(clickBatItem:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.barItemBtn];
    
    if (self.itemStyle == ADD_SHOW || self.itemStyle == EDIT_SHOW) {
        [self initSet];
        if (self.itemStyle == EDIT_SHOW) {
            [self addDeleteButton];
        }
    }
}
- (void)addDeleteButton
{
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(0, -1.0, BCD_DeleteButtonSize, BCD_DeleteButtonSize);
    self.deleteBtn.backgroundColor = [UIColor grayColor];
    self.deleteBtn.layer.cornerRadius = BCD_DeleteButtonSize / 2.0;
    self.deleteBtn.layer.masksToBounds = YES;
    [self.deleteBtn setTitle:@"×" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
    self.deleteBtn.hidden = YES;
}
#pragma mark - propertyOverride -
- (void)setItemStyle:(BCDBarItemStyle)style
{
    self.itemStyle = style;
    if (self.itemStyle == EDIT_SHOW) {
        if (self.deleteBtn) {
            if (![self.subviews containsObject:self.barItemBtn]) {
                [self addSubview:self.deleteBtn];
            }else{
                [self addDeleteButton];
            }
        }else{
            if (self.deleteBtn) {
                if ([self.subviews containsObject:self.barItemBtn]) {
                    [self.deleteBtn removeFromSuperview];
                }
                self.deleteBtn = nil;
            }
        }
    }
}
- (void)setTitle:(NSString *)title
{
    if (title == nil) {
        title = @"";
    }
    self.title = nil;
    self.title = title;
    [self.barItemBtn setTitle:self.title forState:UIControlStateNormal];
}
- (void)setIndex:(NSInteger)index
{
    self.index = index;
    self.barItemBtn.tag = index;
}
- (void)setNormalFontSize:(CGFloat)normalFontSize
{
    self.normalFontSize = normalFontSize;
    self.barItemBtn.titleLabel.font = [UIFont boldSystemFontOfSize:self.normalFontSize];
}
- (void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    self.normalTitleColor = nil;
    self.normalTitleColor = normalTitleColor;
    [self.barItemBtn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
}
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    self.selectedTitleColor = nil;
    self.selectedTitleColor = selectedTitleColor;
}

- (void)dynamicChangeBackgroudColor:(UIColor *)color{
    self.barItemBtn.backgroundColor = color;
}

- (void)dynamicChangeTextColor:(UIColor *)color{
    [self.barItemBtn setTitleColor:color forState:UIControlStateNormal];
}

- (void)dynamicChangeTextSize:(UIFont *)font{
    self.barItemBtn.titleLabel.font = font;
}

- (void)startEdit
{
    self.deleteBtn.hidden = NO;
}
- (void)stopEdit
{
    self.deleteBtn.hidden = YES;
}
#pragma mark - barItemAction -
- (void)clickBarItem:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ContainerBarItem: clickIndex: animated:)]) {
        [self.delegate ContainerBarItem:self clickIndex:sender.tag animated:YES];
    }
}
- (void)clickDeleteBtn:(UIButton*)sender{
    sender.tag = self.index;
    if(self.delegate && [self.delegate respondsToSelector:@selector(ContainerBarItem:clickDeleteBtn: index:)]){
        [self.delegate ContainerBarItem:self clickDeleteBtn:sender index:self.index];
    }
}
#pragma mark - other - 
- (void)setSelected:(BOOL)selected
{
    self.barItemBtn.selected = selected;
    if (selected) {
        [self dynamicChangeTextSize:[UIFont boldSystemFontOfSize:self.selectedFontSize]];
        [self dynamicChangeTextColor:self.selectedTitleColor];
        self.barItemBtn.backgroundColor = self.selectedBackgroundColor;
    }else{
        [self dynamicChangeTextSize:[UIFont boldSystemFontOfSize:self.normalFontSize]];
        [self dynamicChangeTextColor:self.normalTitleColor];
        self.barItemBtn.backgroundColor = self.normalBackgroundColor;
    }
}

- (BOOL)selected
{
    return self.barItemBtn.selected;
}





@end
