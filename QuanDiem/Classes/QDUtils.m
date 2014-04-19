//
//  QDUtils.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/17/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import "QDUtils.h"

@implementation QDUtils


+ (NSURL*)urlForImage:(NSDictionary*)object ofSize:(NSInteger)size; {
    NSString *url = [NSString stringWithFormat:@"%@2x%d-%@", object[@"image"][@"cdnUri"], size, object[@"image"][@"file"]];
    return [NSURL URLWithString:url];
}

@end
