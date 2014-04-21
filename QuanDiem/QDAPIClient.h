//
//  QDAPIClient.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/08.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "SocketIO.h"

@interface QDAPIClient : AFHTTPRequestOperationManager<SocketIODelegate>

+ (instancetype)sharedClient;
@end
