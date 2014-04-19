//
//  QDLoginViewController.m
//  QuanDiem
//
//  Created by Xuan Dung Bui on 4/9/14.
//  Copyright (c) 2014 QuanDiem. All rights reserved.
//

#import "QDLoginViewController.h"
#import "QDAPIClient.h"
#import <FacebookSDK/FacebookSDK.h>

@interface QDLoginViewController ()

@end

@implementation QDLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchFacebook:(id)sender {
    [self openSession];
}

- (IBAction)touchTwitter:(id)sender {
}

- (IBAction)touchLogin:(id)sender {
    
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:{
            [[QDAPIClient sharedClient] POST:@"user/facebook" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
            } failure:nil];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:@[@"email"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self openSession];
        } else {
            
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            QDAPIClient *api = [QDAPIClient sharedClient];
            NSDictionary *params = @{@"email": _labelEmail.text,
                                     @"password": _labelPassword.text};
            [api POST:@"user/login" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *data) {
                NSLog(@"%@", data);
                [self dismissViewControllerAnimated:YES completion:nil];
            } failure:nil];
        }
    } else if (indexPath.section == 2) {
    }
}
@end
