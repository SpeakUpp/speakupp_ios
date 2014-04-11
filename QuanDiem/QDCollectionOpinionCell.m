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
#import "QDAPIClient.h"

@implementation QDCollectionOpinionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showStats) name:@"OpinionShowStats" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideStats) name:@"OpinionHideStats" object:nil];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    [_agreeButton setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forState:UIControlStateSelected];
    [_disagreeButton setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
}

- (void)showStats {
    if (_opinion[@"vote"]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             _constraintOverlay.constant = 40;
                             [self layoutIfNeeded]; // Called on parent view
                         }];
    }
}

- (void)hideStats {
    [UIView animateWithDuration:0.3
                     animations:^{
                         _constraintOverlay.constant = -55;
                         [self layoutIfNeeded]; // Called on parent view
                     }];

}

- (void)setOpinion:(NSMutableDictionary *)opinion {
    _opinion = opinion;
    
    NSString* opinionImageURL = [NSString stringWithFormat:@"%@%@%@", opinion[@"image"][@"cdnUri"],@"2x280-", opinion[@"image"][@"file"]];
    NSString* userImageURL = [NSString stringWithFormat:@"%@%@%@", opinion[@"user"][@"image"][@"cdnUri"],@"2x24-", opinion[@"user"][@"image"][@"file"]];
    NSString* userImage30URL = [NSString stringWithFormat:@"%@%@%@", opinion[@"user"][@"image"][@"cdnUri"],@"2x30-", opinion[@"user"][@"image"][@"file"]];
    
    [_opinionImageView setImageWithURL:[NSURL URLWithString:opinionImageURL] placeholderImage:nil];
    [_userImageView setImageWithURL:[NSURL URLWithString:userImageURL] placeholderImage:nil];
    [_opinionUserButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:userImage30URL] placeholderImage:nil];
    _opinionTitleLabel.text = _opinion[@"title"];

    _opinionUserButton.layer.cornerRadius = 15;
    _opinionUserButton.layer.masksToBounds = YES;
    _userImageView.layer.cornerRadius = 12;
    _userImageView.layer.masksToBounds = YES;
    
    _agreeButton.selected = NO;
    _disagreeButton.selected = NO;
    
    _constraintOverlay.constant = -55;

    if (_opinion[@"vote"]) {
        NSNumber *score = _opinion[@"vote"][@"score"];
        if ([score longValue] == 0) {
            _disagreeButton.selected = YES;
        } else {
            _agreeButton.selected = YES;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (IBAction)touchAgree:(id)sender {
    NSDictionary *tmp = _opinion[@"vote"];
    if (_opinion[@"vote"]) {
        NSNumber *score = _opinion[@"vote"][@"score"];
        if ([score longValue] == 0) {
            _disagreeButton.selected = NO;
            _agreeButton.selected = YES;
            _opinion[@"vote"] = @{@"score": [NSNumber numberWithInt:1]};
        } else {
            _agreeButton.selected = NO;
            [_opinion removeObjectForKey:@"vote"];
        }
    } else {
        _agreeButton.selected = YES;
        _opinion[@"vote"] = @{@"score": [NSNumber numberWithInt:1]};
    }
    
    [self showStats];
    
    QDAPIClient *api = [QDAPIClient sharedClient];
    NSString *url = [NSString stringWithFormat:@"opinion/%@/vote", _opinion[@"id"]];
    [api POST:url parameters:@{@"score": [NSNumber numberWithInt:1]} success:nil failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _opinion[@"vote"] = tmp;
    }];
}

- (IBAction)touchDisagree:(id)sender {
    NSDictionary *tmp = _opinion[@"vote"];
    if (_opinion[@"vote"]) {
        NSNumber *score = _opinion[@"vote"][@"score"];
        if ([score longValue] == 1) {
            _disagreeButton.selected = YES;
            _agreeButton.selected = NO;
            _opinion[@"vote"] = @{@"score": [NSNumber numberWithInt:0]};
        } else {
            _disagreeButton.selected = NO;
            [_opinion removeObjectForKey:@"vote"];
        }
    } else {
        _disagreeButton.selected = YES;
        _opinion[@"vote"] = @{@"score": [NSNumber numberWithInt:0]};
    }
    
    [self showStats];
    
    QDAPIClient *api = [QDAPIClient sharedClient];
    NSString *url = [NSString stringWithFormat:@"opinion/%@/vote", _opinion[@"id"]];
    [api POST:url parameters:@{@"score": [NSNumber numberWithInt:0]} success:nil failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _opinion[@"vote"] = tmp;
    }];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
