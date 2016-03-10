//
//  LPLaunchManager.h
//  LPLaunchManagerDemo
//
//  Created by XuYafei on 15/12/29.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPLaunchManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, assign) NSTimeInterval duration;

typedef void (^DisappearHandler)(void);

+ (void)showAdvertWithURL:(NSString *)URL
         disappearHandler:(DisappearHandler)disappearHandler;

typedef void (^ConfigurationHandler)(UIButton *button);
typedef void (^CompletionHandler)(void);
+ (void)showSkipButton:(ConfigurationHandler)configurationHandler
             completed:(CompletionHandler)completionHandler;

@property (nonatomic, assign) CGFloat advertOffset;

@property (nonatomic, assign) CGFloat advertScale;

@end
