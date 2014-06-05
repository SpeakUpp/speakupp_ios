//
//  QDSocketIO.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/23/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import "QDSocketIO.h"
#import "SocketIOPacket.h"

#ifdef DEBUG
static NSString * const SocketIOHost = @"dev.quandiem.net";
static NSInteger const SocketIOPort = 3000;
#else
static NSString * const SocketIOHost = @"quandiem.net";
static NSInteger const SocketIOPort = 80;
#endif

@implementation QDSocketIO

+ (instancetype)sharedClient {
    static QDSocketIO *_socketIO = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Websocket
        _socketIO = [[QDSocketIO alloc] init];
        _socketIO.delegate = _socketIO;
        [_socketIO connectToHost:SocketIOHost onPort:SocketIOPort];
    });
    
    return _socketIO;
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
    for (id object in packet.dataAsJSON[@"args"]) {
        [notifier postNotificationName:packet.name object:object];
    }
    
}
- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet {
    NSLog(@"Sent Event");
}
- (void) socketIO:(SocketIO *)socket onError:(NSError *)error {
    NSLog(@"Error");
}


@end
