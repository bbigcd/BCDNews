//
//  LPNetworking.h
//  LPNetworkingDemo
//
//  Created by XuYafei on 15/12/26.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPADNetworking : NSObject

typedef void (^LPNetworkRequestCompletionBlock)(NSDictionary *result,  NSURLResponse *response, NSError *error);

+ (void)Get:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(LPNetworkRequestCompletionBlock)completionBlock;

+ (void)Post:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(LPNetworkRequestCompletionBlock)completionBlock;

@end
