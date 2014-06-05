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
#import "QDSocketIO.h"
#import "QDAPIClient.h"
#import "Underscore.h"

@implementation QDCollectionOpinionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // _opinionUserButton.layer.cornerRadius = 15;
    // _opinionUserButton2.layer.cornerRadius = 12;
    
    [_agreeButton setBackgroundImage:[QDUtils imageWithColor:[UIColor greenColor]] forState:UIControlStateSelected];
    [_disagreeButton setBackgroundImage:[QDUtils imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showStats) name:@"OpinionShowStats" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideStats) name:@"OpinionHideStats" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveOpinionUpdate:)
                                                     name:@"opinion:update"
                                                   object:nil];
    }
    return self;
}

- (void)receiveOpinionUpdate:(NSNotification*)notification {
    NSMutableDictionary *opinion = notification.object[@"opinion"];
    if (opinion && [opinion[@"_id"] isEqualToString:_opinion[@"_id"]]) {
        _opinion[@"voteCount"] = opinion[@"voteCount"];
        _opinion[@"commentCount"] = opinion[@"commentCount"];
        _opinion[@"agreePercent"] = opinion[@"agreePercent"];
        
        [self refreshUIWithAnimation:YES];
    }
}

- (void)showStats {
    if (_opinion[@"vote"]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             _constraintOverlay.constant = 40;
                             [self layoutIfNeeded];
                         }];
    }
}

- (void)hideStats {
    [UIView animateWithDuration:0.3
                     animations:^{
                         _constraintOverlay.constant = -55;
                         [self layoutIfNeeded];
                     }];

}

- (void)refreshUIWithAnimation:(BOOL)animate {
    _opinionTitleLabel.text = _opinion[@"title"];
    
    _opinionUserLabel.text = [NSString stringWithFormat:NSLocalizedString(@"POSTED_BY_NAME", @"Posted by @%d"), _opinion[@"user"][@"displayName"]];
    _opinionCreatedAtLabel.text = [QDUtils friendlyDate:_opinion[@"created"]];
    
    NSInteger commentCount = [_opinion[@"commentCount"] integerValue];
    NSString *commentString;
    if (commentCount > 1 ) {
        commentString = [NSString stringWithFormat:NSLocalizedString(@"COUNT_COMMENTS", @"%d comments"), commentCount];
    } else {
        commentString = [NSString stringWithFormat:NSLocalizedString(@"COUNT_COMMENT", @"%d comment"), commentCount];
    }
    
    NSInteger voteCount = [_opinion[@"voteCount"] integerValue];
    NSString *voteString;
    if (voteCount > 1 ) {
        voteString = [NSString stringWithFormat:NSLocalizedString(@"COUNT_VOTES", @"%d votes"), voteCount];
    } else {
        voteString = [NSString stringWithFormat:NSLocalizedString(@"COUNT_VOTE", @"%d vote"), voteCount];
    }
    
    _opinionStatsLabel.text = [NSString stringWithFormat:@"%@ / %@", commentString, voteString];
    
    _agreePercent.text = [NSString stringWithFormat:@"%d%%", [_opinion[@"agreePercent"] integerValue]];
    _disagreePercent.text = [NSString stringWithFormat:@"%d%%", [_opinion[@"disagreePercent"] integerValue]];
    
    if (animate) {
        CGFloat agreePercent = [_opinion[@"agreePercent"] floatValue] / 100.0 * 260.0;
        
        [UIView animateWithDuration:0.3 animations:^{
            _constraintVotePercent.constant = agreePercent;
            [self layoutIfNeeded];
        }];
    }

}

- (void)setOpinion:(NSMutableDictionary *)opinion {
    _opinion = opinion;
    
    [_opinionButton setBackgroundImageForState:UIControlStateNormal withURL:[QDUtils urlForImage:opinion ofSize:280]];
    [_opinionUserButton2 setImageForState:UIControlStateNormal withURL:[QDUtils urlForImage:opinion[@"user"] ofSize:24] placeholderImage:nil];
    [_opinionUserButton setImageForState:UIControlStateNormal withURL:[QDUtils urlForImage:opinion[@"user"] ofSize:30] placeholderImage:nil];
    
    [self refreshUIWithAnimation:NO];
    
    _agreeButton.selected = NO;
    _disagreeButton.selected = NO;
    if (_opinion[@"vote"]) {
        NSNumber *score = _opinion[@"vote"][@"score"];
        if ([score longValue] == 0) {
            _disagreeButton.selected = YES;
        } else {
            _agreeButton.selected = YES;
        }
    }
    
    CGFloat agreePercent = [opinion[@"agreePercent"] floatValue] / 100.0 * 260.0;
    
    _constraintVotePercent.constant = agreePercent;
    _constraintOverlay.constant = -55;
    
    QDSocketIO *socket = [QDSocketIO sharedClient];
    [socket sendEvent:@"opinion:join" withData:_opinion[@"_id"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchOpinion {
    
}

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
@end
