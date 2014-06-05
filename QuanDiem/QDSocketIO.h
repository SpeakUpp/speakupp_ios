//
//  QDSocketIO.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/23/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"

@interface QDSocketIO : SocketIO<SocketIODelegate>

+ (instancetype)sharedClient;

@end
