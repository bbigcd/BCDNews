//
//  SSADViewController.m
//  SocialSport
//
//  Created by XuYafei on 15/11/30.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "LPADViewController.h"
#import <UIImageView+WebCache.h>

#define ViewOrientationPortrait @"Portrait";
#define ViewOrientationLandscape @"Landscape";

@implementation LPADViewController {
    UIImageView *_backgroundView;
    CGFloat _offset;
    CGFloat _scale;
}

#pragma mark - Initialization

+ (instancetype)shareInstance {
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)initWithOffset:(CGFloat)offset orScale:(CGFloat)scale {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _offset = offset;
        _scale = scale;
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
        if (height == 480) {
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height - _offset)];
        } else {
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height * _scale)];
        }
        
        _backgroundView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundView.image = [self getLaunchImage];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    _offset = 108.0;
    _scale = 920.0 / 1136.0;
    return [self initWithOffset:_offset orScale:_scale];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_backgroundView];
    [self.view addSubview:_imageView];
}

#pragma mark - Accessor

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    if (height != 480) {
        _imageView.frame = CGRectMake(0, 0, width, height * _scale);
    }
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    if (height == 480) {
        _imageView.frame = CGRectMake(0, 0, width, height - _offset);
    }
}

#pragma mark - Private

- (UIImage *)getLaunchImage {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = ViewOrientationPortrait;
    NSString *launchImage = [NSString string];
    NSArray* imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dic in imagesDictionary) {
        CGSize imageSize = CGSizeFromString(dic[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dic[@"UILaunchImageOrientation"]]) {
            launchImage = dic[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImage];
}

@end
