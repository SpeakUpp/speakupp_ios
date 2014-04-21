//
//  QDAPIClient.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/08.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//
    
#import "QDAPIClient.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "SocketIOPacket.h"

#ifdef DEBUG
static NSString * const AFAppDotNetAPIBaseURLString = @"http://dev.quandiem.net:3000/api/";
static NSString * const SocketIOHost = @"dev.quandiem.net";
static NSInteger const SocketIOPort = 3000;
#else
static NSString * const AFAppDotNetAPIBaseURLString = @"http://quandiem.net/api/";
static NSString * const SocketIOHost = @"quandiem.net";
static NSInteger const SocketIOPort = 80;
#endif

@implementation QDAPIClient

+ (instancetype)sharedClient {
    static QDAPIClient *_sharedClient = nil;
    static SocketIO *_socketIO = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[QDAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions: NSJSONReadingMutableContainers];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        // Websocket
        _socketIO = [[SocketIO alloc] initWithDelegate:_sharedClient];
        [_socketIO connectToHost:SocketIOHost onPort:SocketIOPort];
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

- (void) socketIODidConnect:(SocketIO *)socket {
    NSLog(@"Opened");
}
- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error {
    NSLog(@"Disconnected");
}
- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet {
    NSLog(@"Got message");
}
- (void) socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet {
    NSLog(@"Got JSON");
}
- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    NSNotificationCenter *notifier = [NSNotificationCenter defaultCenter];
    [notifier postNotificationName:packet.name object:packet.dataAsJSON[@"args"][0]];
}
- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet {
    NSLog(@"Sent Event");
}
- (void) socketIO:(SocketIO *)socket onError:(NSError *)error {
    NSLog(@"Error");
}

@end
