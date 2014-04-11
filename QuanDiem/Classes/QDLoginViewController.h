//
//  QDLoginViewController.h
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/9/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDLoginViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *labelEmail;
@property (weak, nonatomic) IBOutlet UITextField *labelPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwitter;
- (IBAction)touchFacebook:(id)sender;
- (IBAction)touchTwitter:(id)sender;
- (IBAction)touchLogin:(id)sender;

@end
