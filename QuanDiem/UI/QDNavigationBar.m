//
//  QDNavigationBar.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/24/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import "QDNavigationBar.h"

@implementation QDNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    self.tintColor = nil;
    //[[UINavigationBar appearance] setBackgroundImage:[QDUtils imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    //self.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
