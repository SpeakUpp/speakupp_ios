//
//  QDOpinionViewController.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/17/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDOpinionViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *opinionLabel;

@property (strong, nonatomic) NSMutableDictionary *opinion;

@end
