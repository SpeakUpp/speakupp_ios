//
//  QDCollectionOpinionCell.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/08.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import "QDCollectionOpinionCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"

@implementation QDCollectionOpinionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setOpinion:(NSDictionary *)opinion {
    NSString* opinionImageURL = [NSString stringWithFormat:@"%@%@%@", opinion[@"image"][@"cdnUri"],@"2x280-", opinion[@"image"][@"file"]];
    NSString* userImageURL = [NSString stringWithFormat:@"%@%@%@", opinion[@"user"][@"image"][@"cdnUri"],@"2x24-", opinion[@"user"][@"image"][@"file"]];
    NSString* userImage30URL = [NSString stringWithFormat:@"%@%@%@", opinion[@"user"][@"image"][@"cdnUri"],@"2x30-", opinion[@"user"][@"image"][@"file"]];
    
    [_opinionImageView setImageWithURL:[NSURL URLWithString:opinionImageURL]];
    [_userImageView setImageWithURL:[NSURL URLWithString:userImageURL]];
    [_opinionUserButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:userImage30URL]];
    _opinionTitleLabel.text = opinion[@"title"];

    _opinionUserButton.layer.cornerRadius = 15;
    _opinionUserButton.layer.masksToBounds = YES;
    _userImageView.layer.cornerRadius = 12;
    _userImageView.layer.masksToBounds = YES;
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
