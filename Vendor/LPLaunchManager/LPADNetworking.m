//
//  LPNetworking.m
//  LPNetworkingDemo
//
//  Created by XuYafei on 15/12/26.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPADNetworking.h"

@implementation LPADNetworking {
    NSInteger _code;
    NSString *_message;
}

#pragma mark - Public

+ (instancetype)shareInstance {
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

+ (void)Get:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(LPNetworkRequestCompletionBlock)completionBlock {
    LPADNetworking *networking = [LPADNetworking shareInstance];
    [networking Request:URLString HTTPMethod:@"GET" parameters:parameters completion:completionBlock];
}

+ (void)Post:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(LPNetworkRequestCompletionBlock)completionBlock {
    LPADNetworking *networking = [LPADNetworking shareInstance];
    [networking Request:URLString HTTPMethod:@"POST" parameters:parameters completion:completionBlock];
}

#pragma mark - Private

- (void)Request:(NSString *)URLString HTTPMethod:(NSString *)HTTPMethod parameters:(NSDictionary *)parameters completion:(LPNetworkRequestCompletionBlock)completionBlock {
    NSMutableURLRequest *request;
    if ([HTTPMethod isEqualToString:@"POST"]) {
        NSURL *URL = [NSURL URLWithString:URLString];
        request = [NSMutableURLRequest requestWithURL:URL];
        NSMutableDictionary *JSONDictionary = [NSMutableDictionary dictionary];
        
        [JSONDictionary setObject:@"iOS" forKey:@"header"];
        if (parameters) {
            [JSONDictionary setDictionary:parameters];
        }
        NSData *postData = [NSJSONSerialization dataWithJSONObject:JSONDictionary options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:postData];
        [request setHTTPMethod:HTTPMethod];
    } else if ([HTTPMethod isEqualToString:@"GET"]) {
        NSURL *URL = [NSURL URLWithString:[self integrateParams:parameters toURL:URLString]];
        request = [NSMutableURLRequest requestWithURL:URL];
        [request setHTTPMethod:HTTPMethod];
    }
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *result = [NSDictionary dictionary];
        if (data) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                result = (NSDictionary *)jsonObject;
            }
        }
        
        if (result[@"code"]) {
            _code = [result[@"code"] integerValue];
        }
        if (result[@"msg"]) {
            _message = result[@"msg"];
        }
        
        if (completionBlock) {
            completionBlock(result, response, error);
        }
    }];
    [sessionDataTask resume];
    
}

- (NSString *)integrateParams:(NSDictionary *)params toURL:(NSString *)URL {
    NSMutableString *string = [URL mutableCopy];
    for (int i = 0; i < params.count; i++) {
        NSString *key = params.allKeys[i];
        NSString *value = params[key];
        if (i) {
            [string appendFormat:@"?%@=%@", key, value];
        } else {
            [string appendFormat:@"&%@=%@", key, value];
        }
    }
    return string;
}

@end
