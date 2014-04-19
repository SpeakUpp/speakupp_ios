//
//  QDCollectionOpinionLiteCell.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/19/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDCollectionOpinionLiteCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *opinionImage;
@property (weak, nonatomic) IBOutlet UILabel *opinionText;
@property (weak, nonatomic) IBOutlet UILabel *category;

@end
