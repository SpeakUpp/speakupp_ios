//
//  QDCollectionOpinionCell.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 2013/11/08.
//  Copyright (c) 2013年 QuanDiem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDCollectionOpinionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *opinionImageView;
@property (strong, nonatomic) IBOutlet UIButton *agreeButton;
@property (strong, nonatomic) IBOutlet UIButton *disagreeButton;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *opinionTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *opinionStatsLabel;
@property (strong, nonatomic) IBOutlet UILabel *opinionUserLabel;
@property (strong, nonatomic) IBOutlet UILabel *opinionCreatedAtLabel;
@property (strong, nonatomic) IBOutlet UIButton *opinionUserButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOverlay;

@property (strong, nonatomic) NSMutableDictionary *opinion;
- (IBAction)touchAgree:(id)sender;
- (IBAction)touchDisagree:(id)sender;

@end
