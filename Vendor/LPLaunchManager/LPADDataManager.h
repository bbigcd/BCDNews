//
//  LPADDataManager.h
//  LPADViewControllerDemo
//
//  Created by XuYafei on 15/9/28.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPADDataManager : NSObject

+ (instancetype)sharedInstance;

+ (NSArray *)getCacheData;
+ (void)setCacheData:(NSArray *)array;
+ (void)addNotification:(NSDictionary *)dictionary;

@end
