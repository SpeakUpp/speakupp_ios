//
//  QDTableCommentCell.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/17/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import "QDTableCommentCell.h"
#import "UIButton+AFNetworking.h"
#import "DTCoreText.h"

@implementation QDTableCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    // _buttonUser.layer.cornerRadius = 12;
}

- (void)setComment:(NSMutableDictionary *)comment {
    _comment = comment;
    [_buttonUser setImageForState:UIControlStateNormal withURL:[QDUtils urlForImage:comment[@"user"] ofSize:24]];
    _userName.text = comment[@"user"][@"displayName"];
    
    NSString *html = comment[@"bodyHtml"];
    NSData *data = [html dataUsingEncoding:NSUnicodeStringEncoding];
   
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"comment" ofType:@"css"];
    NSString *css = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    DTCSSStylesheet *dtCss = [[DTCSSStylesheet alloc] initWithStyleBlock:css];
    
    NSDictionary *options = @{DTUseiOS6Attributes: [NSNumber numberWithBool:YES],
                              DTDefaultFontFamily: @"Helvetica Neue-Light",
                              DTDefaultStyleSheet: dtCss};
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithHTMLData:data
                                                                          options:options
                                                               documentAttributes:nil];

    _commentText.attributedString = attrString;
    
    _labelPoint.text = [comment[@"score"] stringValue];
    _labelUpVote.text = [comment[@"agreeCount"] stringValue];
    _labelDownVote.text = [comment[@"disagreeCount"] stringValue];
    
    NSInteger score = [comment[@"score"] integerValue];
    NSString *scoreString;
    if (score > 1 ) {
        scoreString = [NSString stringWithFormat:NSLocalizedString(@"COUNT_POINTS", @"%d points"), score];
    } else {
        scoreString = [NSString stringWithFormat:NSLocalizedString(@"COUNT_POINT", @"%d point"), score];
    }
    _labelPoint.text = scoreString;
    
    NSInteger depth = [comment[@"depth"] integerValue];
    _constraintTitleMarginLeft.constant = 20 * depth;
    _constraintCommentMarginLeft.constant = 20 * depth;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    _constraintCommentHeight.constant = [_commentText suggestedFrameSizeToFitEntireStringConstraintedToWidth:_commentText.bounds.size.width].height;
    [_commentText relayoutText];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    //self.bodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bodyLabel.frame);
}

@end
