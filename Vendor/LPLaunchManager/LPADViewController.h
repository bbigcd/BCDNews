//
//  SSADViewController.h
//  SocialSport
//
//  Created by XuYafei on 15/11/30.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPADViewController : UIViewController

+ (instancetype)shareInstance;
- (instancetype)initWithOffset:(CGFloat)offset orScale:(CGFloat)scale;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) CGFloat scale;

@end
