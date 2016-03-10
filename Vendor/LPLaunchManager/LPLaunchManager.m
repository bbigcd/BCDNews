//
//  LPLaunchManager.m
//  LPLaunchManagerDemo
//
//  Created by XuYafei on 15/12/29.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPLaunchManager.h"
#import "LPADNetworking.h"
#import "LPADDataManager.h"
#import "LPADViewController.h"
#import <UIImageView+WebCache.h>

@implementation LPLaunchManager {
    UIWindow *_window;
    NSTimer *_timer;
    DisappearHandler _disappearHandler;
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _duration = 3.0;
    }
    return self;
}

+ (instancetype)shareInstance {
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

+ (void)showAdvertWithURL:(NSString *)URL
         disappearHandler:(DisappearHandler)disappearHandler {
    LPLaunchManager *launchManager = [LPLaunchManager shareInstance];
    LPADViewController *viewController = [LPADViewController shareInstance];
    launchManager->_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    launchManager->_window.windowLevel = pow(10, 6);
    launchManager->_disappearHandler = disappearHandler;
    
    NSArray *adArray = [LPADDataManager getCacheData];
    NSString *imageURL = [NSString string];
    if (adArray && adArray.count > 0) {
        imageURL = [adArray[0] objectForKey:@"image"];
        viewController.imageView.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];
        launchManager->_window.rootViewController = viewController;
        [launchManager->_window makeKeyAndVisible];
        [launchManager beginTimer];
    } else {
        if (launchManager->_disappearHandler) {
            launchManager->_disappearHandler();
        }
    }
    
    [LPADNetworking Get:URL parameters:nil completion:^(NSDictionary *result, NSURLResponse *response, NSError *error) {
        if (result[@"data"] != NSNull.null && [(NSArray *)result[@"data"] count] > 0) {
            NSString *newImageURLString = [result[@"data"] objectForKey:@"image"];
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:newImageURLString] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                [LPADDataManager setCacheData:@[result[@"data"]]];
            }];
        }
    }];
}

+ (void)showSkipButton:(ConfigurationHandler)configurationHandler
             completed:(CompletionHandler)completionHandler {
    LPADViewController *viewController = [LPADViewController shareInstance];
    CGRect frame = CGRectMake(CGRectGetWidth(viewController.view.frame) - 93, 28,
                              65, 30);
    UIButton *skipButton = [[UIButton alloc] initWithFrame:frame];
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
    skipButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    skipButton.layer.cornerRadius = 5;
    skipButton.layer.masksToBounds = YES;
    [skipButton addTarget:[self shareInstance] action:@selector(skipButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    if (configurationHandler) {
        configurationHandler(skipButton);
    }
    [viewController.view addSubview:skipButton];
}

#pragma mark - Accessor

- (void)setAdvertOffset:(CGFloat)advertOffset {
    _advertOffset = advertOffset;
    [[LPADViewController shareInstance] setOffset:_advertOffset];
}

- (void)setAdvertScale:(CGFloat)advertScale {
    _advertScale = advertScale;
    [[LPADViewController shareInstance] setScale:_advertScale];
}

#pragma mark - Timer

- (void)beginTimer {
    _timer = [NSTimer timerWithTimeInterval:_duration
                                     target:self
                                   selector:@selector(timerFired)
                                   userInfo:nil
                                    repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer
                                 forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)timerFired {
    if (_disappearHandler) {
        _disappearHandler();
    }
    [UIView animateWithDuration:0.25 animations:^{
        _window.alpha = 0;
    } completion:^(BOOL finished) {
        _window = nil;
    }];
    [self stopTimer];
}

#pragma mark - Action

- (void)skipButtonAction:(UIButton *)button {
    [self timerFired];
}

@end
