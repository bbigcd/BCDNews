//
//  BCDHomeHeadButton.m
//  BCDNews
//
//  Created by bigcd on 16/3/12.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "BCDHomeHeadButton.h"
//默认最开始的RGB

#define CDRed  0.4
#define CDGreen  0.6
#define CDBlue  0.7
@implementation BCDHomeHeadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        /** 初始状态的label文字大小*/
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        /** 文字颜色对应的RGB*/
        self.tintColor = [UIColor colorWithRed:CDRed green:CDGreen blue:CDBlue alpha:1.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        /** 文字居中*/
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
/**
 *  重写scale的set方法
 */
- (void)setScale:(CGFloat)scale{
    _scale = scale;
    
    //色素    R    G     B
    //黑色    0    0     0
    //红色    1    0     0
    //绿色    0    1     0
    //蓝色    0    0     1
    //黄色    1    1     0
    
    CGFloat red = CDRed + (1 - CDRed) * scale;
    CGFloat green = CDGreen + (0 - CDGreen) * scale;
    CGFloat blue = CDBlue + (0 - CDBlue) * scale;
    
    
    self.tintColor  = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    //大小缩放比例
    CGFloat transformScale = 1 + scale * 0.3;//[1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end
