//
//  QDAPIClient.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/08.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface QDAPIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;
@end
