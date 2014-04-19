//
//  QDCollectionOpinionCell.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/08.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDCollectionOpinionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *opinionButton;

@property (weak, nonatomic) IBOutlet UILabel *agreePercent;
@property (weak, nonatomic) IBOutlet UILabel *disagreePercent;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *disagreeButton;
@property (weak, nonatomic) IBOutlet UILabel *opinionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *opinionStatsLabel;
@property (weak, nonatomic) IBOutlet UILabel *opinionUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *opinionCreatedAtLabel;
@property (weak, nonatomic) IBOutlet UIButton *opinionUserButton;
@property (weak, nonatomic) IBOutlet UIButton *opinionUserButton2;
@property (weak, nonatomic) IBOutlet UIView *agreeBar;
@property (weak, nonatomic) IBOutlet UIView *voteBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOverlay;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintVotePercent;

@property (weak, nonatomic) NSMutableDictionary *opinion;
- (IBAction)touchAgree:(id)sender;
- (IBAction)touchDisagree:(id)sender;

@end
