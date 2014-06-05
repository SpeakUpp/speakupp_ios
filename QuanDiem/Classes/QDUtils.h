//
//  QDUtils.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/17/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDUtils : NSObject

+ (NSURL*)urlForImage:(NSDictionary*)object ofSize:(NSInteger)size;
+ (NSString*)friendlyDate:(NSString*)dateString;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
