//
//  QDTableCommentCell.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/17/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTCoreText.h"

@interface QDTableCommentCell : UITableViewCell<DTAttributedTextContentViewDelegate>
@property (strong, nonatomic) NSMutableDictionary *comment;
@property (weak, nonatomic) IBOutlet DTAttributedTextContentView *commentText;
@property (weak, nonatomic) IBOutlet UIButton *buttonUser;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTitleMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCommentMarginLeft;
@property (weak, nonatomic) IBOutlet UILabel *labelUpVote;
@property (weak, nonatomic) IBOutlet UILabel *labelPoint;
@property (weak, nonatomic) IBOutlet UILabel *labelDownVote;


@end
