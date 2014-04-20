//
//  QDVoteButton.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/20/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import "QDVoteButton.h"

@implementation QDVoteButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0, 1);
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
