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

+ (NSString*)friendlyDate:(NSString*)dateString {
    NSDateFormatter *dateMongo = [[NSDateFormatter alloc] init];
    [dateMongo setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSz"];
    NSDate *date = [dateMongo dateFromString:dateString];
    
    NSDateFormatter *dateFriendly = [[NSDateFormatter alloc] init];
    [dateFriendly setTimeStyle:NSDateFormatterNoStyle];
    [dateFriendly setDateStyle:NSDateFormatterMediumStyle];
    
    NSLocale *locale = [NSLocale currentLocale];
    [dateFriendly setLocale:locale];
    [dateFriendly setDoesRelativeDateFormatting:YES];
    NSString *ret = [dateFriendly stringFromDate:date];
    return ret;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(1, 1);
    //Create a context of the appropriate size
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0,0,size.width,size.height);
    
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    
    //Fill the color
    CGContextFillRect(currentContext, fillRect);
    
    //Snap the picture and close the context
    UIImage *retval = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retval;
}

@end
