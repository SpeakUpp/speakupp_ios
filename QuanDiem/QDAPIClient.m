//
//  QDAPIClient.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/08.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import "QDAPIClient.h"

#ifdef DEBUG
static NSString * const AFAppDotNetAPIBaseURLString = @"http://dev.quandiem.net:3000/api/";
#else
static NSString * const AFAppDotNetAPIBaseURLString = @"http://quandiem.net/api/";
#endif

@implementation QDAPIClient

+ (instancetype)sharedClient {
    static QDAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[QDAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions: NSJSONReadingMutableContainers];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    });
    
    return _sharedClient;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    return [super POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:error.description
                                                       delegate:self
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

@end
